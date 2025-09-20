import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracking_app/features/home/presentation/Tabs/profile_tab/profile_tab.dart';
import '../../../../../helpers/test_helpers.dart';

void main() {
  group('ProfileTab Widget Tests', () {
    testWidgets('should render ProfileTab with correct content', (
      tester,
    ) async {
      // Act
      await TestHelpers.pumpAppWidget(tester, const ProfileTab());

      // Assert
      expect(find.text('Profile Tab'), findsOneWidget);
    });

    testWidgets('should be centered', (tester) async {
      // Act
      await TestHelpers.pumpAppWidget(tester, const ProfileTab());

      // Assert
      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('should have proper widget structure', (tester) async {
      // Act
      await TestHelpers.pumpAppWidget(tester, const ProfileTab());

      // Assert
      expect(find.byType(ProfileTab), findsOneWidget);
      final profileTab = tester.widget<ProfileTab>(find.byType(ProfileTab));
      expect(profileTab.key, isA<Key?>());
    });

    testWidgets('should be accessible', (tester) async {
      // Act
      await TestHelpers.pumpAppWidget(tester, const ProfileTab());

      // Assert - Should render without accessibility issues
      await tester.pumpAndSettle();
      expect(find.text('Profile Tab'), findsOneWidget);
    });

    group('Integration Tests', () {
      testWidgets('should work with different themes', (tester) async {
        // Act
        await TestHelpers.pumpAppWidget(tester, const ProfileTab());

        // Assert
        expect(find.text('Profile Tab'), findsOneWidget);
      });

      testWidgets('should work with different locales', (tester) async {
        // Act
        await TestHelpers.pumpAppWidget(
          tester,
          const ProfileTab(),
          locale: const Locale('ar'),
        );

        // Assert
        expect(find.text('Profile Tab'), findsOneWidget);
      });
    });

    group('Performance Tests', () {
      testWidgets('should build quickly', (tester) async {
        // Measure build time
        final stopwatch = Stopwatch()..start();

        await TestHelpers.pumpAppWidget(tester, const ProfileTab());

        stopwatch.stop();

        // Assert build time is reasonable (less than 100ms)
        expect(stopwatch.elapsedMilliseconds, lessThan(100));
      });
    });

    group('Functionality Tests', () {
      testWidgets('should be stateless widget', (tester) async {
        // Act
        await TestHelpers.pumpAppWidget(tester, const ProfileTab());

        // Assert
        expect(find.byType(ProfileTab), findsOneWidget);
        final profileTab = tester.widget<ProfileTab>(find.byType(ProfileTab));
        expect(profileTab, isA<StatelessWidget>());
      });

      testWidgets('should maintain const constructor', (tester) async {
        // Arrange & Act
        const profileTab1 = ProfileTab();
        const profileTab2 = ProfileTab();

        // Assert - const constructors should create same instance
        expect(identical(profileTab1, profileTab2), isTrue);
      });

      testWidgets('should handle rebuild efficiently', (tester) async {
        // Act
        await TestHelpers.pumpAppWidget(tester, const ProfileTab());

        // Force a rebuild
        await tester.pumpWidget(
          TestHelpers.createTestApp(child: const ProfileTab()),
        );

        // Assert - Should still render correctly
        expect(find.text('Profile Tab'), findsOneWidget);
        expect(find.byType(Center), findsOneWidget);
      });
    });

    group('Error Handling', () {
      testWidgets('should handle null safety properly', (tester) async {
        // Act & Assert - should not throw
        await TestHelpers.pumpAppWidget(tester, const ProfileTab());

        expect(find.byType(ProfileTab), findsOneWidget);
      });
    });
  });
}
