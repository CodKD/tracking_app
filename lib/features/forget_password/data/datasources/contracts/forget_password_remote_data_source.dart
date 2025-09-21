import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/forget_password/domain/entities/forget_password_response_entity.dart';
import 'package:tracking_app/features/forget_password/domain/entities/verify_reset_code_entity.dart';

abstract class ForgetPasswordRemoteDataSource {
  Future<ApiResult<ForgetPasswordResponseEntity>> forgetPassword({
    required String email,
  });

  Future<ApiResult<VerifyResetCodeResponseEntity>> verifyResetCode({
    required String resetCode,
  });
}
