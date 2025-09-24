import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tracking_app/core/l10n/app_localizations.dart';
import 'package:tracking_app/features/home/presentation/blocs/home_view_model.dart';
import 'package:tracking_app/features/home/presentation/home_screen.dart';

void main() {
  group('HomeScreen Widget Tests', () {
    late HomeViewModel mockViewModel;

    setUp(() {
      mockViewModel = HomeViewModel();
    });

    /// Creates a MaterialApp wrapper for widget testing with localization support
    Widget createTestApp({required Widget child}) {
      return ScreenUtilInit(
        designSize: const Size(375, 812), // Standard design size for tests
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('ar')],
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
            ),
          ),
          home: Scaffold(body: child),
        ),
      );
    }

    /// Pumps a widget with all necessary wrappers for testing
    Future<void> pumpTestWidget(WidgetTester tester, Widget widget) async {
      await tester.pumpWidget(createTestApp(child: widget));
      await tester
          .pumpAndSettle(); // Wait for ScreenUtil initialization and all animations
    }

    testWidgets('should render HomeScreen with all basic components', (
      tester,
    ) async {
      // Act
      await pumpTestWidget(tester, const HomeScreen());

      // Assert
      expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(IndexedStack), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets(
      'should display BottomNavigationBar with correct number of tabs',
      (tester) async {
        // Act
        await pumpTestWidget(tester, const HomeScreen());

        // Assert
        final bottomNavBar = tester.widget<BottomNavigationBar>(
          find.byType(BottomNavigationBar),
        );
        expect(bottomNavBar.items, hasLength(3));
        expect(bottomNavBar.type, equals(BottomNavigationBarType.fixed));
      },
    );

    testWidgets('should show Home tab by default', (tester) async {
      // Act
      await pumpTestWidget(tester, const HomeScreen());

      // Assert
      expect(find.text('Home Tab'), findsOneWidget);
      expect(find.text('Order Tab'), findsNothing);
      expect(find.text('Profile Tab'), findsNothing);
    });

    testWidgets('should preserve state when switching between tabs', (
      tester,
    ) async {
      // Act
      await pumpTestWidget(tester, const HomeScreen());

      // Verify IndexedStack is used (which preserves state)
      final indexedStack = tester.widget<IndexedStack>(
        find.byType(IndexedStack),
      );
      expect(indexedStack.index, equals(0));
      expect(indexedStack.children, hasLength(3));
    });

    group('Navigation Tests', () {
      testWidgets('should handle navigation through view model correctly', (
        tester,
      ) async {
        // Arrange
        await tester.pumpWidget(
          createTestApp(
            child: ChangeNotifierProvider<HomeViewModel>.value(
              value: mockViewModel,
              child: Consumer<HomeViewModel>(
                builder: (context, viewModel, child) {
                  return Scaffold(
                    body: SafeArea(
                      child: IndexedStack(
                        index: viewModel.currentIndex,
                        children: viewModel.pages,
                      ),
                    ),
                    bottomNavigationBar: BottomNavigationBar(
                      currentIndex: viewModel.currentIndex,
                      onTap: viewModel.setCurrentIndex,
                      type: BottomNavigationBarType.fixed,
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.shopping_cart),
                          label: 'Orders',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.person),
                          label: 'Profile',
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );

        // Initially at index 0
        expect(mockViewModel.currentIndex, equals(0));

        // Act - simulate tab changes through the view model
        mockViewModel.setCurrentIndex(1);
        await tester.pump();

        // Assert
        expect(mockViewModel.currentIndex, equals(1));

        // Act - switch to profile tab
        mockViewModel.setCurrentIndex(2);
        await tester.pump();

        // Assert
        expect(mockViewModel.currentIndex, equals(2));
      });

      testWidgets('should maintain proper theme and styling', (tester) async {
        // Act
        await pumpTestWidget(tester, const HomeScreen());

        // Assert
        final bottomNavBar = tester.widget<BottomNavigationBar>(
          find.byType(BottomNavigationBar),
        );

        expect(bottomNavBar.elevation, equals(0));
        expect(bottomNavBar.type, equals(BottomNavigationBarType.fixed));
        expect(bottomNavBar.unselectedItemColor, equals(Colors.grey));
      });

      testWidgets('should handle bottom navigation tap interactions', (
        tester,
      ) async {
        // Arrange
        await tester.pumpWidget(
          createTestApp(
            child: ChangeNotifierProvider<HomeViewModel>.value(
              value: mockViewModel,
              child: Consumer<HomeViewModel>(
                builder: (context, viewModel, child) {
                  return Scaffold(
                    body: SafeArea(
                      child: IndexedStack(
                        index: viewModel.currentIndex,
                        children: viewModel.pages,
                      ),
                    ),
                    bottomNavigationBar: BottomNavigationBar(
                      currentIndex: viewModel.currentIndex,
                      onTap: viewModel.setCurrentIndex,
                      type: BottomNavigationBarType.fixed,
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.shopping_cart),
                          label: 'Orders',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.person),
                          label: 'Profile',
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );

        // Initially should show first tab
        expect(mockViewModel.currentIndex, equals(0));

        // Simulate tap on second tab by calling the onTap callback
        final bottomNavBar = tester.widget<BottomNavigationBar>(
          find.byType(BottomNavigationBar),
        );
        bottomNavBar.onTap!(1);
        await tester.pump();

        // Assert second tab is selected
        expect(mockViewModel.currentIndex, equals(1));

        // Simulate tap on third tab
        bottomNavBar.onTap!(2);
        await tester.pump();

        // Assert third tab is selected
        expect(mockViewModel.currentIndex, equals(2));
      });
    });

    group('Performance Tests', () {
      testWidgets('should build efficiently', (tester) async {
        // Measure build time
        final stopwatch = Stopwatch()..start();

        await pumpTestWidget(tester, const HomeScreen());

        stopwatch.stop();

        // Assert build time is reasonable (less than 200ms)
        expect(stopwatch.elapsedMilliseconds, lessThan(200));
      });
    });
    group('Localization Tests', () {
      testWidgets('should work with English locale', (tester) async {
        // Arrange
        await tester.pumpWidget(
          const MaterialApp(
            locale: Locale('en'),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [Locale('en'), Locale('ar')],
            home: HomeScreen(),
          ),
        );

        // Assert
        expect(find.byType(HomeScreen), findsOneWidget);
      });

      testWidgets('should work with Arabic locale', (tester) async {
        // Arrange
        await tester.pumpWidget(
          const MaterialApp(
            locale: Locale('ar'),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [Locale('en'), Locale('ar')],
            home: HomeScreen(),
          ),
        );

        // Assert
        expect(find.byType(HomeScreen), findsOneWidget);
      });
    });
  });
}
