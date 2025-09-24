import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tracking_app/features/forget_password/data/models/request/forget_password_request_dto.dart';
import 'package:tracking_app/features/forget_password/data/models/request/reset_password_request_dto.dart';
import 'package:tracking_app/features/forget_password/data/models/request/verify_reset_code_request_dto.dart';
import 'package:tracking_app/features/forget_password/data/models/response/forget_password_response_dto.dart';
import 'package:tracking_app/features/forget_password/data/models/response/reset_password_response_dto.dart';
import 'package:tracking_app/features/forget_password/data/models/response/verify_reset_code_response_dto.dart';
import 'package:tracking_app/core/resources/app_constants.dart';
import 'package:tracking_app/features/login/data/model/login_request_dto.dart';
import 'package:tracking_app/features/login/data/model/login_response_dto.dart';
part 'api_client.g.dart';

@singleton
@RestApi(baseUrl: AppConstants.baseUrl)
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;
  @POST('v1/drivers/forgotPassword')
  Future<ForgetPasswordResponseDto> forgetPassword({
    @Body() required ForgetPasswordRequestDto forgetPasswordRequestDto,
  });
  @POST('/v1/drivers/verifyResetCode')
  Future<VerifyResetCodeResponseDto> verifyResetCode({
    @Body() required VerifyResetCodeRequestDto verifyResetCodeRequestDto,
  });
  @PUT('/v1/drivers/resetPassword')
  Future<ResetPasswordResponseDto> resetPassword({
    @Body() required ResetPasswordRequestDto resetPasswordRequestDto,
  });

  @POST('/v1/drivers/signin')
  Future<HttpResponse<LoginResponseDto>> login({
    @Body() required LoginRequestDto loginRequestDto,
  });
}
