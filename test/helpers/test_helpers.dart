import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tracking_app/core/l10n/app_localizations.dart';

/// Test helper to wrap widgets with necessary providers for testing
class TestHelpers {
  /// Creates a MaterialApp wrapper for widget testing with localization support
  static Widget createTestApp({
    required Widget child,
    ThemeData? theme,
    Locale locale = const Locale('en'),
  }) {
    return MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      theme: theme ?? _createTestTheme(),
      home: Scaffold(body: child),
    );
  }

  /// Creates a test theme for consistent styling in tests
  static ThemeData _createTestTheme() {
    return ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.blue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
    );
  }

  /// Pumps a widget with all necessary wrappers for testing
  static Future<void> pumpAppWidget(
    WidgetTester tester,
    Widget widget, {
    ThemeData? theme,
    Locale locale = const Locale('en'),
  }) async {
    await tester.pumpWidget(
      createTestApp(child: widget, theme: theme, locale: locale),
    );
  }

  /// Creates mock asset paths for testing
  static Map<String, String> get mockAssetPaths => {
    'assets/icon/home_icon.png': 'test_assets/home_icon.png',
    'assets/icon/order_icon.png': 'test_assets/order_icon.png',
    'assets/icon/profile_icon.png': 'test_assets/profile_icon.png',
  };

  /// Waits for all animations and async operations to complete
  static Future<void> pumpAndSettle(WidgetTester tester) async {
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
  }
}

/// Extension for easier testing of common UI interactions
extension WidgetTesterExtensions on WidgetTester {
  /// Finds a widget by its key
  Finder findByKey(Key key) => find.byKey(key);

  /// Finds text in the widget tree
  Finder findText(String text) => find.text(text);

  /// Finds a widget by its type
  Finder findByType<T>() => find.byType(T);

  /// Taps on a widget found by text
  Future<void> tapText(String text) async {
    await tap(findText(text));
    await pump();
  }

  /// Taps on a widget found by key
  Future<void> tapKey(Key key) async {
    await tap(findByKey(key));
    await pump();
  }

  /// Verifies that a text is present
  void expectTextPresent(String text) {
    expect(findText(text), findsOneWidget);
  }

  /// Verifies that a text is not present
  void expectTextNotPresent(String text) {
    expect(findText(text), findsNothing);
  }
}

/// Mock data for testing
class MockData {
  static const List<String> tabLabels = ['Home', 'Orders', 'Profile'];
  static const List<String> tabContents = [
    'Home Tab',
    'Order Tab',
    'Profile Tab',
  ];
}

/// Test keys for consistent widget identification
class TestKeys {
  static const homeTab = Key('home_tab');
  static const orderTab = Key('order_tab');
  static const profileTab = Key('profile_tab');
  static const bottomNavigationBar = Key('bottom_navigation_bar');
  static const homeScreen = Key('home_screen');
}
