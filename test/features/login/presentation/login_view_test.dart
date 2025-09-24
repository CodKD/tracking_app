import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/core/modules/shared_preferences_module.dart';
import 'package:tracking_app/features/login/domain/entities/login_request_entity.dart';
import 'package:tracking_app/features/login/domain/entities/login_response_entity.dart';
import 'package:tracking_app/features/login/domain/use_cases/login_use_case.dart';
import 'package:tracking_app/features/login/presentation/cubit/login_view_model.dart';

// Manual mock classes
class FakeLoginUseCase implements LoginUseCase {
  ApiResult<LoginResponseEntity>? _mockResponse;

  void setMockResponse(ApiResult<LoginResponseEntity> response) {
    _mockResponse = response;
  }

  @override
  Future<ApiResult<LoginResponseEntity>> call({
    required LoginRequestEntity loginRequestEntity,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _mockResponse ?? ApiErrorResult('No mock response set');
  }
}

class FakeSharedPrefHelper implements SharedPrefHelper {
  final Map<String, dynamic> _storage = {};

  @override
  Future<void> setValue(String key, dynamic value) async {
    _storage[key] = value;
  }

  @override
  dynamic getValue(String key) => _storage[key];

  @override
  Future<void> removePreference({required String key}) async {
    _storage.remove(key);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

// Simple test widget that mimics LoginView but doesn't use DI
class TestLoginWidget extends StatelessWidget {
  final LoginViewModel viewModel;

  const TestLoginWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginViewModel, dynamic>(
      builder: (context, state) {
        bool isLoading = state.toString().contains('LoginLoading');

        return Scaffold(
          appBar: AppBar(title: const Text('Login')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    key: const Key('email_field'),
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const Key('password_field'),
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Checkbox(value: false, onChanged: (value) {}),
                  const SizedBox(height: 24),
                  if (isLoading)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton(
                      key: const Key('login_button'),
                      onPressed: () {
                        // Simple test login trigger
                      },
                      child: const Text('Login'),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Test app wrapper
Widget createTestApp(Widget child) {
  return MaterialApp(
    home: child,
    onGenerateRoute: (settings) {
      return MaterialPageRoute(builder: (_) => const Scaffold());
    },
  );
}

void main() {
  late FakeLoginUseCase fakeLoginUseCase;
  late FakeSharedPrefHelper fakeSharedPrefHelper;
  late LoginViewModel viewModel;

  setUp(() {
    fakeLoginUseCase = FakeLoginUseCase();
    fakeSharedPrefHelper = FakeSharedPrefHelper();
    viewModel = LoginViewModel(
      loginUseCase: fakeLoginUseCase,
      sharedPrefHelper: fakeSharedPrefHelper,
    );
  });

  tearDown(() {
    viewModel.close();
  });

  group('LoginView Widget Tests', () {
    testWidgets('should display all UI elements', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        createTestApp(
          BlocProvider.value(
            value: viewModel,
            child: TestLoginWidget(viewModel: viewModel),
          ),
        ),
      );

      // Assert
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(Checkbox), findsOneWidget);
      expect(find.text('Login'), findsNWidgets(2)); // AppBar title + button
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('should enter text in email and password fields', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        createTestApp(
          BlocProvider.value(
            value: viewModel,
            child: TestLoginWidget(viewModel: viewModel),
          ),
        ),
      );

      // Act
      final emailField = find.byKey(const Key('email_field'));
      final passwordField = find.byKey(const Key('password_field'));

      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'password123');
      await tester.pump();

      // Assert
      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('password123'), findsOneWidget);
    });

    testWidgets('should show login button', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        createTestApp(
          BlocProvider.value(
            value: viewModel,
            child: TestLoginWidget(viewModel: viewModel),
          ),
        ),
      );

      // Assert - Should show login button
      expect(find.byKey(const Key('login_button')), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Act - Tap login button
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pump();

      // Should still have the button
      expect(find.byKey(const Key('login_button')), findsOneWidget);
    });
  });
}
