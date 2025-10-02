part of 'start_order_cubit.dart';


sealed class StartOrderState {}

final class StartOrderInitial extends StartOrderState {}

class SuccessStartOrderState extends StartOrderState {
  final StartOrderEntity? startOrderEntity;

  SuccessStartOrderState(this.startOrderEntity);
}

class LoadingStartOrderState extends StartOrderState {}

class ErrorStartOrderState extends StartOrderState {
  final String? errorMessage;

  ErrorStartOrderState(this.errorMessage);
}


class SuccessUpdateOrderState extends StartOrderState {
  final UpdateOrderStateEntity? updateOrderStateEntity;

  SuccessUpdateOrderState(this.updateOrderStateEntity);
}

class LoadingUpdateOrderState extends StartOrderState {}

class ErrorUpdateOrderState extends StartOrderState {
  final String? errorMessage;

  ErrorUpdateOrderState(this.errorMessage);
}