import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/auth/forget_password/data/datasources/contracts/forget_password_remote_data_source.dart';
import 'package:tracking_app/features/auth/forget_password/data/repos_impl/forget_password_repo_impl.dart';
import 'package:tracking_app/features/auth/forget_password/domain/entities/forget_password_response_entity.dart';
import 'package:tracking_app/features/auth/forget_password/domain/entities/reset_password_response_entity.dart';
import 'package:tracking_app/features/auth/forget_password/domain/entities/verify_reset_code_entity.dart';

import 'forget_password_repo_impl_test.mocks.dart';

@GenerateMocks([ForgetPasswordRemoteDataSource])
void main() {
  late MockForgetPasswordRemoteDataSource mockForgetPasswordRemoteDataSource;
  late ForgetPasswordRepoImpl forgetPasswordRepoImpl;

  setUp(() {
    mockForgetPasswordRemoteDataSource = MockForgetPasswordRemoteDataSource();
    forgetPasswordRepoImpl = ForgetPasswordRepoImpl(
      mockForgetPasswordRemoteDataSource,
    );
    provideDummy<ApiResult<ForgetPasswordResponseEntity>>(
      ApiSuccessResult(ForgetPasswordResponseEntity(message: 'success')),
    );
    provideDummy<ApiResult<VerifyResetCodeResponseEntity>>(
      ApiSuccessResult(VerifyResetCodeResponseEntity(status: 'success')),
    );
    provideDummy<ApiResult<ResetPasswordResponseEntity>>(
      ApiSuccessResult(ResetPasswordResponseEntity(message: 'success')),
    );
  });

  group('ForgetPasswordRepoImpl', () {
    const testEmail = 'test@example.com';
    const testResetCode = '123456';
    const testNewPassword = 'newPassword123';

    group('forgetPassword', () {
      test(
        'should return ApiSuccessResult<ForgetPasswordResponseEntity> when forgetPassword succeeds',
        () async {
          // arrange
          final mockEntity = ForgetPasswordResponseEntity(message: 'success');
          when(
            mockForgetPasswordRemoteDataSource.forgetPassword(email: testEmail),
          ).thenAnswer((_) async => ApiSuccessResult(mockEntity));

          // act
          final result = await forgetPasswordRepoImpl.forgetPassword(
            email: testEmail,
          );

          // assert
          expect(result, isA<ApiSuccessResult<ForgetPasswordResponseEntity>>());
          final entity =
              (result as ApiSuccessResult<ForgetPasswordResponseEntity>).data;
          expect(entity.message, 'success');
          verify(
            mockForgetPasswordRemoteDataSource.forgetPassword(email: testEmail),
          ).called(1);
        },
      );

      test(
        'should return ApiErrorResult<ForgetPasswordResponseEntity> when forgetPassword fails',
        () async {
          // arrange
          const mockError = 'Failed to send reset email';
          when(
            mockForgetPasswordRemoteDataSource.forgetPassword(email: testEmail),
          ).thenAnswer((_) async => ApiErrorResult(mockError));

          // act
          final result = await forgetPasswordRepoImpl.forgetPassword(
            email: testEmail,
          );

          // assert
          expect(result, isA<ApiErrorResult<ForgetPasswordResponseEntity>>());
          final error = result as ApiErrorResult<ForgetPasswordResponseEntity>;
          expect(error.errorMessage, mockError);
          verify(
            mockForgetPasswordRemoteDataSource.forgetPassword(email: testEmail),
          ).called(1);
        },
      );
    });

    group('verifyResetCode', () {
      test(
        'should return ApiSuccessResult<VerifyResetCodeResponseEntity> when verifyResetCode succeeds',
        () async {
          // arrange
          final mockEntity = VerifyResetCodeResponseEntity(status: 'success');
          when(
            mockForgetPasswordRemoteDataSource.verifyResetCode(
              resetCode: testResetCode,
            ),
          ).thenAnswer((_) async => ApiSuccessResult(mockEntity));

          // act
          final result = await forgetPasswordRepoImpl.verifyResetCode(
            resetCode: testResetCode,
          );

          // assert
          expect(
            result,
            isA<ApiSuccessResult<VerifyResetCodeResponseEntity>>(),
          );
          final entity =
              (result as ApiSuccessResult<VerifyResetCodeResponseEntity>).data;
          expect(entity.status, 'success');
          verify(
            mockForgetPasswordRemoteDataSource.verifyResetCode(
              resetCode: testResetCode,
            ),
          ).called(1);
        },
      );

      test(
        'should return ApiErrorResult<VerifyResetCodeResponseEntity> when verifyResetCode fails',
        () async {
          // arrange
          const mockError = 'Invalid reset code';
          when(
            mockForgetPasswordRemoteDataSource.verifyResetCode(
              resetCode: testResetCode,
            ),
          ).thenAnswer((_) async => ApiErrorResult(mockError));

          // act
          final result = await forgetPasswordRepoImpl.verifyResetCode(
            resetCode: testResetCode,
          );

          // assert
          expect(result, isA<ApiErrorResult<VerifyResetCodeResponseEntity>>());
          final error = result as ApiErrorResult<VerifyResetCodeResponseEntity>;
          expect(error.errorMessage, mockError);
          verify(
            mockForgetPasswordRemoteDataSource.verifyResetCode(
              resetCode: testResetCode,
            ),
          ).called(1);
        },
      );
    });

    group('resetPassword', () {
      test(
        'should return ApiSuccessResult<ResetPasswordResponseEntity> when resetPassword succeeds',
        () async {
          // arrange
          final mockEntity = ResetPasswordResponseEntity(message: 'success');
          when(
            mockForgetPasswordRemoteDataSource.resetPassword(
              email: testEmail,
              newPassword: testNewPassword,
            ),
          ).thenAnswer((_) async => ApiSuccessResult(mockEntity));

          // act
          final result = await forgetPasswordRepoImpl.resetPassword(
            email: testEmail,
            newPassword: testNewPassword,
          );

          // assert
          expect(result, isA<ApiSuccessResult<ResetPasswordResponseEntity>>());
          final entity =
              (result as ApiSuccessResult<ResetPasswordResponseEntity>).data;
          expect(entity.message, 'success');
          verify(
            mockForgetPasswordRemoteDataSource.resetPassword(
              email: testEmail,
              newPassword: testNewPassword,
            ),
          ).called(1);
        },
      );

      test(
        'should return ApiErrorResult<ResetPasswordResponseEntity> when resetPassword fails',
        () async {
          // arrange
          const mockError = 'Failed to reset password';
          when(
            mockForgetPasswordRemoteDataSource.resetPassword(
              email: testEmail,
              newPassword: testNewPassword,
            ),
          ).thenAnswer((_) async => ApiErrorResult(mockError));

          // act
          final result = await forgetPasswordRepoImpl.resetPassword(
            email: testEmail,
            newPassword: testNewPassword,
          );

          // assert
          expect(result, isA<ApiErrorResult<ResetPasswordResponseEntity>>());
          final error = result as ApiErrorResult<ResetPasswordResponseEntity>;
          expect(error.errorMessage, mockError);
          verify(
            mockForgetPasswordRemoteDataSource.resetPassword(
              email: testEmail,
              newPassword: testNewPassword,
            ),
          ).called(1);
        },
      );

      test('should directly return result from remote data source', () async {
        // arrange
        final mockEntity = ResetPasswordResponseEntity(
          message: 'password reset successfully',
        );
        final expectedResult = ApiSuccessResult(mockEntity);
        when(
          mockForgetPasswordRemoteDataSource.resetPassword(
            email: testEmail,
            newPassword: testNewPassword,
          ),
        ).thenAnswer((_) async => expectedResult);

        // act
        final result = await forgetPasswordRepoImpl.resetPassword(
          email: testEmail,
          newPassword: testNewPassword,
        );

        // assert
        expect(result, equals(expectedResult));
        verify(
          mockForgetPasswordRemoteDataSource.resetPassword(
            email: testEmail,
            newPassword: testNewPassword,
          ),
        ).called(1);
      });
    });
  });
}
