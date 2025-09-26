import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/auth/forget_password/data/datasources/contracts/forget_password_remote_data_source.dart';
import 'package:tracking_app/features/auth/forget_password/domain/entities/reset_password_response_entity.dart';
import 'package:tracking_app/features/auth/forget_password/domain/entities/verify_reset_code_entity.dart';
import 'package:tracking_app/features/auth/forget_password/domain/repositories/forget_password_repo.dart';

import '../../domain/entities/forget_password_response_entity.dart';

@Injectable(as: ForgetPasswordRepo)
class ForgetPasswordRepoImpl implements ForgetPasswordRepo {
  final ForgetPasswordRemoteDataSource forgetPasswordRemoteDataSource;

  ForgetPasswordRepoImpl(this.forgetPasswordRemoteDataSource);

  @override
  Future<ApiResult<VerifyResetCodeResponseEntity>> verifyResetCode({
    required String resetCode,
  }) async {
    return await forgetPasswordRemoteDataSource.verifyResetCode(
      resetCode: resetCode,
    );
  }

  @override
  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    final result = await forgetPasswordRemoteDataSource.resetPassword(
      email: email,
      newPassword: newPassword,
    );
    return result;
  }

  @override
  Future<ApiResult<ForgetPasswordResponseEntity>> forgetPassword({
    required String email,
  }) async {
    return await forgetPasswordRemoteDataSource.forgetPassword(email: email);
  }
}
