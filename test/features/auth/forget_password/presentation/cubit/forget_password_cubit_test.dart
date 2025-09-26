import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:tracking_app/features/auth/forget_password/domain/usecases/forget_password_use_case.dart';
import 'package:tracking_app/features/auth/forget_password/domain/usecases/reset_password_use_case.dart';
import 'package:tracking_app/features/auth/forget_password/domain/usecases/varify_reset_code_use_case.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/cubit/forget_password_cubit.dart';

import 'forget_password_cubit_test.mocks.dart';

@GenerateMocks([
  ForgetPasswordUseCase,
  VerifyResetCodeUseCase,
  ResetPasswordUseCase,
])
void main() {
  late MockForgetPasswordUseCase mockForgetPasswordUseCase;
  late MockVerifyResetCodeUseCase mockVerifyResetCodeUseCase;
  late MockResetPasswordUseCase mockResetPasswordUseCase;
  late ForgetPasswordViewModel viewModel;

  setUp(() {
    // TestWidgetsFlutterBinding.ensureInitialized();
    mockForgetPasswordUseCase = MockForgetPasswordUseCase();
    mockVerifyResetCodeUseCase = MockVerifyResetCodeUseCase();
    mockResetPasswordUseCase = MockResetPasswordUseCase();
    viewModel = ForgetPasswordViewModel(
      forgetPasswordUseCase: mockForgetPasswordUseCase,
      verifyResetCodeUseCase: mockVerifyResetCodeUseCase,
      resetPasswordUseCase: mockResetPasswordUseCase,
    );
  });

  group('ForgetPasswordViewModel Tests', () {
    blocTest<ForgetPasswordViewModel, ForgetPassStates>(
      'emits ForgetPassBtnValidationState when email is entered',
      build: () => viewModel,
      act: (cubit) => cubit
        ..emailController.text = 'test@example.com'
        ..validateForgetPassBtn(),
      expect: () => [
        isA<ForgetPassBtnValidationState>().having(
          (s) => s.isBtnEnabled,
          'isBtnEnabled',
          true,
        ),
      ],
    );

    blocTest<ForgetPasswordViewModel, ForgetPassStates>(
      'emits OtpBtnValidationState when OTP fields are filled',
      build: () => viewModel,
      act: (cubit) => cubit
        ..otpControllers.forEach((c) => c.text = '1')
        ..validateOtpBtn(),
      expect: () => [
        isA<OtpBtnValidationState>().having(
          (s) => s.isBtnEnabled,
          'isBtnEnabled',
          true,
        ),
      ],
    );

    blocTest<ForgetPasswordViewModel, ForgetPassStates>(
      'emits ResetPassBtnValidationState when passwords are entered',
      build: () => viewModel,
      act: (cubit) => cubit
        ..newPasswordController.text = 'password123'
        ..confirmPasswordController.text = 'password123'
        ..validateResetPassBtn(),
      expect: () => [
        isA<ResetPassBtnValidationState>().having(
          (s) => s.isBtnEnabled,
          'isBtnEnabled',
          true,
        ),
      ],
    );
  });
}
