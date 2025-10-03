// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:injectable/injectable.dart';
// import 'package:tracking_app/features/profile/domain/entities/change_password_entity.dart';
//
// import '../../../../../core/api_layer/api_result/api_result.dart';
// import '../../../../../core/api_layer/models/request/change_password_request_body.dart';
// import '../../../domain/usecases/change_password_use_case.dart';
//
// part 'reset_state.dart';
//
// @injectable
// class ResetPasswordCubit extends Cubit<ResetPasswordState> {
//   ChangePasswordUseCase changePasswordUseCase;
//
//   ResetPasswordCubit(this.changePasswordUseCase)
//     : super(ResetPasswordInitial());
//
//   Future<void> changePassword(ChangePasswordRequestBody body) async {
//     emit(ChangePasswordLoading());
//     final result = await changePasswordUseCase.call(body);
//     switch (result) {
//       case ApiSuccessResult<ChangePasswordEntity>():
//         emit(ChangePasswordSuccess(changePasswordEntity: result.data));
//       case ApiErrorResult<ChangePasswordEntity>():
//         emit(ChangePasswordError(message: result.errorMessage));
//     }
//   }
// }
