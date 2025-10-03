import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/data/models/pending_orders_response.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/entities/pending_orders_entity.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/usecases/get_pending_use_case.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/presentation/cubit/home_tab_cubit.dart';

import 'home_tab_cubit_test.mocks.dart';

@GenerateMocks([GetPendingOrdersUseCase])
void main() {
  late MockGetPendingOrdersUseCase mockUseCase;

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
    mockUseCase = MockGetPendingOrdersUseCase();
  });

  group('HomeTabCubit', () {
    final testOrders = [
      Orders(
        id: '1',
        state: 'pending',
      ),
      Orders(
        id: '2',
        state: 'pending',
      ),
    ];

    final testEntity = PendingDriverOrdersEntity(
      message: 'success',
      orders: testOrders,
    );

    test('initial state should be HomeTabInitial', () {
      // arrange
      final cubit = HomeTabCubit(mockUseCase);

      // assert
      expect(cubit.state, isA<HomeTabInitial>());

      // cleanup
      cubit.close();
    });

    blocTest<HomeTabCubit, HomeTabState>(
      'emits [HomeTabLoading, HomeTabSuccess] when getHomeData succeeds',
      build: () {
        when(mockUseCase.call()).thenAnswer(
          (_) async => ApiSuccessResult<PendingDriverOrdersEntity>(testEntity),
        );
        return HomeTabCubit(mockUseCase);
      },
      act: (cubit) => cubit.getHomeData(),
      expect: () => [
        isA<HomeTabLoading>(),
        isA<HomeTabSuccess>()
            .having((s) => s.pendingDriverOrdersEntity.orders?.length, 'orders length', 2)
            .having((s) => s.pendingDriverOrdersEntity.message, 'message', 'success'),
      ],
      verify: (_) {
        verify(mockUseCase.call()).called(1);
      },
    );

    blocTest<HomeTabCubit, HomeTabState>(
      'emits [HomeTabLoading, HomeTabFail] when getHomeData fails',
      build: () {
        when(mockUseCase.call()).thenAnswer(
          (_) async => ApiErrorResult<PendingDriverOrdersEntity>(
            'Network error',
          ),
        );
        return HomeTabCubit(mockUseCase);
      },
      act: (cubit) => cubit.getHomeData(),
      expect: () => [
        isA<HomeTabLoading>(),
        isA<HomeTabFail>().having(
          (s) => s.errorMessage,
          'errorMessage',
          'Network error',
        ),
      ],
      verify: (_) {
        verify(mockUseCase.call()).called(1);
      },
    );

    blocTest<HomeTabCubit, HomeTabState>(
      'should update displayedOrders when getHomeData succeeds',
      build: () {
        when(mockUseCase.call()).thenAnswer(
          (_) async => ApiSuccessResult<PendingDriverOrdersEntity>(testEntity),
        );
        return HomeTabCubit(mockUseCase);
      },
      act: (cubit) => cubit.getHomeData(),
      verify: (cubit) {
        expect(cubit.displayedOrders, equals(testOrders));
        expect(cubit.displayedOrders?.length, 2);
      },
    );

    blocTest<HomeTabCubit, HomeTabState>(
      'should remove order from displayedOrders when rejectOrderFromScreen is called',
      build: () {
        final cubit = HomeTabCubit(mockUseCase);
        cubit.displayedOrders = List.from(testOrders);
        return cubit;
      },
      act: (cubit) => cubit.rejectOrderFromScreen(testOrders[0]),
      expect: () => [
        isA<HomeTabSuccess>().having(
          (s) => s.pendingDriverOrdersEntity.orders?.length,
          'orders length',
          1,
        ),
      ],
      verify: (cubit) {
        expect(cubit.displayedOrders?.length, 1);
        expect(cubit.displayedOrders?.contains(testOrders[0]), false);
        expect(cubit.displayedOrders?.contains(testOrders[1]), true);
      },
    );

    blocTest<HomeTabCubit, HomeTabState>(
      'should emit success state with updated orders after rejecting order',
      build: () {
        final cubit = HomeTabCubit(mockUseCase);
        cubit.displayedOrders = List.from(testOrders);
        return cubit;
      },
      act: (cubit) => cubit.rejectOrderFromScreen(testOrders[1]),
      expect: () => [
        isA<HomeTabSuccess>()
            .having((s) => s.pendingDriverOrdersEntity.orders?.length, 'remaining orders', 1)
            .having(
              (s) => s.pendingDriverOrdersEntity.orders?.first.id,
              'remaining order id',
              '1',
            ),
      ],
    );

  


  });
}