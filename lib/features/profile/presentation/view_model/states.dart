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
