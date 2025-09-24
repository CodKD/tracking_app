import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_client/api_client.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/forget_password/data/datasources/contracts/forget_password_remote_data_source.dart';
import 'package:tracking_app/features/forget_password/data/models/request/forget_password_request_dto.dart';
import 'package:tracking_app/features/forget_password/data/models/request/reset_password_request_dto.dart';
import 'package:tracking_app/features/forget_password/data/models/request/verify_reset_code_request_dto.dart';
import 'package:tracking_app/features/forget_password/data/models/response/forget_password_response_dto.dart';
import 'package:tracking_app/features/forget_password/data/models/response/reset_password_response_dto.dart';
import 'package:tracking_app/features/forget_password/data/models/response/verify_reset_code_response_dto.dart';
import 'package:tracking_app/features/forget_password/domain/entities/reset_password_response_entity.dart';
import 'package:tracking_app/features/forget_password/domain/entities/verify_reset_code_entity.dart';

import '../../../domain/entities/forget_password_response_entity.dart';

@Injectable(as: ForgetPasswordRemoteDataSource)
class ForgetPasswordRemoteDataSourceImpl
    implements ForgetPasswordRemoteDataSource {
  final ApiClient apiClient;
  ForgetPasswordRemoteDataSourceImpl(this.apiClient);
  @override
  Future<ApiResult<ForgetPasswordResponseEntity>> forgetPassword({
    required String email,
  }) async {
    try {
      ForgetPasswordResponseDto forgetPasswordResponseDto = await apiClient
          .forgetPassword(
            forgetPasswordRequestDto: ForgetPasswordRequestDto(email: email),
          );
      if (forgetPasswordResponseDto.message != "success") {
        return ApiErrorResult(
          forgetPasswordResponseDto.message ?? "Unknown error",
        );
      } else {
        return ApiSuccessResult(forgetPasswordResponseDto.toEntity());
      }
    } on DioException catch (e) {
      return ApiErrorResult(e.message ?? "Unknown Dio error");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      ResetPasswordResponseDto resetPasswordResponseDto = await apiClient
          .resetPassword(
            resetPasswordRequestDto: ResetPasswordRequestDto(
              email: email,
              newPassword: newPassword,
            ),
          );
      if (resetPasswordResponseDto.message != "success") {
        return ApiErrorResult(
          resetPasswordResponseDto.message ?? "Unknown error",
        );
      } else {
        return ApiSuccessResult(resetPasswordResponseDto.toEntity());
      }
    } on DioException catch (e) {
      return ApiErrorResult(e.message ?? "Unknown Dio error");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<ApiResult<VerifyResetCodeResponseEntity>> verifyResetCode({
    required String resetCode,
  }) async {
    try {
      VerifyResetCodeResponseDto verifyResetCodeResponseDto = await apiClient
          .verifyResetCode(
            verifyResetCodeRequestDto: VerifyResetCodeRequestDto(
              resetCode: resetCode,
            ),
          );

      return ApiSuccessResult(verifyResetCodeResponseDto.toEntity());
    } on DioException catch (e) {
      return ApiErrorResult(e.message ?? "Unknown Dio error");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
