import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/orders/domain/entities/my_orders_entity.dart';
import 'package:tracking_app/features/orders/domain/use_cases/my_orders_use_case.dart';
import 'package:tracking_app/features/orders/presentation/manager/my_orders_state.dart';
import 'package:tracking_app/features/orders/presentation/manager/my_orders_view_model.dart';

import 'my_orders_view_model_test.mocks.dart';


@GenerateMocks([MyOrdersUseCase])
void main() {
  late MockMyOrdersUseCase mockUseCase;

  setUpAll(() {
    provideDummy<ApiResult<MyOrdersEntity>>(
      ApiSuccessResult<MyOrdersEntity>(
        MyOrdersEntity(orders: []),
      ),
    );
  });

  setUp(() {
    mockUseCase = MockMyOrdersUseCase();
  });

  group('MyOrdersViewModel', () {
    test('initial state should be MyOrdersInitial', () {
      // arrange
      final viewModel = MyOrdersViewModel(mockUseCase);

      // assert
      expect(viewModel.state, isA<MyOrdersInitial>());

      // cleanup
      viewModel.close();
    });

    group('getMyOrders', () {
      blocTest<MyOrdersViewModel, MyOrdersState>(
        'emits [MyOrdersLoading, MyOrdersSuccess] when getMyOrders succeeds',
        build: () {
          final entity = MyOrdersEntity(orders: []);
          when(mockUseCase.getMyOrders()).thenAnswer(
            (_) async => ApiSuccessResult<MyOrdersEntity>(entity),
          );
          return MyOrdersViewModel(mockUseCase);
        },
        act: (viewModel) => viewModel.getMyOrders(),
        expect: () => [
          isA<MyOrdersLoading>(),
          isA<MyOrdersSuccess>(),
        ],
        verify: (viewModel) {
          final state = viewModel.state as MyOrdersSuccess;
          expect(state.myOrdersEntity, isNotNull);
          verify(mockUseCase.getMyOrders()).called(1);
        },
      );

      blocTest<MyOrdersViewModel, MyOrdersState>(
        'emits [MyOrdersLoading, MyOrdersError] when getMyOrders fails',
        build: () {
          const errorMessage = 'Failed to get orders';
          when(mockUseCase.getMyOrders()).thenAnswer(
            (_) async => ApiErrorResult<MyOrdersEntity>(errorMessage),
          );
          return MyOrdersViewModel(mockUseCase);
        },
        act: (viewModel) => viewModel.getMyOrders(),
        expect: () => [
          isA<MyOrdersLoading>(),
          isA<MyOrdersError>(),
        ],
        verify: (viewModel) {
          final state = viewModel.state as MyOrdersError;
          expect(state.errorMessage, 'Failed to get orders');
          verify(mockUseCase.getMyOrders()).called(1);
        },
      );
    });
  });
}