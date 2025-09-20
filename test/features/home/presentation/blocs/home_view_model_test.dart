import 'package:flutter_test/flutter_test.dart';
import 'package:tracking_app/features/home/presentation/blocs/home_view_model.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/home_tab.dart';
import 'package:tracking_app/features/home/presentation/Tabs/order_tab/order_tab.dart';
import 'package:tracking_app/features/home/presentation/Tabs/profile_tab/profile_tab.dart';

void main() {
  group('HomeViewModel', () {
    late HomeViewModel homeViewModel;

    setUp(() {
      homeViewModel = HomeViewModel();
    });

    group('Initial State', () {
      test('should have initial currentIndex as 0', () {
        expect(homeViewModel.currentIndex, equals(0));
      });

      test('should have 3 pages initialized', () {
        expect(homeViewModel.pages, hasLength(3));
        expect(homeViewModel.pages[0], isA<HomeTab>());
        expect(homeViewModel.pages[1], isA<OrderTab>());
        expect(homeViewModel.pages[2], isA<ProfileTab>());
      });
    });

    group('setCurrentIndex', () {
      test('should update currentIndex when different index is provided', () {
        // Arrange
        const newIndex = 1;
        bool notifierCalled = false;

        homeViewModel.addListener(() {
          notifierCalled = true;
        });

        // Act
        homeViewModel.setCurrentIndex(newIndex);

        // Assert
        expect(homeViewModel.currentIndex, equals(newIndex));
        expect(notifierCalled, isTrue);
      });

      test('should update currentIndex to last tab', () {
        // Arrange
        const newIndex = 2;
        bool notifierCalled = false;

        homeViewModel.addListener(() {
          notifierCalled = true;
        });

        // Act
        homeViewModel.setCurrentIndex(newIndex);

        // Assert
        expect(homeViewModel.currentIndex, equals(newIndex));
        expect(notifierCalled, isTrue);
      });

      test('should not notify listeners when same index is provided', () {
        // Arrange
        const sameIndex = 0;
        bool notifierCalled = false;

        homeViewModel.addListener(() {
          notifierCalled = true;
        });

        // Act
        homeViewModel.setCurrentIndex(sameIndex);

        // Assert
        expect(homeViewModel.currentIndex, equals(sameIndex));
        expect(notifierCalled, isFalse);
      });

      test('should handle switching between multiple indices', () {
        // Arrange
        int notificationCount = 0;

        homeViewModel.addListener(() {
          notificationCount++;
        });

        // Act & Assert
        homeViewModel.setCurrentIndex(1);
        expect(homeViewModel.currentIndex, equals(1));
        expect(notificationCount, equals(1));

        homeViewModel.setCurrentIndex(2);
        expect(homeViewModel.currentIndex, equals(2));
        expect(notificationCount, equals(2));

        homeViewModel.setCurrentIndex(0);
        expect(homeViewModel.currentIndex, equals(0));
        expect(notificationCount, equals(3));

        // Same index should not trigger notification
        homeViewModel.setCurrentIndex(0);
        expect(homeViewModel.currentIndex, equals(0));
        expect(notificationCount, equals(3));
      });

      test('should handle edge cases for index values', () {
        // Test boundary values
        homeViewModel.setCurrentIndex(0);
        expect(homeViewModel.currentIndex, equals(0));

        homeViewModel.setCurrentIndex(2);
        expect(homeViewModel.currentIndex, equals(2));

        // Note: In a real app, you might want to validate index bounds
        // but the current implementation doesn't restrict this
      });
    });

    group('Listener Management', () {
      test('should properly notify all listeners', () {
        // Arrange
        int listener1Count = 0;
        int listener2Count = 0;

        homeViewModel.addListener(() => listener1Count++);
        homeViewModel.addListener(() => listener2Count++);

        // Act
        homeViewModel.setCurrentIndex(1);

        // Assert
        expect(listener1Count, equals(1));
        expect(listener2Count, equals(1));
      });

      test('should not notify removed listeners', () {
        // Arrange
        int listenerCount = 0;
        void listener() => listenerCount++;

        homeViewModel.addListener(listener);
        homeViewModel.setCurrentIndex(1);
        expect(listenerCount, equals(1));

        // Act
        homeViewModel.removeListener(listener);
        homeViewModel.setCurrentIndex(2);

        // Assert
        expect(listenerCount, equals(1)); // Should not increase
      });
    });

    group('Dispose', () {
      test('should dispose properly without throwing', () {
        // Arrange
        final testViewModel = HomeViewModel();
        testViewModel.addListener(() {});

        // Act & Assert
        expect(() => testViewModel.dispose(), returnsNormally);
      });
    });
  });
}
