part of 'edit_vehical_cubit.dart';

sealed class VehicalState {}

final class ProfileInitial extends VehicalState {}

final class GetLoggedDriverDataLoading extends VehicalState {}

final class GetLoggedDriverDataError extends VehicalState {
  final String message;

  GetLoggedDriverDataError({required this.message});
}

final class GetLoggedDriverDataSuccess extends VehicalState {
  final VehicleEntity driver;

  GetLoggedDriverDataSuccess({required this.driver});
}

// Photo change states
class PhotoChangedLoadingState extends VehicalState {
  PhotoChangedLoadingState();
}

final class PhotoChangedSuccess extends VehicalState {
  PhotoChangedSuccess();
}

final class PhotoChangedError extends VehicalState {
  final String message;

  PhotoChangedError({required this.message});
}

// Profile update states
final class UpdateUserProfileLoading extends VehicalState {}

// final class UpdateUserProfileSuccess extends ProfileState {
//   final UpdateProfileResponseEntity updateProfileResponseEntity;
//
//   UpdateUserProfileSuccess({required this.updateProfileResponseEntity});
// }

final class UpdateUserProfileError extends VehicalState {
  final String message;

  UpdateUserProfileError({required this.message});
}
