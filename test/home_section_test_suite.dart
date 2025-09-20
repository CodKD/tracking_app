// Test configuration file for the home section tests
// This file defines test suites and helpers for running comprehensive tests

import 'package:flutter_test/flutter_test.dart';

// Import all test files
import 'features/home/presentation/blocs/home_view_model_test.dart'
    as home_view_model_tests;
import 'features/home/presentation/home_screen_test.dart' as home_screen_tests;
import 'features/home/presentation/Tabs/home_tab/home_tab_test.dart'
    as home_tab_tests;
import 'features/home/presentation/Tabs/order_tab/order_tab_test.dart'
    as order_tab_tests;
import 'features/home/presentation/Tabs/profile_tab/profile_tab_test.dart'
    as profile_tab_tests;
import 'features/home/home_integration_test.dart' as integration_tests;

void main() {
  group('Home Section - All Tests', () {
    group('Unit Tests', () {
      home_view_model_tests.main();
    });

    group('Widget Tests', () {
      home_screen_tests.main();
      home_tab_tests.main();
      order_tab_tests.main();
      profile_tab_tests.main();
    });

    group('Integration Tests', () {
      integration_tests.main();
    });
  });
}
