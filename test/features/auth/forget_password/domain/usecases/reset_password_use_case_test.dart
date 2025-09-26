import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/auth/forget_password/domain/entities/reset_password_response_entity.dart';
import 'package:tracking_app/features/auth/forget_password/domain/repositories/forget_password_repo.dart';
import 'package:tracking_app/features/auth/forget_password/domain/usecases/reset_password_use_case.dart';

import 'reset_password_use_case_test.mocks.dart';

@GenerateMocks([ForgetPasswordRepo])
void main() {
  late MockForgetPasswordRepo mockForgetPasswordRepo;
  late ResetPasswordUseCase resetPasswordUseCase;

  setUp(() {
    mockForgetPasswordRepo = MockForgetPasswordRepo();
    resetPasswordUseCase = ResetPasswordUseCase(mockForgetPasswordRepo);

    // Provide dummy values for ApiResult types
    provideDummy<ApiResult<ResetPasswordResponseEntity>>(
      ApiSuccessResult<ResetPasswordResponseEntity>(
        ResetPasswordResponseEntity(message: 'success'),
      ),
    );
  });

  group('ResetPasswordUseCase', () {
    const testEmail = 'test@example.com';
    const testNewPassword = 'newPassword123';

    test(
      'should return ApiSuccessResult<ResetPasswordResponseEntity> when repository call succeeds',
      () async {
        // arrange
        final mockEntity = ResetPasswordResponseEntity(message: 'success');
        when(
          mockForgetPasswordRepo.resetPassword(
            email: testEmail,
            newPassword: testNewPassword,
          ),
        ).thenAnswer((_) async => ApiSuccessResult(mockEntity));

        // act
        final result = await resetPasswordUseCase.call(
          email: testEmail,
          newPassword: testNewPassword,
        );

        // assert
        expect(result, isA<ApiSuccessResult<ResetPasswordResponseEntity>>());
        final entity =
            (result as ApiSuccessResult<ResetPasswordResponseEntity>).data;
        expect(entity.message, 'success');
        verify(
          mockForgetPasswordRepo.resetPassword(
            email: testEmail,
            newPassword: testNewPassword,
          ),
        ).called(1);
      },
    );

    test(
      'should return ApiErrorResult<ResetPasswordResponseEntity> when repository call fails',
      () async {
        // arrange
        const mockError = 'Invalid reset token';
        when(
          mockForgetPasswordRepo.resetPassword(
            email: testEmail,
            newPassword: testNewPassword,
          ),
        ).thenAnswer((_) async => ApiErrorResult(mockError));

        // act
        final result = await resetPasswordUseCase.call(
          email: testEmail,
          newPassword: testNewPassword,
        );

        // assert
        expect(result, isA<ApiErrorResult<ResetPasswordResponseEntity>>());
        final error = result as ApiErrorResult<ResetPasswordResponseEntity>;
        expect(error.errorMessage, mockError);
        verify(
          mockForgetPasswordRepo.resetPassword(
            email: testEmail,
            newPassword: testNewPassword,
          ),
        ).called(1);
      },
    );

    test('should call repository with correct parameters', () async {
      // arrange
      const customEmail = 'custom@example.com';
      const customPassword = 'customPassword456';
      final mockEntity = ResetPasswordResponseEntity(message: 'success');
      when(
        mockForgetPasswordRepo.resetPassword(
          email: customEmail,
          newPassword: customPassword,
        ),
      ).thenAnswer((_) async => ApiSuccessResult(mockEntity));

      // act
      await resetPasswordUseCase.call(
        email: customEmail,
        newPassword: customPassword,
      );

      // assert
      verify(
        mockForgetPasswordRepo.resetPassword(
          email: customEmail,
          newPassword: customPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockForgetPasswordRepo);
    });
  });
}
