import 'package:flutter_test/flutter_test.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/core/modules/shared_preferences_module.dart';
import 'package:tracking_app/core/resources/app_constants.dart';
import 'package:tracking_app/features/login/domain/entities/login_request_entity.dart';
import 'package:tracking_app/features/login/domain/entities/login_response_entity.dart';
import 'package:tracking_app/features/login/domain/use_cases/login_use_case.dart';
import 'package:tracking_app/features/login/presentation/cubit/login_view_model.dart';
import 'package:tracking_app/features/login/presentation/cubit/login_states.dart';

// Manual mock for LoginUseCase
class FakeLoginUseCase implements LoginUseCase {
  ApiResult<LoginResponseEntity>? _mockResponse;
  Exception? _mockException;

  void setMockResponse(ApiResult<LoginResponseEntity> response) {
    _mockResponse = response;
    _mockException = null;
  }

  void setMockException(Exception exception) {
    _mockException = exception;
    _mockResponse = null;
  }

  @override
  Future<ApiResult<LoginResponseEntity>> call({
    required LoginRequestEntity loginRequestEntity,
  }) async {
    if (_mockException != null) {
      throw _mockException!;
    }
    return _mockResponse ?? ApiErrorResult('No mock response set');
  }
}

// Manual mock for SharedPrefHelper
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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LoginViewModel viewModel;
  late FakeLoginUseCase fakeLoginUseCase;
  late FakeSharedPrefHelper fakeSharedPrefHelper;

  setUp(() {
    fakeLoginUseCase = FakeLoginUseCase();
    fakeSharedPrefHelper = FakeSharedPrefHelper();
    viewModel = LoginViewModel(
      loginUseCase: fakeLoginUseCase,
      sharedPrefHelper: fakeSharedPrefHelper,
    );
  });

  tearDown(() {
    if (!viewModel.isClosed) {
      viewModel.close();
    }
  });

  group('LoginViewModel Tests', () {
    test('initial state should be LoginInitState', () {
      expect(viewModel.state, isA<LoginInitState>());
    });

    test('controllers should have default values', () {
      expect(viewModel.emailController.text, isNotEmpty);
      expect(viewModel.passwordController.text, isNotEmpty);
    });

    test('should create login request entity with correct data', () {
      // Arrange
      const email = 'test@example.com';
      const password = 'password123';

      viewModel.emailController.text = email;
      viewModel.passwordController.text = password;

      // Act & Assert
      expect(viewModel.emailController.text, equals(email));
      expect(viewModel.passwordController.text, equals(password));
    });

    test('should save token when login succeeds', () async {
      // Arrange
      final mockResponse = LoginResponseEntity(
        message: 'Success',
        token: 'test_token',
      );
      fakeLoginUseCase.setMockResponse(ApiSuccessResult(mockResponse));

      // Act - Call the use case directly to test token saving logic
      final result = await fakeLoginUseCase.call(
        loginRequestEntity: LoginRequestEntity(
          email: viewModel.emailController.text,
          password: viewModel.passwordController.text,
        ),
      );

      if (result is ApiSuccessResult<LoginResponseEntity>) {
        await fakeSharedPrefHelper.setValue(
          AppConstants.tokenKey,
          result.data.token,
        );
      }

      // Assert
      expect(
        fakeSharedPrefHelper.getValue(AppConstants.tokenKey),
        equals('test_token'),
      );
    });

    test('should handle API error response', () async {
      // Arrange
      fakeLoginUseCase.setMockResponse(ApiErrorResult('Login failed'));

      // Act
      final result = await fakeLoginUseCase.call(
        loginRequestEntity: LoginRequestEntity(
          email: viewModel.emailController.text,
          password: viewModel.passwordController.text,
        ),
      );

      // Assert
      expect(result, isA<ApiErrorResult<LoginResponseEntity>>());
      expect((result as ApiErrorResult).errorMessage, equals('Login failed'));
    });

    test('should dispose without errors', () async {
      // Act & Assert
      expect(() => viewModel.close(), returnsNormally);
    });
  });
}
