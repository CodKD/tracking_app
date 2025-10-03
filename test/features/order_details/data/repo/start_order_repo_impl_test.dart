import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/order_details/data/data_sources/start_order_data_sources_repo.dart';
import 'package:tracking_app/features/order_details/data/models/request/update_order_request.dart';
import 'package:tracking_app/features/order_details/data/repo/start_order_repo_impl.dart';
import 'package:tracking_app/features/order_details/domain/entities/start_order_entity.dart';
import 'package:tracking_app/features/order_details/domain/entities/update_order_state_entity.dart';

import 'start_order_repo_impl_test.mocks.dart';

@GenerateMocks([
  OrderDetailsDataSourcesRepo,
])
void main() {
  late MockOrderDetailsDataSourcesRepo mockDataSource;
  late StarOrderRepoImpl starOrderRepoImpl;

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
    mockDataSource = MockOrderDetailsDataSourcesRepo();
    starOrderRepoImpl = StarOrderRepoImpl(mockDataSource);
  });

  group('StarOrderRepoImpl', () {
    const testOrderId = 'order123';

    group('startOrder', () {
      test(
        'should return ApiSuccessResult when dataSource call succeeds',
        () async {
          // arrange
          final mockEntity = StartOrderEntity(
            message: 'success',
          );
          final successResult = ApiSuccessResult<StartOrderEntity?>(mockEntity);

          when(mockDataSource.startOrder(testOrderId))
              .thenAnswer((_) async => successResult);

          // act
          final result = await starOrderRepoImpl.startOrder(testOrderId);

          // assert
          expect(result, isA<ApiSuccessResult<StartOrderEntity?>>());
          final entity = (result as ApiSuccessResult<StartOrderEntity?>).data;
          expect(entity?.message, 'success');
          verify(mockDataSource.startOrder(testOrderId)).called(1);
        },
      );

      test(
        'should return ApiErrorResult when dataSource call fails',
        () async {
          // arrange
          const errorMessage = 'Failed to start order';
          final errorResult = ApiErrorResult<StartOrderEntity?>(errorMessage);

          when(mockDataSource.startOrder(testOrderId))
              .thenAnswer((_) async => errorResult);

          // act
          final result = await starOrderRepoImpl.startOrder(testOrderId);

          // assert
          expect(result, isA<ApiErrorResult<StartOrderEntity?>>());
          final error = result as ApiErrorResult<StartOrderEntity?>;
          expect(error.errorMessage, errorMessage);
          verify(mockDataSource.startOrder(testOrderId)).called(1);
        },
      );

      test('should throw Exception when dataSource throws', () async {
        // arrange
        when(mockDataSource.startOrder(testOrderId))
            .thenThrow(Exception('Unexpected error'));

        // act & assert
        expect(
          () async => await starOrderRepoImpl.startOrder(testOrderId),
          throwsA(isA<Exception>()),
        );
        verify(mockDataSource.startOrder(testOrderId)).called(1);
      });
    });

    group('updateOrder', () {
      final testUpdateRequest = UpdateOrderRequest(
        state: 'completed',
      );

      test(
        'should return ApiSuccessResult when dataSource call succeeds',
        () async {
          // arrange
          final mockEntity = UpdateOrderStateEntity(
            message: 'success',
          );
          final successResult =
              ApiSuccessResult<UpdateOrderStateEntity?>(mockEntity);

          when(mockDataSource.updateOrder(testOrderId, testUpdateRequest))
              .thenAnswer((_) async => successResult);

          // act
          final result = await starOrderRepoImpl.updateOrder(
            testOrderId,
            testUpdateRequest,
          );

          // assert
          expect(result, isA<ApiSuccessResult<UpdateOrderStateEntity?>>());
          final entity =
              (result as ApiSuccessResult<UpdateOrderStateEntity?>).data;
          expect(entity?.message, 'success');
          verify(mockDataSource.updateOrder(testOrderId, testUpdateRequest))
              .called(1);
        },
      );

      test(
        'should return ApiErrorResult when dataSource call fails',
        () async {
          // arrange
          const errorMessage = 'Failed to update order';
          final errorResult =
              ApiErrorResult<UpdateOrderStateEntity?>(errorMessage);

          when(mockDataSource.updateOrder(testOrderId, testUpdateRequest))
              .thenAnswer((_) async => errorResult);

          // act
          final result = await starOrderRepoImpl.updateOrder(
            testOrderId,
            testUpdateRequest,
          );

          // assert
          expect(result, isA<ApiErrorResult<UpdateOrderStateEntity?>>());
          final error = result as ApiErrorResult<UpdateOrderStateEntity?>;
          expect(error.errorMessage, errorMessage);
          verify(mockDataSource.updateOrder(testOrderId, testUpdateRequest))
              .called(1);
        },
      );

      test('should throw Exception when dataSource throws', () async {
        // arrange
        when(mockDataSource.updateOrder(testOrderId, testUpdateRequest))
            .thenThrow(Exception('Unexpected error'));

        // act & assert
        expect(
          () async => await starOrderRepoImpl.updateOrder(
            testOrderId,
            testUpdateRequest,
          ),
          throwsA(isA<Exception>()),
        );
        verify(mockDataSource.updateOrder(testOrderId, testUpdateRequest))
            .called(1);
      });
    });
  });
}