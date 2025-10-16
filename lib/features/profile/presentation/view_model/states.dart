part of 'cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetLoggedDriverDataLoading extends ProfileState {}

final class GetLoggedDriverDataError extends ProfileState {
  final String message;

  GetLoggedDriverDataError({required this.message});
}

final class GetLoggedDriverDataSuccess extends ProfileState {
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
final class UpdateUserProfileLoading extends ProfileState {}

final class UpdateUserProfileSuccess extends ProfileState {
  final UpdateProfileResponseEntity updateProfileResponseEntity;

  UpdateUserProfileSuccess({required this.updateProfileResponseEntity});
}

final class UpdateUserProfileError extends ProfileState {
  final String message;

  UpdateUserProfileError({required this.message});
}
