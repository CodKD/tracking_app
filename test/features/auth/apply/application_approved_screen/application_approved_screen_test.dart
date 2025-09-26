import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tracking_app/core/l10n/app_localizations.dart';
import 'package:tracking_app/core/route/app_routes.dart';
import 'package:tracking_app/core/utils/components/custom_button.dart';
import 'package:tracking_app/features/auth/apply/presentation/view/application_approved_screen.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockNavigatorObserver mockObserver;

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  Widget createTestWidget({bool withRoutes = true}) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      navigatorObservers: withRoutes ? [mockObserver] : [],
      routes: withRoutes
          ? {
              AppRoutes.loginView: (_) =>
                  const Scaffold(body: Center(child: Text('Login Screen'))),
            }
          : {},
      home: const ApplicationApprovedScreen(),
    );
  }

  group('ApplicationApprovedScreen Widget Test', () {
    testWidgets('renders all widgets correctly', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createTestWidget(withRoutes: false));
      await tester.pumpAndSettle();

      // Assert - Check for SVG pictures
      expect(find.byType(SvgPicture), findsNWidgets(2));

      // Check for localized text content (partial matches)
      expect(find.textContaining('submitted'), findsOneWidget);
      expect(find.textContaining('Thank you'), findsOneWidget);

      // Check for custom button
      expect(find.byType(CustomButton), findsOneWidget);
    });

    testWidgets('button can be tapped without errors', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Act & Assert - Verify button can be found and tapped without exceptions
      final buttonFinder = find.byType(CustomButton);
      expect(buttonFinder, findsOneWidget);

      // Tap the button (this will test the onPressed callback)
      await tester.tap(buttonFinder, warnIfMissed: false);
      await tester.pumpAndSettle();

      // If we get here without exceptions, the button tap worked
      expect(buttonFinder, findsNothing);
    });

    testWidgets('button has correct style and properties', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(createTestWidget(withRoutes: false));
      await tester.pumpAndSettle();

      // Act & Assert
      final button = tester.widget<CustomButton>(find.byType(CustomButton));

      expect(button.size!.width, greaterThan(100));
      expect(button.borderRadius, 100);

      // Check for login text in button
      expect(find.text('Login'), findsOneWidget);
    });
  });
}
