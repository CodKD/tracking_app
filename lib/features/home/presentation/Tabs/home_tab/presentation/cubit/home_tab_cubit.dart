
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/entities/pending_orders_entity.dart';
import 'package:tracking_app/features/home/presentation/Tabs/home_tab/domain/usecases/get_pending_use_case.dart';

import '../../data/models/pending_orders_response.dart';

part 'home_tab_state.dart';

@injectable
class HomeTabCubit extends Cubit<HomeTabState> {
  List<Orders>? displayedOrders =[];
  final GetPendingOrdersUseCase _homeUseCase;
  HomeTabCubit(this._homeUseCase) : super(HomeTabInitial());

  Future<void> getHomeData() async {
    emit(HomeTabLoading());
    final result = await _homeUseCase.call();

 
    switch (result) {
      case ApiSuccessResult<PendingDriverOrdersEntity>():
        {displayedOrders = result.data.orders ;
          if (!isClosed) {
            emit(HomeTabSuccess(result.data));
          }
          log('HomeTabCubit: getpendingorders: ${result.data}');
        }

      case ApiErrorResult<PendingDriverOrdersEntity>():
        {
          emit(HomeTabFail(result.errorMessage));
          log('HomeTabCubit: getHomeData: ${result.errorMessage}');
        }
    }
  }
  void rejectOrderFromScreen(Orders order) {
    displayedOrders!.remove(order);
    emit(HomeTabSuccess(PendingDriverOrdersEntity(orders: displayedOrders)));
  }




}