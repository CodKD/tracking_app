import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/entities/pending_orders_entity.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/repositories/get_pending_orders_repo.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/usecases/get_pending_use_case.dart';

import 'get_pending_use_case_test.mocks.dart';

@GenerateMocks([
  GetPendingOrdersRepo,
])
void main() {
  late MockGetPendingOrdersRepo mockRepository;
  late GetPendingOrdersUseCase getPendingOrdersUseCase;

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
    mockRepository = MockGetPendingOrdersRepo();
    getPendingOrdersUseCase = GetPendingOrdersUseCase(mockRepository);
  });

  group('GetPendingOrdersUseCase', () {
    test(
      'should return ApiSuccessResult when repository call succeeds',
      () async {
        // arrange
        final mockEntity = PendingDriverOrdersEntity(
          message: 'success',
          orders: [],
        );
        final successResult =
            ApiSuccessResult<PendingDriverOrdersEntity>(mockEntity);

        when(mockRepository.getPendingDriverOrders())
            .thenAnswer((_) async => successResult);

        // act
        final result = await getPendingOrdersUseCase.call();

        // assert
        expect(result, isA<ApiSuccessResult<PendingDriverOrdersEntity>>());
        final entity =
            (result as ApiSuccessResult<PendingDriverOrdersEntity>).data;
        expect(entity.message, 'success');
        verify(mockRepository.getPendingDriverOrders()).called(1);
      },
    );

    test(
      'should return ApiErrorResult when repository call fails',
      () async {
        // arrange
        const errorMessage = 'Failed to fetch orders';
        final errorResult =
            ApiErrorResult<PendingDriverOrdersEntity>(errorMessage);

        when(mockRepository.getPendingDriverOrders())
            .thenAnswer((_) async => errorResult);

        // act
        final result = await getPendingOrdersUseCase.call();

        // assert
        expect(result, isA<ApiErrorResult<PendingDriverOrdersEntity>>());
        final error = result as ApiErrorResult<PendingDriverOrdersEntity>;
        expect(error.errorMessage, errorMessage);
        verify(mockRepository.getPendingDriverOrders()).called(1);
      },
    );

    test('should throw Exception when repository throws', () async {
      // arrange
      when(mockRepository.getPendingDriverOrders())
          .thenThrow(Exception('Unexpected error'));

      // act & assert
      expect(
        () async => await getPendingOrdersUseCase.call(),
        throwsA(isA<Exception>()),
      );
      verify(mockRepository.getPendingDriverOrders()).called(1);
    });
  });
}