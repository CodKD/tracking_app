part of 'home_tab_cubit.dart';

sealed class HomeTabState  {
}


final class HomeTabInitial extends HomeTabState {}

final class HomeTabLoading extends HomeTabState {}

final class HomeTabSuccess extends HomeTabState {
  final PendingDriverOrdersEntity pendingDriverOrdersEntity;
  HomeTabSuccess(this.pendingDriverOrdersEntity);
}

final class HomeTabFail extends HomeTabState {
  final String errorMessage;
  HomeTabFail(this.errorMessage);
}
final class OrderRejected extends HomeTabState {}