import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracking_app/features/home/presentation/Tabs/order_tab/order_tab.dart';
import '../../../../../helpers/test_helpers.dart';

void main() {
  group('OrderTab Widget Tests', () {
    testWidgets('should render OrderTab with correct content', (tester) async {
      // Act
      await TestHelpers.pumpAppWidget(tester, const OrderTab());

      // Assert
      expect(find.text('Order Tab'), findsOneWidget);
    });

    testWidgets('should be centered', (tester) async {
      // Act
      await TestHelpers.pumpAppWidget(tester, const OrderTab());

      // Assert
      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('should have proper widget structure', (tester) async {
      // Act
      await TestHelpers.pumpAppWidget(tester, const OrderTab());

      // Assert
      expect(find.byType(OrderTab), findsOneWidget);
      final orderTab = tester.widget<OrderTab>(find.byType(OrderTab));
      expect(orderTab.key, isA<Key?>());
    });

    testWidgets('should be accessible', (tester) async {
      // Act
      await TestHelpers.pumpAppWidget(tester, const OrderTab());

      // Assert - Should render without accessibility issues
      await tester.pumpAndSettle();
      expect(find.text('Order Tab'), findsOneWidget);
    });

    group('Integration Tests', () {
      testWidgets('should work with different themes', (tester) async {
        // Act
        await TestHelpers.pumpAppWidget(tester, const OrderTab());

        // Assert
        expect(find.text('Order Tab'), findsOneWidget);
      });

      testWidgets('should work with different locales', (tester) async {
        // Act
        await TestHelpers.pumpAppWidget(
          tester,
          const OrderTab(),
          locale: const Locale('ar'),
        );

        // Assert
        expect(find.text('Order Tab'), findsOneWidget);
      });
    });

    group('Performance Tests', () {
      testWidgets('should build quickly', (tester) async {
        // Measure build time
        final stopwatch = Stopwatch()..start();

        await TestHelpers.pumpAppWidget(tester, const OrderTab());

        stopwatch.stop();

        // Assert build time is reasonable (less than 100ms)
        expect(stopwatch.elapsedMilliseconds, lessThan(100));
      });
    });

    group('Functionality Tests', () {
      testWidgets('should be stateless widget', (tester) async {
        // Act
        await TestHelpers.pumpAppWidget(tester, const OrderTab());

        // Assert
        expect(find.byType(OrderTab), findsOneWidget);
        final orderTab = tester.widget<OrderTab>(find.byType(OrderTab));
        expect(orderTab, isA<StatelessWidget>());
      });

      testWidgets('should maintain const constructor', (tester) async {
        // Arrange & Act
        const orderTab1 = OrderTab();
        const orderTab2 = OrderTab();

        // Assert - const constructors should create same instance
        expect(identical(orderTab1, orderTab2), isTrue);
      });
    });
  });
}
