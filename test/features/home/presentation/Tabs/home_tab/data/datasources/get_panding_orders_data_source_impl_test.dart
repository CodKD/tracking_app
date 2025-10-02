import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/core/api_layer/api_client/api_client.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/data/datasources/get_panding_orders_data_source_impl.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/data/models/pending_orders_response.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/entities/pending_orders_entity.dart';

import 'get_panding_orders_data_source_impl_test.mocks.dart';

@GenerateMocks([
  ApiClient,
  PendingOrdersResponse,
])
void main() {
  late MockApiClient mockApiClient;
  late GetPendingOrdersDataSourceImpl getPendingOrdersDataSourceImpl;

  setUp(() {
    mockApiClient = MockApiClient();
    getPendingOrdersDataSourceImpl = GetPendingOrdersDataSourceImpl(
      mockApiClient,
    );
  });

  group('GetPendingOrdersDataSourceImpl', () {
    group('getPendingDriverOrders', () {
      test(
        'should return ApiSuccessResult when getPendingDriverOrders API call succeeds with success message',
        () async {
          // arrange
          final mockDto = MockPendingOrdersResponse();
          final mockEntity = PendingDriverOrdersEntity(
            message: 'success',
            orders: [],
          );

          when(mockDto.message).thenReturn('success');
          when(mockDto.toPendingDriverOrderEntity()).thenReturn(mockEntity);
          when(mockApiClient.getPendingDriverOrders())
              .thenAnswer((_) async => mockDto);

          // act
          final result = await getPendingOrdersDataSourceImpl
              .getPendingDriverOrders();

          // assert
          expect(result, isA<ApiSuccessResult<PendingDriverOrdersEntity>>());
          final entity =
              (result as ApiSuccessResult<PendingDriverOrdersEntity>).data;
          expect(entity.message, 'success');
          verify(mockApiClient.getPendingDriverOrders()).called(1);
        },
      );

      test(
        'should return ApiErrorResult when getPendingDriverOrders API call succeeds but message is not success',
        () async {
          // arrange
          const errorMessage = 'No orders found';
          final mockDto = MockPendingOrdersResponse();

          when(mockDto.message).thenReturn(errorMessage);
          when(mockApiClient.getPendingDriverOrders())
              .thenAnswer((_) async => mockDto);

          // act
          final result = await getPendingOrdersDataSourceImpl
              .getPendingDriverOrders();

          // assert
          expect(result, isA<ApiErrorResult<PendingDriverOrdersEntity>>());
          final error = result as ApiErrorResult<PendingDriverOrdersEntity>;
          expect(error.errorMessage, errorMessage);
          verify(mockApiClient.getPendingDriverOrders()).called(1);
        },
      );

      test('should return ApiErrorResult when message is null', () async {
        // arrange
        final mockDto = MockPendingOrdersResponse();

        when(mockDto.message).thenReturn(null);
        when(mockApiClient.getPendingDriverOrders())
            .thenAnswer((_) async => mockDto);

        // act
        final result =
            await getPendingOrdersDataSourceImpl.getPendingDriverOrders();

        // assert
        expect(result, isA<ApiErrorResult<PendingDriverOrdersEntity>>());
        final error = result as ApiErrorResult<PendingDriverOrdersEntity>;
        expect(error.errorMessage, 'Unknown error');
      });

      test('should return ApiErrorResult when DioException occurs', () async {
        // arrange
        const errorMessage = 'Network error';
        when(mockApiClient.getPendingDriverOrders()).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/pending-orders'),
            message: errorMessage,
          ),
        );

        // act
        final result =
            await getPendingOrdersDataSourceImpl.getPendingDriverOrders();

        // assert
        expect(result, isA<ApiErrorResult<PendingDriverOrdersEntity>>());
        final error = result as ApiErrorResult<PendingDriverOrdersEntity>;
        expect(error.errorMessage, errorMessage);
      });

      test(
        'should return ApiErrorResult when DioException message is null',
        () async {
          // arrange
          when(mockApiClient.getPendingDriverOrders()).thenThrow(
            DioException(
              requestOptions: RequestOptions(path: '/pending-orders'),
              message: null,
            ),
          );

          // act
          final result = await getPendingOrdersDataSourceImpl
              .getPendingDriverOrders();

          // assert
          expect(result, isA<ApiErrorResult<PendingDriverOrdersEntity>>());
          final error = result as ApiErrorResult<PendingDriverOrdersEntity>;
          expect(error.errorMessage, 'Unknown Dio error');
        },
      );

      test('should throw Exception when unexpected error occurs', () async {
        // arrange
        when(mockApiClient.getPendingDriverOrders())
            .thenThrow(Exception('Unexpected error'));

        // act & assert
        expect(
          () async =>
              await getPendingOrdersDataSourceImpl.getPendingDriverOrders(),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}