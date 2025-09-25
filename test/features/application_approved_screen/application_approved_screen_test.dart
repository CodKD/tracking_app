import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tracking_app/core/route/app_routes.dart';
import 'package:tracking_app/core/utils/components/custom_button.dart';
import 'package:tracking_app/features/application_approved/application_approved_screen.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockNavigatorObserver mockObserver;

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  group('ApplicationApprovedScreen Widget Test', () {
    testWidgets('renders all widgets correctly and navigates on button press', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          navigatorObservers: [mockObserver],
          routes: {
            AppRoutes.loginView: (_) =>
                const Scaffold(body: Center(child: Text('Login Screen'))),
          },
          home: const ApplicationApprovedScreen(),
        ),
      );

      expect(find.byType(SvgPicture), findsNWidgets(2));

      expect(find.textContaining('successfully'), findsOneWidget);
      expect(find.textContaining('description'), findsOneWidget);

      expect(find.byType(CustomButton), findsOneWidget);

      await tester.tap(find.byType(CustomButton));
      await tester.pumpAndSettle();

      verify(
        () => mockObserver.didReplace(
          newRoute: any(named: 'newRoute'),
          oldRoute: any(named: 'oldRoute'),
        ),
      ).called(1);

      expect(find.text('Login Screen'), findsOneWidget);
    });

    testWidgets('button has correct style and properties', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          navigatorObservers: [mockObserver],
          routes: {
            AppRoutes.loginView: (_) =>
                const Scaffold(body: Center(child: Text('Login Screen'))),
          },
          home: const ApplicationApprovedScreen(),
        ),
      );

      final button = tester.widget<CustomButton>(find.byType(CustomButton));

      expect(button.size!.height, 50);
      expect(button.size!.width > 100, true);

      expect(button.borderRadius, 100);

      expect(find.text('login'), findsOneWidget);
    });
  });
}
