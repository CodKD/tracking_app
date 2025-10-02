import 'package:flutter_test/flutter_test.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/views/home_tab.dart';
import 'package:tracking_app/features/home/presentation/blocs/home_view_model.dart';
import 'package:tracking_app/features/home/presentation/Tabs/order_tab/order_tab.dart';
import 'package:tracking_app/features/profile/presentation/view/view.dart';

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

    });

  });
}
