import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/forget_password/domain/repositories/forget_password_repo.dart';

import '../entities/reset_password_response_entity.dart';

@injectable
class ResetPasswordUseCase {
  final ForgetPasswordRepo forgetPasswordRepo;

  ResetPasswordUseCase(this.forgetPasswordRepo);

  Future<ApiResult<ResetPasswordResponseEntity>> call({
    required String email,
    required String newPassword,
  }) async {
    final result = await forgetPasswordRepo.resetPassword(
      email: email,
      newPassword: newPassword,
    );
    return result;
  }
}
