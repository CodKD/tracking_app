// import 'package:dio/dio.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:test/test.dart';
// import 'package:tracking_app/core/api_layer/api_client/api_client.dart';
// import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
// import 'package:tracking_app/features/orders/data/data_sources/my_orders_online_data_source_impl.dart';
// import 'package:tracking_app/features/orders/data/models/my_orders_response.dart';
// import 'package:tracking_app/features/orders/domain/entities/my_orders_entity.dart';
//
// import 'my_orders_online_data_source_impl_test.mocks.dart';
//
// @GenerateMocks([ApiClient])
// void main() {
//   late MockApiClient mockApiClient;
//   late MyOrdersOnlineDataSourceImpl dataSourceImpl;
//
//   setUp(() {
//     mockApiClient = MockApiClient();
//     dataSourceImpl = MyOrdersOnlineDataSourceImpl(mockApiClient);
//   });
//
//   group('MyOrdersOnlineDataSourceImpl', () {
//     group('getMyOrders', () {
//       test(
//         ' should return ApiSuccessResult when API call succeeds',
//         () async {
//           // arrange
//           final response = MyOrdersResponse(
//             message: 'success',
//             orders: [],
//           );
//
//           when(mockApiClient.getMyOrders()).thenAnswer((_) async => response);
//
//           // act
//           final result = await dataSourceImpl.getMyOrders();
//
//           // assert
//           expect(result, isA<ApiSuccessResult<MyOrdersEntity>>());
//           final entity = (result as ApiSuccessResult<MyOrdersEntity>).data;
//           expect(entity.message, 'success');
//           verify(mockApiClient.getMyOrders()).called(1);
//         },
//       );
//
//       test(
//         ' should return ApiErrorResult when DioException occurs',
//         () async {
//           // arrange
//           when(mockApiClient.getMyOrders()).thenThrow(
//             DioException(
//               requestOptions: RequestOptions(path: '/get-my-orders'),
//               message: 'Network error',
//             ),
//           );
//
//           // act
//           final result = await dataSourceImpl.getMyOrders();
//
//           // assert
//           expect(result, isA<ApiErrorResult<MyOrdersEntity>>());
//           final error = result as ApiErrorResult<MyOrdersEntity>;
//           expect(error.errorMessage, contains('DioException'));
//           verify(mockApiClient.getMyOrders()).called(1);
//         },
//       );
//
//       test(
//         ' should return ApiErrorResult when generic Exception occurs',
//         () async {
//           // arrange
//           when(mockApiClient.getMyOrders())
//               .thenThrow(Exception('Unexpected error'));
//
//           // act
//           final result = await dataSourceImpl.getMyOrders();
//
//           // assert
//           expect(result, isA<ApiErrorResult<MyOrdersEntity>>());
//           final error = result as ApiErrorResult<MyOrdersEntity>;
//           expect(error.errorMessage, contains('Unexpected error'));
//           verify(mockApiClient.getMyOrders()).called(1);
//         },
//       );
//     });
//   });
// }
