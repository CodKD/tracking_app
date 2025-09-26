import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/auth/forget_password/domain/entities/verify_reset_code_entity.dart';
import 'package:tracking_app/features/auth/forget_password/domain/repositories/forget_password_repo.dart';
import 'package:tracking_app/features/auth/forget_password/domain/usecases/varify_reset_code_use_case.dart';

import 'forget_password_use_case_test.mocks.dart';

@GenerateMocks([ForgetPasswordRepo])
void main() {
  late MockForgetPasswordRepo mockForgetPasswordRepo;
  late VerifyResetCodeUseCase verifyResetCodeUseCase;

  setUp(() {
    mockForgetPasswordRepo = MockForgetPasswordRepo();
    verifyResetCodeUseCase = VerifyResetCodeUseCase(mockForgetPasswordRepo);

    provideDummy<ApiResult<VerifyResetCodeResponseEntity>>(
      ApiSuccessResult(VerifyResetCodeResponseEntity(status: 'success')),
    );
  });

  group('VerifyResetCodeUseCase', () {
    const testResetCode = '123456';

    test(
      'should return ApiSuccessResult<VerifyResetCodeResponseEntity> when repository call succeeds',
      () async {
        // arrange
        final mockEntity = VerifyResetCodeResponseEntity(status: 'success');
        when(
          mockForgetPasswordRepo.verifyResetCode(resetCode: testResetCode),
        ).thenAnswer((_) async => ApiSuccessResult(mockEntity));

        // act
        final result = await verifyResetCodeUseCase.call(
          resetCode: testResetCode,
        );

        // assert
        expect(result, isA<ApiSuccessResult<VerifyResetCodeResponseEntity>>());
        final entity =
            (result as ApiSuccessResult<VerifyResetCodeResponseEntity>).data;
        expect(entity.status, 'success');
        verify(
          mockForgetPasswordRepo.verifyResetCode(resetCode: testResetCode),
        ).called(1);
      },
    );

    test(
      'should return ApiErrorResult<VerifyResetCodeResponseEntity> when repository call fails',
      () async {
        // arrange
        const mockError = 'Invalid or expired reset code';
        when(
          mockForgetPasswordRepo.verifyResetCode(resetCode: testResetCode),
        ).thenAnswer((_) async => ApiErrorResult(mockError));

        // act
        final result = await verifyResetCodeUseCase.call(
          resetCode: testResetCode,
        );

        // assert
        expect(result, isA<ApiErrorResult<VerifyResetCodeResponseEntity>>());
        final error = result as ApiErrorResult<VerifyResetCodeResponseEntity>;
        expect(error.errorMessage, mockError);
        verify(
          mockForgetPasswordRepo.verifyResetCode(resetCode: testResetCode),
        ).called(1);
      },
    );

    test('should call repository with correct resetCode parameter', () async {
      // arrange
      const customResetCode = '789012';
      final mockEntity = VerifyResetCodeResponseEntity(status: 'success');
      when(
        mockForgetPasswordRepo.verifyResetCode(resetCode: customResetCode),
      ).thenAnswer((_) async => ApiSuccessResult(mockEntity));

      // act
      await verifyResetCodeUseCase.call(resetCode: customResetCode);

      // assert
      verify(
        mockForgetPasswordRepo.verifyResetCode(resetCode: customResetCode),
      ).called(1);
      verifyNoMoreInteractions(mockForgetPasswordRepo);
    });

    test(
      'should directly return result from repository without modification',
      () async {
        // arrange
        final mockEntity = VerifyResetCodeResponseEntity(
          status: 'Reset code verified successfully',
        );
        final expectedResult = ApiSuccessResult(mockEntity);
        when(
          mockForgetPasswordRepo.verifyResetCode(resetCode: testResetCode),
        ).thenAnswer((_) async => expectedResult);

        // act
        final result = await verifyResetCodeUseCase.call(
          resetCode: testResetCode,
        );

        // assert
        expect(result, equals(expectedResult));
        verify(
          mockForgetPasswordRepo.verifyResetCode(resetCode: testResetCode),
        ).called(1);
      },
    );

    test('should handle empty reset code', () async {
      // arrange
      const emptyResetCode = '';
      const mockError = 'Reset code cannot be empty';
      when(
        mockForgetPasswordRepo.verifyResetCode(resetCode: emptyResetCode),
      ).thenAnswer((_) async => ApiErrorResult(mockError));

      // act
      final result = await verifyResetCodeUseCase.call(
        resetCode: emptyResetCode,
      );

      // assert
      expect(result, isA<ApiErrorResult<VerifyResetCodeResponseEntity>>());
      final error = result as ApiErrorResult<VerifyResetCodeResponseEntity>;
      expect(error.errorMessage, mockError);
      verify(
        mockForgetPasswordRepo.verifyResetCode(resetCode: emptyResetCode),
      ).called(1);
    });

    test('should handle invalid reset code format', () async {
      // arrange
      const invalidCode = 'abc';
      const mockError = 'Invalid reset code format';
      when(
        mockForgetPasswordRepo.verifyResetCode(resetCode: invalidCode),
      ).thenAnswer((_) async => ApiErrorResult(mockError));

      // act
      final result = await verifyResetCodeUseCase.call(resetCode: invalidCode);

      // assert
      expect(result, isA<ApiErrorResult<VerifyResetCodeResponseEntity>>());
      final error = result as ApiErrorResult<VerifyResetCodeResponseEntity>;
      expect(error.errorMessage, mockError);
    });
  });
}
