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
  final String? gender;

  DriverApplyGenderSelected(this.gender);
}

class DriverApplyCountryList extends DriverApplyState {
  final List<Country> countries;

  DriverApplyCountryList(this.countries);
}

class DriverApplyCountryListLoading extends DriverApplyState {}

class DriverApplyCountrySelected extends DriverApplyState {
  final String selectedCountry;

  DriverApplyCountrySelected(this.selectedCountry);
}

class DriverApplyVehicleType extends DriverApplyState {
  final String vehicleType;

  DriverApplyVehicleType(this.vehicleType);
}

class DriverApplyLicenseImagePicked extends DriverApplyState {
  final String imagePath;

  DriverApplyLicenseImagePicked(this.imagePath);
}

class DriverApplyLicenseImageCleared extends DriverApplyState {}

class DriverApplyNIDImagePicked extends DriverApplyState {
  final String imagePath;

  DriverApplyNIDImagePicked(this.imagePath);
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

class DriverApplyNIDImageCleared extends DriverApplyState {}

class DriverApplyChangePasswordVisibility extends DriverApplyState {
  final bool isPasswordObscureText;
  DriverApplyChangePasswordVisibility(this.isPasswordObscureText);
}

class DriverApplyChangeConfirmPasswordVisibility extends DriverApplyState {
  final bool isConfirmPasswordObscureText;
  DriverApplyChangeConfirmPasswordVisibility(this.isConfirmPasswordObscureText);
}
