import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/data/datasources/get_pending_orders_data_source.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/data/repos_impl.dart/get_pending_repo_impl.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/entities/pending_orders_entity.dart';

import 'get_pending_repo_impl_test.mocks.dart';

@GenerateMocks([
  GetPendingOrdersDataSource,
])
void main() {
  late MockGetPendingOrdersDataSource mockDataSource;
  late GetPendingOrdersRepoImpl getPendingOrdersRepoImpl;

  setUpAll(() {
    // Provide dummy value for ApiResult
    provideDummy<ApiResult<PendingDriverOrdersEntity>>(
      ApiSuccessResult<PendingDriverOrdersEntity>(
        PendingDriverOrdersEntity(
          message: 'dummy',
          orders: [],
        ),
      ),
    );
  });

  setUp(() {
    mockDataSource = MockGetPendingOrdersDataSource();
    getPendingOrdersRepoImpl = GetPendingOrdersRepoImpl(mockDataSource);
  });

  group('GetPendingOrdersRepoImpl', () {
    group('getPendingDriverOrders', () {
      test(
        'should return ApiSuccessResult when dataSource call succeeds',
        () async {
          // arrange
          final mockEntity = PendingDriverOrdersEntity(
            message: 'success',
            orders: [],
          );
          final successResult =
              ApiSuccessResult<PendingDriverOrdersEntity>(mockEntity);

          when(mockDataSource.getPendingDriverOrders())
              .thenAnswer((_) async => successResult);

          // act
          final result =
              await getPendingOrdersRepoImpl.getPendingDriverOrders();

          // assert
          expect(result, isA<ApiSuccessResult<PendingDriverOrdersEntity>>());
          final entity =
              (result as ApiSuccessResult<PendingDriverOrdersEntity>).data;
          expect(entity.message, 'success');
          verify(mockDataSource.getPendingDriverOrders()).called(1);
        },
      );

      test(
        'should return ApiErrorResult when dataSource call fails',
        () async {
          // arrange
          const errorMessage = 'Failed to fetch orders';
          final errorResult =
              ApiErrorResult<PendingDriverOrdersEntity>(errorMessage);

          when(mockDataSource.getPendingDriverOrders())
              .thenAnswer((_) async => errorResult);

          // act
          final result =
              await getPendingOrdersRepoImpl.getPendingDriverOrders();

          // assert
          expect(result, isA<ApiErrorResult<PendingDriverOrdersEntity>>());
          final error = result as ApiErrorResult<PendingDriverOrdersEntity>;
          expect(error.errorMessage, errorMessage);
          verify(mockDataSource.getPendingDriverOrders()).called(1);
        },
      );

      test('should throw Exception when dataSource throws', () async {
        // arrange
        when(mockDataSource.getPendingDriverOrders())
            .thenThrow(Exception('Unexpected error'));

        // act & assert
        expect(
          () async => await getPendingOrdersRepoImpl.getPendingDriverOrders(),
          throwsA(isA<Exception>()),
        );
        verify(mockDataSource.getPendingDriverOrders()).called(1);
      });
    });
  });
}