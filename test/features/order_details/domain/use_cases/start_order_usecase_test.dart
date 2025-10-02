import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/order_details/data/models/request/update_order_request.dart';
import 'package:tracking_app/features/order_details/domain/entities/start_order_entity.dart';
import 'package:tracking_app/features/order_details/domain/entities/update_order_state_entity.dart';
import 'package:tracking_app/features/order_details/domain/repo/start_order_repo.dart';
import 'package:tracking_app/features/order_details/domain/use_cases/start_order_usecase.dart';

import 'start_order_usecase_test.mocks.dart';

@GenerateMocks([
  OrderDetailsRepo,
])
void main() {
  late MockOrderDetailsRepo mockRepository;
  late StartOrderUseCase startOrderUseCase;

  setUpAll(() {
    // Provide dummy values for ApiResult
    provideDummy<ApiResult<StartOrderEntity?>>(
      ApiSuccessResult<StartOrderEntity?>(
        StartOrderEntity(
          message: 'dummy',
        ),
      ),
    );

    provideDummy<ApiResult<UpdateOrderStateEntity?>>(
      ApiSuccessResult<UpdateOrderStateEntity?>(
        UpdateOrderStateEntity(
          message: 'dummy',
        ),
      ),
    );
  });

  setUp(() {
    mockRepository = MockOrderDetailsRepo();
    startOrderUseCase = StartOrderUseCase(mockRepository);
  });

  group('StartOrderUseCase', () {
    const testOrderId = 'order123';

    group('startOrder', () {
      test(
        'should return ApiSuccessResult when repository call succeeds',
        () async {
          // arrange
          final mockEntity = StartOrderEntity(
            message: 'success',
          );
          final successResult = ApiSuccessResult<StartOrderEntity?>(mockEntity);

          when(mockRepository.startOrder(testOrderId))
              .thenAnswer((_) async => successResult);

          // act
          final result = await startOrderUseCase.startOrder(testOrderId);

          // assert
          expect(result, isA<ApiSuccessResult<StartOrderEntity?>>());
          final entity = (result as ApiSuccessResult<StartOrderEntity?>).data;
          expect(entity?.message, 'success');
          verify(mockRepository.startOrder(testOrderId)).called(1);
        },
      );

      test(
        'should return ApiErrorResult when repository call fails',
        () async {
          // arrange
          const errorMessage = 'Failed to start order';
          final errorResult = ApiErrorResult<StartOrderEntity?>(errorMessage);

          when(mockRepository.startOrder(testOrderId))
              .thenAnswer((_) async => errorResult);

          // act
          final result = await startOrderUseCase.startOrder(testOrderId);

          // assert
          expect(result, isA<ApiErrorResult<StartOrderEntity?>>());
          final error = result as ApiErrorResult<StartOrderEntity?>;
          expect(error.errorMessage, errorMessage);
          verify(mockRepository.startOrder(testOrderId)).called(1);
        },
      );

      test('should throw Exception when repository throws', () async {
        // arrange
        when(mockRepository.startOrder(testOrderId))
            .thenThrow(Exception('Unexpected error'));

        // act & assert
        expect(
          () async => await startOrderUseCase.startOrder(testOrderId),
          throwsA(isA<Exception>()),
        );
        verify(mockRepository.startOrder(testOrderId)).called(1);
      });
    });

    group('updateOrder', () {
      final testUpdateRequest = UpdateOrderRequest(
        state: 'completed',
      );

      test(
        'should return ApiSuccessResult when repository call succeeds',
        () async {
          // arrange
          final mockEntity = UpdateOrderStateEntity(
            message: 'success',
          );
          final successResult =
              ApiSuccessResult<UpdateOrderStateEntity?>(mockEntity);

          when(mockRepository.updateOrder(testOrderId, testUpdateRequest))
              .thenAnswer((_) async => successResult);

          // act
          final result = await startOrderUseCase.updateOrder(
            testOrderId,
            testUpdateRequest,
          );

          // assert
          expect(result, isA<ApiSuccessResult<UpdateOrderStateEntity?>>());
          final entity =
              (result as ApiSuccessResult<UpdateOrderStateEntity?>).data;
          expect(entity?.message, 'success');
          verify(mockRepository.updateOrder(testOrderId, testUpdateRequest))
              .called(1);
        },
      );

      test(
        'should return ApiErrorResult when repository call fails',
        () async {
          // arrange
          const errorMessage = 'Failed to update order';
          final errorResult =
              ApiErrorResult<UpdateOrderStateEntity?>(errorMessage);

          when(mockRepository.updateOrder(testOrderId, testUpdateRequest))
              .thenAnswer((_) async => errorResult);

          // act
          final result = await startOrderUseCase.updateOrder(
            testOrderId,
            testUpdateRequest,
          );

          // assert
          expect(result, isA<ApiErrorResult<UpdateOrderStateEntity?>>());
          final error = result as ApiErrorResult<UpdateOrderStateEntity?>;
          expect(error.errorMessage, errorMessage);
          verify(mockRepository.updateOrder(testOrderId, testUpdateRequest))
              .called(1);
        },
      );

      test('should throw Exception when repository throws', () async {
        // arrange
        when(mockRepository.updateOrder(testOrderId, testUpdateRequest))
            .thenThrow(Exception('Unexpected error'));

        // act & assert
        expect(
          () async => await startOrderUseCase.updateOrder(
            testOrderId,
            testUpdateRequest,
          ),
          throwsA(isA<Exception>()),
        );
        verify(mockRepository.updateOrder(testOrderId, testUpdateRequest))
            .called(1);
      });
    });
  });
}