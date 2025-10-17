// import 'package:dio/dio.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:test/test.dart';
// import 'package:tracking_app/core/api_layer/api_client/api_client.dart';
// import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
// import 'package:tracking_app/features/order_details/data/data_sources/start_order_data_sources_repo_impl.dart';
// import 'package:tracking_app/features/order_details/data/models/request/update_order_request.dart';
// import 'package:tracking_app/features/order_details/data/models/response/start_order_model.dart';
// import 'package:tracking_app/features/order_details/data/models/response/update_order_state_response.dart';
// import 'package:tracking_app/features/order_details/domain/entities/start_order_entity.dart';
// import 'package:tracking_app/features/order_details/domain/entities/update_order_state_entity.dart';
//
// import 'start_order_data_sources_repo_impl_test.mocks.dart';
//
// @GenerateMocks([ApiClient])
// void main() {
//   late MockApiClient mockApiClient;
//   late StartOrderDataSourcesRepoImpl dataSourceImpl;
//
//   setUp(() {
//     mockApiClient = MockApiClient();
//     dataSourceImpl = StartOrderDataSourcesRepoImpl(mockApiClient);
//   });
//
//   group('StartOrderDataSourcesRepoImpl', () {
//     const testOrderId = 'order123';
//
//     group('startOrder', () {
//       test(
//         'should return ApiSuccessResult when API call succeeds',
//         () async {
//           // arrange
//           final response = StartOrderModel(
//             message: 'success',
//           );
//
//           when(mockApiClient.startOrder(testOrderId))
//               .thenAnswer((_) async => response);
//
//           // act
//           final result = await dataSourceImpl.startOrder(testOrderId);
//
//           // assert
//           expect(result, isA<ApiSuccessResult<StartOrderEntity?>>());
//           final entity = (result as ApiSuccessResult<StartOrderEntity?>).data;
//           expect(entity, isNotNull);
//           expect(entity?.message, 'success');
//           verify(mockApiClient.startOrder(testOrderId)).called(1);
//         },
//       );
//
//       test(
//         'should return ApiSuccessResult with null when response is null',
//         () async {
//           // arrange
//           when(mockApiClient.startOrder(testOrderId))
//               .thenAnswer((_) async => null);
//
//           // act
//           final result = await dataSourceImpl.startOrder(testOrderId);
//
//           // assert
//           expect(result, isA<ApiSuccessResult<StartOrderEntity?>>());
//           final entity = (result as ApiSuccessResult<StartOrderEntity?>).data;
//           expect(entity, isNull);
//           verify(mockApiClient.startOrder(testOrderId)).called(1);
//         },
//       );
//
//       test(
//         'should return ApiErrorResult when DioException occurs',
//         () async {
//           // arrange
//           const errorMessage = 'Network error';
//           when(mockApiClient.startOrder(testOrderId)).thenThrow(
//             DioException(
//               requestOptions: RequestOptions(path: '/start-order'),
//               message: errorMessage,
//             ),
//           );
//
//           // act
//           final result = await dataSourceImpl.startOrder(testOrderId);
//
//           // assert
//           expect(result, isA<ApiErrorResult<StartOrderEntity?>>());
//           final error = result as ApiErrorResult<StartOrderEntity?>;
//           expect(error.errorMessage, contains('DioException'));
//           verify(mockApiClient.startOrder(testOrderId)).called(1);
//         },
//       );
//
//       test(
//         'should return ApiErrorResult when generic Exception occurs',
//         () async {
//           // arrange
//           const errorMessage = 'Unexpected error';
//           when(mockApiClient.startOrder(testOrderId))
//               .thenThrow(Exception(errorMessage));
//
//           // act
//           final result = await dataSourceImpl.startOrder(testOrderId);
//
//           // assert
//           expect(result, isA<ApiErrorResult<StartOrderEntity?>>());
//           final error = result as ApiErrorResult<StartOrderEntity?>;
//           expect(error.errorMessage, contains(errorMessage));
//           verify(mockApiClient.startOrder(testOrderId)).called(1);
//         },
//       );
//     });
//
//     group('updateOrder', () {
//       final testUpdateRequest = UpdateOrderRequest(
//         state: 'completed',
//       );
//
//       test(
//         'should return ApiSuccessResult when API call succeeds',
//         () async {
//           // arrange
//           final response = UpdateOrderStateResponse(
//             message: 'success',
//           );
//
//           when(mockApiClient.updateOrder(testOrderId, testUpdateRequest))
//               .thenAnswer((_) async => response);
//
//           // act
//           final result = await dataSourceImpl.updateOrder(
//             testOrderId,
//             testUpdateRequest,
//           );
//
//           // assert
//           expect(result, isA<ApiSuccessResult<UpdateOrderStateEntity?>>());
//           final entity =
//               (result as ApiSuccessResult<UpdateOrderStateEntity?>).data;
//           expect(entity, isNotNull);
//           expect(entity?.message, 'success');
//           verify(mockApiClient.updateOrder(testOrderId, testUpdateRequest))
//               .called(1);
//         },
//       );
//
//       test(
//         'should return ApiSuccessResult with null when response is null',
//         () async {
//           // arrange
//           when(mockApiClient.updateOrder(testOrderId, testUpdateRequest))
//               .thenAnswer((_) async => null);
//
//           // act
//           final result = await dataSourceImpl.updateOrder(
//             testOrderId,
//             testUpdateRequest,
//           );
//
//           // assert
//           expect(result, isA<ApiSuccessResult<UpdateOrderStateEntity?>>());
//           final entity =
//               (result as ApiSuccessResult<UpdateOrderStateEntity?>).data;
//           expect(entity, isNull);
//           verify(mockApiClient.updateOrder(testOrderId, testUpdateRequest))
//               .called(1);
//         },
//       );
//
//       test(
//         'should return ApiErrorResult when DioException occurs',
//         () async {
//           // arrange
//           const errorMessage = 'Network timeout';
//           when(mockApiClient.updateOrder(testOrderId, testUpdateRequest))
//               .thenThrow(
//             DioException(
//               requestOptions: RequestOptions(path: '/update-order'),
//               message: errorMessage,
//             ),
//           );
//
//           // act
//           final result = await dataSourceImpl.updateOrder(
//             testOrderId,
//             testUpdateRequest,
//           );
//
//           // assert
//           expect(result, isA<ApiErrorResult<UpdateOrderStateEntity?>>());
//           final error = result as ApiErrorResult<UpdateOrderStateEntity?>;
//           expect(error.errorMessage, contains('DioException'));
//           verify(mockApiClient.updateOrder(testOrderId, testUpdateRequest))
//               .called(1);
//         },
//       );
//
//       test(
//         'should return ApiErrorResult when generic Exception occurs',
//         () async {
//           // arrange
//           const errorMessage = 'Server error';
//           when(mockApiClient.updateOrder(testOrderId, testUpdateRequest))
//               .thenThrow(Exception(errorMessage));
//
//           // act
//           final result = await dataSourceImpl.updateOrder(
//             testOrderId,
//             testUpdateRequest,
//           );
//
//           // assert
//           expect(result, isA<ApiErrorResult<UpdateOrderStateEntity?>>());
//           final error = result as ApiErrorResult<UpdateOrderStateEntity?>;
//           expect(error.errorMessage, contains(errorMessage));
//           verify(mockApiClient.updateOrder(testOrderId, testUpdateRequest))
//               .called(1);
//         },
//       );
//     });
//   });
// }