import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/orders/domain/entities/my_orders_entity.dart';
import 'package:tracking_app/features/orders/domain/repositories/my_orders_repo.dart';
import 'package:tracking_app/features/orders/domain/use_cases/my_orders_use_case.dart';

import 'my_orders_use_case_test.mocks.dart';


@GenerateMocks([MyOrdersRepo])
void main() {
  late MockMyOrdersRepo mockRepo;
  late MyOrdersUseCase useCase;

  setUpAll(() {
    provideDummy<ApiResult<MyOrdersEntity>>(
      ApiSuccessResult<MyOrdersEntity>(
        MyOrdersEntity(orders: []),
      ),
    );
  });

  setUp(() {
    mockRepo = MockMyOrdersRepo();
    useCase = MyOrdersUseCase(mockRepo);
  });

  group('MyOrdersUseCase', () {
    group('getMyOrders', () {
      test('should return ApiSuccessResult when repo call succeeds', () async {
        // arrange
        final mockEntity = MyOrdersEntity(orders: []);
        final successResult = ApiSuccessResult<MyOrdersEntity>(mockEntity);

        when(mockRepo.getMyOrders()).thenAnswer((_) async => successResult);

        // act
        final result = await useCase.getMyOrders();

        // assert
        expect(result, isA<ApiSuccessResult<MyOrdersEntity>>());
        verify(mockRepo.getMyOrders()).called(1);
      });

      test('should return ApiErrorResult when repo call fails', () async {
        // arrange
        const errorMessage = 'Failed to get orders';
        final errorResult = ApiErrorResult<MyOrdersEntity>(errorMessage);

        when(mockRepo.getMyOrders()).thenAnswer((_) async => errorResult);

        // act
        final result = await useCase.getMyOrders();

        // assert
        expect(result, isA<ApiErrorResult<MyOrdersEntity>>());
        final error = result as ApiErrorResult<MyOrdersEntity>;
        expect(error.errorMessage, errorMessage);
        verify(mockRepo.getMyOrders()).called(1);
      });

      test('should throw Exception when repo throws', () async {
        // arrange
        when(mockRepo.getMyOrders()).thenThrow(Exception('Unexpected error'));

        // act & assert
        expect(
          () async => await useCase.getMyOrders(),
          throwsA(isA<Exception>()),
        );
        verify(mockRepo.getMyOrders()).called(1);
      });
    });
  });
}