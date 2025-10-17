part of 'cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetLoggedDriverDataLoading
    extends ProfileState {}

final class GetLoggedDriverDataError
    extends ProfileState {
  final String message;

  GetLoggedDriverDataError({required this.message});
}

final class GetLoggedDriverDataSuccess
    extends ProfileState {
  final ProfileDriverEntity driver;

  GetLoggedDriverDataSuccess({required this.driver});
}

// Photo change states
class PhotoChangedLoadingState extends ProfileState {
  PhotoChangedLoadingState();
}

final class PhotoChangedSuccess extends ProfileState {
  PhotoChangedSuccess();
}

final class PhotoChangedError extends ProfileState {
  final String message;

  PhotoChangedError({required this.message});
}

// Profile update states
final class UpdateUserProfileLoading
    extends ProfileState {}

final class UpdateUserProfileSuccess
    extends ProfileState {
  final UpdateProfileResponseEntity
  updateProfileResponseEntity;

  UpdateUserProfileSuccess({
    required this.updateProfileResponseEntity,
  });
}

final class UpdateUserProfileError extends ProfileState {
  final String message;

  UpdateUserProfileError({required this.message});
}

// Vehicles states
final class GetVehiclesLoading extends ProfileState {}

final class GetVehiclesSuccess extends ProfileState {
  final List<String> vehicles;

  GetVehiclesSuccess({required this.vehicles});
}

final class GetVehiclesError extends ProfileState {
  final String message;

  GetVehiclesError({required this.message});
}

class DriverApplyLicenseImagePicked extends ProfileState {
  final String imagePath;

  DriverApplyLicenseImagePicked(this.imagePath);
}

class DriverApplyImageError extends ProfileState {
  final String message;

  DriverApplyImageError(this.message);
}

class DriverApplyLicenseImageCleared
    extends ProfileState {}
