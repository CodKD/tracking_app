import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/orders/data/data_sources/my_orders_online_data_source.dart';
import 'package:tracking_app/features/orders/data/repositories/my_orders_repo_impl.dart';
import 'package:tracking_app/features/orders/domain/entities/my_orders_entity.dart';

import 'my_orders_repo_impl_test.mocks.dart';


@GenerateMocks([MyOrdersOnlineDataSource])
void main() {
  late MockMyOrdersOnlineDataSource mockDataSource;
  late MyOrdersRepoImpl repoImpl;

  setUpAll(() {
    provideDummy<ApiResult<MyOrdersEntity>>(
      ApiSuccessResult<MyOrdersEntity>(
        MyOrdersEntity(orders: []),
      ),
    );
  });

  setUp(() {
    mockDataSource = MockMyOrdersOnlineDataSource();
    repoImpl = MyOrdersRepoImpl(mockDataSource);
  });

  group('MyOrdersRepoImpl', () {
    group('getMyOrders', () {
      test('should return ApiSuccessResult when dataSource call succeeds',
          () async {
        // arrange
        final mockEntity = MyOrdersEntity(orders: []);
        final successResult = ApiSuccessResult<MyOrdersEntity>(mockEntity);

        when(mockDataSource.getMyOrders())
            .thenAnswer((_) async => successResult);

        // act
        final result = await repoImpl.getMyOrders();

        // assert
        expect(result, isA<ApiSuccessResult<MyOrdersEntity>>());
        verify(mockDataSource.getMyOrders()).called(1);
      });

      test('should return ApiErrorResult when dataSource call fails',
          () async {
        // arrange
        const errorMessage = 'Failed to get orders';
        final errorResult = ApiErrorResult<MyOrdersEntity>(errorMessage);

        when(mockDataSource.getMyOrders())
            .thenAnswer((_) async => errorResult);

        // act
        final result = await repoImpl.getMyOrders();

        // assert
        expect(result, isA<ApiErrorResult<MyOrdersEntity>>());
        final error = result as ApiErrorResult<MyOrdersEntity>;
        expect(error.errorMessage, errorMessage);
        verify(mockDataSource.getMyOrders()).called(1);
      });

      test('should throw Exception when dataSource throws', () async {
        // arrange
        when(mockDataSource.getMyOrders())
            .thenThrow(Exception('Unexpected error'));

        // act & assert
        expect(
          () async => await repoImpl.getMyOrders(),
          throwsA(isA<Exception>()),
        );
        verify(mockDataSource.getMyOrders()).called(1);
      });
    });
  });
}