abstract class DriverApplyState {}

class DriverApplyInitial extends DriverApplyState {}

class DriverApplyLoading extends DriverApplyState {}

class DriverApplySuccess extends DriverApplyState {}

class DriverApplyError extends DriverApplyState {
  final String message;
  DriverApplyError(this.message);
}
