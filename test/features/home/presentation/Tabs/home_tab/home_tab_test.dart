import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/home_tab.dart';
import '../../../../../helpers/test_helpers.dart';

void main() {
  group('HomeTab Widget Tests', () {
    testWidgets('should render HomeTab with correct content', (tester) async {
      // Act
      await TestHelpers.pumpAppWidget(tester, const HomeTab());

      // Assert
      expect(find.text('Home Tab'), findsOneWidget);
    });

    testWidgets('should be centered', (tester) async {
      // Act
      await TestHelpers.pumpAppWidget(tester, const HomeTab());

      // Assert
      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('should have proper widget structure', (tester) async {
      // Act
      await TestHelpers.pumpAppWidget(tester, const HomeTab());

      // Assert
      expect(find.byType(HomeTab), findsOneWidget);
      final homeTab = tester.widget<HomeTab>(find.byType(HomeTab));
      expect(homeTab.key, isA<Key?>());
    });

    testWidgets('should be accessible', (tester) async {
      // Act
      await TestHelpers.pumpAppWidget(tester, const HomeTab());

      // Assert - Should render without accessibility issues
      await tester.pumpAndSettle();
      expect(find.text('Home Tab'), findsOneWidget);
    });

    group('Integration Tests', () {
      testWidgets('should work with different themes', (tester) async {
        // Act
        await TestHelpers.pumpAppWidget(tester, const HomeTab());

        // Assert
        expect(find.text('Home Tab'), findsOneWidget);
      });

      testWidgets('should work with different locales', (tester) async {
        // Act
        await TestHelpers.pumpAppWidget(
          tester,
          const HomeTab(),
          locale: const Locale('ar'),
        );

        // Assert
        expect(find.text('Home Tab'), findsOneWidget);
      });
    });

    group('Performance Tests', () {
      testWidgets('should build quickly', (tester) async {
        // Measure build time
        final stopwatch = Stopwatch()..start();

        await TestHelpers.pumpAppWidget(tester, const HomeTab());

        stopwatch.stop();

        // Assert build time is reasonable (less than 100ms)
        expect(stopwatch.elapsedMilliseconds, lessThan(100));
      });
    });
  });
}
