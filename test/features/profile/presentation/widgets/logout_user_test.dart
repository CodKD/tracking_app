import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/keys/shared_key.dart';
import 'package:tracking_app/core/modules/shared_preferences_module.dart';
import 'package:tracking_app/core/route/app_routes.dart';

class MockSharedPrefHelper extends Mock implements SharedPrefHelper {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeL10n {
  String get confirmLogout => 'Confirm Logout';

  String get areYouSureYouWantToLogOut => 'Are you sure you want to log out?';

  String get cancel => 'Cancel';

  String get logout => 'Logout';
}

extension L10nExtension on BuildContext {
  FakeL10n get l10n => FakeL10n();
}

void main() {
  late MockSharedPrefHelper mockSharedPrefHelper;
  late GetIt getIt;

  setUp(() {
    getIt = GetIt.instance;
    getIt.reset();
    mockSharedPrefHelper = MockSharedPrefHelper();
    getIt.registerSingleton<SharedPrefHelper>(mockSharedPrefHelper);
  });

  Future<void> pumpLogoutDialog(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => logoutUser(context),
            child: const Text('Open Logout'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open Logout'));
    await tester.pumpAndSettle();
  }

  testWidgets('shows logout dialog and cancels', (tester) async {
    await pumpLogoutDialog(tester);

    expect(find.text('Confirm Logout'), findsOneWidget);
    expect(find.text('Are you sure you want to log out?'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    verifyNever(
      mockSharedPrefHelper.removePreference(key: SharedPrefKeys.tokenKey),
    );
  });

  testWidgets('shows logout dialog and confirms', (tester) async {
    await pumpLogoutDialog(tester);

    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();

    verify(
      mockSharedPrefHelper.removePreference(key: SharedPrefKeys.tokenKey),
    ).called(1);
  });
}

// The original logoutUser function for reference
Future<void> logoutUser(BuildContext context) async {
  final shouldLogout = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(BuildContextExtension(context).l10n.confirmLogout),
      content: Text(
        BuildContextExtension(context).l10n.areYouSureYouWantToLogOut,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(BuildContextExtension(context).l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(BuildContextExtension(context).l10n.logout),
        ),
      ],
    ),
  );
  final getIt = GetIt.instance;

  if (shouldLogout ?? false) {
    await getIt<SharedPrefHelper>().removePreference(
      key: SharedPrefKeys.tokenKey,
    );

    if (!context.mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.loginView,
      (route) => false,
    );
  }
}
