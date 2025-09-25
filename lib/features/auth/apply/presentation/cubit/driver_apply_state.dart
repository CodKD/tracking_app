part of 'driver_apply_cubit.dart';

sealed class DriverApplyState {}

final class DriverApplyInitial extends DriverApplyState {}

final class DriverApplyLoading extends DriverApplyState {}

final class DriverApplySuccess extends DriverApplyState {
  final DriverEntity response;

  DriverApplySuccess(this.response);
}

class DriverApplyError extends DriverApplyState {
  final String message;

  DriverApplyError(this.message);
}

class DriverApplyGenderSelected extends DriverApplyState {
  final String gender;

  DriverApplyGenderSelected(this.gender);
}

class DriverApplyCountrySelected extends DriverApplyState {
  final String selectedCountry;

  DriverApplyCountrySelected(this.selectedCountry);
}

class DriverApplyVehicleType extends DriverApplyState {
  final String vehicleType;

  DriverApplyVehicleType(this.vehicleType);
}

class DriverApplyImagePicked extends DriverApplyState {
  final String imagePath;

  DriverApplyImagePicked(this.imagePath);
}

class DriverApplyImageError extends DriverApplyState {
  final String message;

  DriverApplyImageError(this.message);
}
class DriverImageUploadLoading extends DriverApplyState {}
class DriverImageUploadSuccess extends DriverApplyState {
  final String imageUrl;
  DriverImageUploadSuccess(this.imageUrl);
}

class DriverImageUploadError extends DriverApplyState {
  final String message;
  DriverImageUploadError(this.message);
}