import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/forget_password/domain/repositories/forget_password_repo.dart';

import '../entities/verify_reset_code_entity.dart';

@injectable
class VerifyResetCodeUseCase {
  final ForgetPasswordRepo forgetPasswordRepo;

  VerifyResetCodeUseCase(this.forgetPasswordRepo);
  Future<ApiResult<VerifyResetCodeResponseEntity>> call({
    required String resetCode,
  }) async {
    final result = await forgetPasswordRepo.verifyResetCode(
      resetCode: resetCode,
    );
    return result;
  }
}
