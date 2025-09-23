import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tracking_app/features/onboarding/onboarding_view.dart';
import 'package:tracking_app/core/route/app_routes.dart';
import 'package:tracking_app/core/l10n/app_localizations.dart';
import 'package:tracking_app/core/utils/components/custom_button.dart';

void main() {
  group('OnboardingView Widget Tests', () {
    Widget createTestWidget() {
      return MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
        home: const OnboardingView(),
        routes: {
          AppRoutes.loginView: (context) =>
              const Scaffold(body: Center(child: Text('Login Screen'))),
        },
      );
    }

    testWidgets('should pump OnboardingView widget successfully', (
      WidgetTester tester,
    ) async {
      // Arrange & Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert - Widget should be pumped successfully
      expect(find.byType(OnboardingView), findsOneWidget);
      expect(find.byType(CustomButton), findsAtLeastNWidgets(2));
    });

    testWidgets(
      'should navigate to login screen when login button is pressed',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Act - Find and tap the first custom button (login button)
        final customButtons = find.byType(CustomButton);
        expect(customButtons, findsAtLeastNWidgets(2));

        // Tap the first button (login button)
        await tester.tap(customButtons.first);
        await tester.pumpAndSettle();

        // Assert - Should navigate to login screen
        expect(find.text('Login Screen'), findsOneWidget);
        expect(find.byType(OnboardingView), findsNothing);
      },
    );
  });
}
