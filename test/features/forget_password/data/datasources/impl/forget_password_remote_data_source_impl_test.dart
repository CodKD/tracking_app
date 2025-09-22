import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/core/api_layer/api_client/api_client.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/forget_password/data/datasources/impl/forget_password_remote_data_source_impl.dart';
import 'package:tracking_app/features/forget_password/data/models/response/forget_password_response_dto.dart';
import 'package:tracking_app/features/forget_password/data/models/response/reset_password_response_dto.dart';
import 'package:tracking_app/features/forget_password/data/models/response/verify_reset_code_response_dto.dart';
import 'package:tracking_app/features/forget_password/domain/entities/forget_password_response_entity.dart';
import 'package:tracking_app/features/forget_password/domain/entities/reset_password_response_entity.dart';
import 'package:tracking_app/features/forget_password/domain/entities/verify_reset_code_entity.dart';

import 'forget_password_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([
  ApiClient,
  ForgetPasswordResponseDto,
  ResetPasswordResponseDto,
  VerifyResetCodeResponseDto,
])
void main() {
  late MockApiClient mockApiClient;
  late ForgetPasswordRemoteDataSourceImpl forgetPasswordRemoteDataSourceImpl;

  setUp(() {
    mockApiClient = MockApiClient();
    forgetPasswordRemoteDataSourceImpl = ForgetPasswordRemoteDataSourceImpl(
      mockApiClient,
    );
  });

  group('ForgetPasswordRemoteDataSourceImpl', () {
    const testEmail = 'test@example.com';
    const testResetCode = '123456';
    const testNewPassword = 'newPassword123';

    group('forgetPassword', () {
      test(
        'should return ApiSuccessResult when forgetPassword API call succeeds with success message',
        () async {
          // arrange
          final mockDto = MockForgetPasswordResponseDto();
          final mockEntity = ForgetPasswordResponseEntity(message: 'success');

          when(mockDto.message).thenReturn('success');
          when(mockDto.toEntity()).thenReturn(mockEntity);
          when(
            mockApiClient.forgetPassword(
              forgetPasswordRequestDto: anyNamed('forgetPasswordRequestDto'),
            ),
          ).thenAnswer((_) async => mockDto);

          // act
          final result = await forgetPasswordRemoteDataSourceImpl
              .forgetPassword(email: testEmail);

          // assert
          expect(result, isA<ApiSuccessResult<ForgetPasswordResponseEntity>>());
          final entity =
              (result as ApiSuccessResult<ForgetPasswordResponseEntity>).data;
          expect(entity.message, 'success');
          verify(
            mockApiClient.forgetPassword(
              forgetPasswordRequestDto: anyNamed('forgetPasswordRequestDto'),
            ),
          ).called(1);
        },
      );

      test(
        'should return ApiErrorResult when forgetPassword API call succeeds but message is not success',
        () async {
          // arrange
          const errorMessage = 'Email not found';
          final mockDto = MockForgetPasswordResponseDto();

          when(mockDto.message).thenReturn(errorMessage);
          when(
            mockApiClient.forgetPassword(
              forgetPasswordRequestDto: anyNamed('forgetPasswordRequestDto'),
            ),
          ).thenAnswer((_) async => mockDto);

          // act
          final result = await forgetPasswordRemoteDataSourceImpl
              .forgetPassword(email: testEmail);

          // assert
          expect(result, isA<ApiErrorResult<ForgetPasswordResponseEntity>>());
          final error = result as ApiErrorResult<ForgetPasswordResponseEntity>;
          expect(error.errorMessage, errorMessage);
          verify(
            mockApiClient.forgetPassword(
              forgetPasswordRequestDto: anyNamed('forgetPasswordRequestDto'),
            ),
          ).called(1);
        },
      );

      test('should return ApiErrorResult when message is null', () async {
        // arrange
        final mockDto = MockForgetPasswordResponseDto();

        when(mockDto.message).thenReturn(null);
        when(
          mockApiClient.forgetPassword(
            forgetPasswordRequestDto: anyNamed('forgetPasswordRequestDto'),
          ),
        ).thenAnswer((_) async => mockDto);

        // act
        final result = await forgetPasswordRemoteDataSourceImpl.forgetPassword(
          email: testEmail,
        );

        // assert
        expect(result, isA<ApiErrorResult<ForgetPasswordResponseEntity>>());
        final error = result as ApiErrorResult<ForgetPasswordResponseEntity>;
        expect(error.errorMessage, 'Unknown error');
      });

      test('should return ApiErrorResult when DioException occurs', () async {
        // arrange
        const errorMessage = 'Network error';
        when(
          mockApiClient.forgetPassword(
            forgetPasswordRequestDto: anyNamed('forgetPasswordRequestDto'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/forgot-password'),
            message: errorMessage,
          ),
        );

        // act
        final result = await forgetPasswordRemoteDataSourceImpl.forgetPassword(
          email: testEmail,
        );

        // assert
        expect(result, isA<ApiErrorResult<ForgetPasswordResponseEntity>>());
        final error = result as ApiErrorResult<ForgetPasswordResponseEntity>;
        expect(error.errorMessage, errorMessage);
      });

      test(
        'should return ApiErrorResult when DioException message is null',
        () async {
          // arrange
          when(
            mockApiClient.forgetPassword(
              forgetPasswordRequestDto: anyNamed('forgetPasswordRequestDto'),
            ),
          ).thenThrow(
            DioException(
              requestOptions: RequestOptions(path: '/forgot-password'),
              message: null,
            ),
          );

          // act
          final result = await forgetPasswordRemoteDataSourceImpl
              .forgetPassword(email: testEmail);

          // assert
          expect(result, isA<ApiErrorResult<ForgetPasswordResponseEntity>>());
          final error = result as ApiErrorResult<ForgetPasswordResponseEntity>;
          expect(error.errorMessage, 'Unknown Dio error');
        },
      );

      test('should throw Exception when unexpected error occurs', () async {
        // arrange
        when(
          mockApiClient.forgetPassword(
            forgetPasswordRequestDto: anyNamed('forgetPasswordRequestDto'),
          ),
        ).thenThrow(Exception('Unexpected error'));

        // act & assert
        expect(
          () async => await forgetPasswordRemoteDataSourceImpl.forgetPassword(
            email: testEmail,
          ),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('resetPassword', () {
      test(
        'should return ApiSuccessResult when resetPassword API call succeeds with success message',
        () async {
          // arrange
          final mockDto = MockResetPasswordResponseDto();
          final mockEntity = ResetPasswordResponseEntity(message: 'success');

          when(mockDto.message).thenReturn('success');
          when(mockDto.toEntity()).thenReturn(mockEntity);
          when(
            mockApiClient.resetPassword(
              resetPasswordRequestDto: anyNamed('resetPasswordRequestDto'),
            ),
          ).thenAnswer((_) async => mockDto);

          // act
          final result = await forgetPasswordRemoteDataSourceImpl.resetPassword(
            email: testEmail,
            newPassword: testNewPassword,
          );

          // assert
          expect(result, isA<ApiSuccessResult<ResetPasswordResponseEntity>>());
          final entity =
              (result as ApiSuccessResult<ResetPasswordResponseEntity>).data;
          expect(entity.message, 'success');
          verify(
            mockApiClient.resetPassword(
              resetPasswordRequestDto: anyNamed('resetPasswordRequestDto'),
            ),
          ).called(1);
        },
      );

      test(
        'should return ApiErrorResult when resetPassword API call succeeds but message is not success',
        () async {
          // arrange
          const errorMessage = 'Invalid reset token';
          final mockDto = MockResetPasswordResponseDto();

          when(mockDto.message).thenReturn(errorMessage);
          when(
            mockApiClient.resetPassword(
              resetPasswordRequestDto: anyNamed('resetPasswordRequestDto'),
            ),
          ).thenAnswer((_) async => mockDto);

          // act
          final result = await forgetPasswordRemoteDataSourceImpl.resetPassword(
            email: testEmail,
            newPassword: testNewPassword,
          );

          // assert
          expect(result, isA<ApiErrorResult<ResetPasswordResponseEntity>>());
          final error = result as ApiErrorResult<ResetPasswordResponseEntity>;
          expect(error.errorMessage, errorMessage);
        },
      );

      test('should return ApiErrorResult when DioException occurs', () async {
        // arrange
        const errorMessage = 'Network timeout';
        when(
          mockApiClient.resetPassword(
            resetPasswordRequestDto: anyNamed('resetPasswordRequestDto'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/reset-password'),
            message: errorMessage,
          ),
        );

        // act
        final result = await forgetPasswordRemoteDataSourceImpl.resetPassword(
          email: testEmail,
          newPassword: testNewPassword,
        );

        // assert
        expect(result, isA<ApiErrorResult<ResetPasswordResponseEntity>>());
        final error = result as ApiErrorResult<ResetPasswordResponseEntity>;
        expect(error.errorMessage, errorMessage);
      });

      test('should throw Exception when unexpected error occurs', () async {
        // arrange
        when(
          mockApiClient.resetPassword(
            resetPasswordRequestDto: anyNamed('resetPasswordRequestDto'),
          ),
        ).thenThrow(Exception('Unexpected error'));

        // act & assert
        expect(
          () async => await forgetPasswordRemoteDataSourceImpl.resetPassword(
            email: testEmail,
            newPassword: testNewPassword,
          ),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('verifyResetCode', () {
      test(
        'should return ApiSuccessResult when verifyResetCode API call succeeds',
        () async {
          // arrange
          final mockDto = MockVerifyResetCodeResponseDto();
          final mockEntity = VerifyResetCodeResponseEntity(status: 'success');

          when(mockDto.toEntity()).thenReturn(mockEntity);
          when(
            mockApiClient.verifyResetCode(
              verifyResetCodeRequestDto: anyNamed('verifyResetCodeRequestDto'),
            ),
          ).thenAnswer((_) async => mockDto);

          // act
          final result = await forgetPasswordRemoteDataSourceImpl
              .verifyResetCode(resetCode: testResetCode);

          // assert
          expect(
            result,
            isA<ApiSuccessResult<VerifyResetCodeResponseEntity>>(),
          );
          final entity =
              (result as ApiSuccessResult<VerifyResetCodeResponseEntity>).data;
          expect(entity.status, 'success');
          verify(
            mockApiClient.verifyResetCode(
              verifyResetCodeRequestDto: anyNamed('verifyResetCodeRequestDto'),
            ),
          ).called(1);
        },
      );

      test('should return ApiErrorResult when DioException occurs', () async {
        // arrange
        const errorMessage = 'Connection failed';
        when(
          mockApiClient.verifyResetCode(
            verifyResetCodeRequestDto: anyNamed('verifyResetCodeRequestDto'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/verify-code'),
            message: errorMessage,
          ),
        );

        // act
        final result = await forgetPasswordRemoteDataSourceImpl.verifyResetCode(
          resetCode: testResetCode,
        );

        // assert
        expect(result, isA<ApiErrorResult<VerifyResetCodeResponseEntity>>());
        final error = result as ApiErrorResult<VerifyResetCodeResponseEntity>;
        expect(error.errorMessage, errorMessage);
      });

      test('should throw Exception when unexpected error occurs', () async {
        // arrange
        when(
          mockApiClient.verifyResetCode(
            verifyResetCodeRequestDto: anyNamed('verifyResetCodeRequestDto'),
          ),
        ).thenThrow(Exception('Unexpected error'));

        // act & assert
        expect(
          () async => await forgetPasswordRemoteDataSourceImpl.verifyResetCode(
            resetCode: testResetCode,
          ),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
