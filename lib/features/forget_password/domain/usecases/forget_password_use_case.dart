import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/forget_password/domain/repositories/forget_password_repo.dart';

import '../entities/forget_password_response_entity.dart';

@injectable
class ForgetPasswordUseCase {
  final ForgetPasswordRepo forgetPasswordRepo;

  ForgetPasswordUseCase(this.forgetPasswordRepo);

  Future<ApiResult<ForgetPasswordResponseEntity>> call({
    required String email,
  }) async {
    final result = await forgetPasswordRepo.forgetPassword(email: email);
    return result;
  }
}
