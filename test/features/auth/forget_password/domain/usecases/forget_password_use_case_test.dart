import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/auth/forget_password/domain/entities/forget_password_response_entity.dart';
import 'package:tracking_app/features/auth/forget_password/domain/repositories/forget_password_repo.dart';
import 'package:tracking_app/features/auth/forget_password/domain/usecases/forget_password_use_case.dart';

import 'forget_password_use_case_test.mocks.dart';

@GenerateMocks([ForgetPasswordRepo])
void main() {
  late MockForgetPasswordRepo mockForgetPasswordRepo;
  late ForgetPasswordUseCase forgetPasswordUseCase;

  setUp(() {
    mockForgetPasswordRepo = MockForgetPasswordRepo();
    forgetPasswordUseCase = ForgetPasswordUseCase(mockForgetPasswordRepo);
    provideDummy<ApiResult<ForgetPasswordResponseEntity>>(
      ApiSuccessResult(ForgetPasswordResponseEntity(message: 'success')),
    );
  });

  group('ForgetPasswordUseCase', () {
    const testEmail = 'test@example.com';

    test(
      'should return ApiSuccessResult<ForgetPasswordResponseEntity> when repository call succeeds',
      () async {
        // arrange
        final mockEntity = ForgetPasswordResponseEntity(message: 'success');
        when(
          mockForgetPasswordRepo.forgetPassword(email: testEmail),
        ).thenAnswer((_) async => ApiSuccessResult(mockEntity));

        // act
        final result = await forgetPasswordUseCase.call(email: testEmail);

        // assert
        expect(result, isA<ApiSuccessResult<ForgetPasswordResponseEntity>>());
        final entity =
            (result as ApiSuccessResult<ForgetPasswordResponseEntity>).data;
        expect(entity.message, 'success');
        verify(
          mockForgetPasswordRepo.forgetPassword(email: testEmail),
        ).called(1);
      },
    );

    test(
      'should return ApiErrorResult<ForgetPasswordResponseEntity> when repository call fails',
      () async {
        // arrange
        const mockError = 'Email not found';
        when(
          mockForgetPasswordRepo.forgetPassword(email: testEmail),
        ).thenAnswer((_) async => ApiErrorResult(mockError));

        // act
        final result = await forgetPasswordUseCase.call(email: testEmail);

        // assert
        expect(result, isA<ApiErrorResult<ForgetPasswordResponseEntity>>());
        final error = result as ApiErrorResult<ForgetPasswordResponseEntity>;
        expect(error.errorMessage, mockError);
        verify(
          mockForgetPasswordRepo.forgetPassword(email: testEmail),
        ).called(1);
      },
    );

    test('should call repository with correct email parameter', () async {
      // arrange
      const customEmail = 'custom@example.com';
      final mockEntity = ForgetPasswordResponseEntity(message: 'success');
      when(
        mockForgetPasswordRepo.forgetPassword(email: customEmail),
      ).thenAnswer((_) async => ApiSuccessResult(mockEntity));

      // act
      await forgetPasswordUseCase.call(email: customEmail);

      // assert
      verify(
        mockForgetPasswordRepo.forgetPassword(email: customEmail),
      ).called(1);
      verifyNoMoreInteractions(mockForgetPasswordRepo);
    });

    test(
      'should directly return result from repository without modification',
      () async {
        // arrange
        final mockEntity = ForgetPasswordResponseEntity(
          message: 'Reset email sent successfully',
        );
        final expectedResult = ApiSuccessResult(mockEntity);
        when(
          mockForgetPasswordRepo.forgetPassword(email: testEmail),
        ).thenAnswer((_) async => expectedResult);

        // act
        final result = await forgetPasswordUseCase.call(email: testEmail);

        // assert
        expect(result, equals(expectedResult));
        verify(
          mockForgetPasswordRepo.forgetPassword(email: testEmail),
        ).called(1);
      },
    );

    test('should handle empty email', () async {
      // arrange
      const emptyEmail = '';
      const mockError = 'Email cannot be empty';
      when(
        mockForgetPasswordRepo.forgetPassword(email: emptyEmail),
      ).thenAnswer((_) async => ApiErrorResult(mockError));

      // act
      final result = await forgetPasswordUseCase.call(email: emptyEmail);

      // assert
      expect(result, isA<ApiErrorResult<ForgetPasswordResponseEntity>>());
      final error = result as ApiErrorResult<ForgetPasswordResponseEntity>;
      expect(error.errorMessage, mockError);
    });
  });
}
