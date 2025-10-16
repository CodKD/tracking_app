import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/orders/domain/entities/my_orders_entity.dart';
import 'package:tracking_app/features/orders/domain/use_cases/my_orders_use_case.dart';


import 'dart:developer';

import 'package:tracking_app/features/orders/presentation/manager/my_orders_state.dart';

@injectable
class MyOrdersViewModel extends Cubit<MyOrdersState> {
  final MyOrdersUseCase myOrdersUseCase;

  MyOrdersViewModel(this.myOrdersUseCase) : super(MyOrdersInitial());

  Future<void> getMyOrders() async {
    emit(MyOrdersLoading());
    final result = await myOrdersUseCase.getMyOrders();
    log('HomeCubit: getHomeData: $result');

    log('MyOrders================================ $result');
    switch (result) {
      case ApiSuccessResult<MyOrdersEntity>():
        emit(MyOrdersSuccess(result.data));
        log('HomeCubit: getHomeData: $result');

        log('MyOrders================================  ${result.data}');

      case ApiErrorResult<MyOrdersEntity>():
        emit(MyOrdersError(result.errorMessage));
        ('MyOrders================================  ${result.errorMessage}');
        log('HomeCubit: getHomeData: $result');
    }
  }
}
