part of 'reset_cubit.dart';

import '../../../domain/entities/change_password_entity.dart';

sealed class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}

class ChangePasswordLoading extends ResetPasswordState {}

class ChangePasswordError extends ResetPasswordState {
  final String message;

  ChangePasswordError({required this.message});
}

class ChangePasswordSuccess extends ResetPasswordState {
  ChangePasswordEntity changePasswordEntity;

  ChangePasswordSuccess({required this.changePasswordEntity});
}
