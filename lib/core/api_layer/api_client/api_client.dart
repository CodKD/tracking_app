import 'package:tracking_app/core/api_layer/models/response/auth/apply_response.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/request/forget_password_request_dto.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/request/reset_password_request_dto.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/request/verify_reset_code_request_dto.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/response/forget_password_response_dto.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/response/reset_password_response_dto.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/response/verify_reset_code_response_dto.dart';
import 'package:tracking_app/features/auth/login/data/model/login_request_dto.dart';
import 'package:tracking_app/features/auth/login/data/model/login_response_dto.dart';

import 'endpoints.dart';

part 'api_client.g.dart';

@singleton
@RestApi(baseUrl: Endpoints.baseUrl)
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;
  @POST(Endpoints.forgetPassword)
  Future<ForgetPasswordResponseDto> forgetPassword({
    @Body() required ForgetPasswordRequestDto forgetPasswordRequestDto,
  });
  @POST(Endpoints.verifyResetCode)
  Future<VerifyResetCodeResponseDto> verifyResetCode({
    @Body() required VerifyResetCodeRequestDto verifyResetCodeRequestDto,
  });
  @PUT(Endpoints.resetPassword)
  Future<ResetPasswordResponseDto> resetPassword({
    @Body() required ResetPasswordRequestDto resetPasswordRequestDto,
  });

  @POST(Endpoints.login)
  Future<HttpResponse<LoginResponseDto>> login({
    @Body() required LoginRequestDto loginRequestDto,
  });

  @POST(Endpoints.apply)
  @MultiPart()
  Future<ApplyResponse> apply(
    @Part() String email,
    @Part() String password,
    @Part() String rePassword,
    @Part() String firstName,
    @Part() String lastName,
    @Part() String phone,
    @Part() String gender,
    // ignore: non_constant_identifier_names
    @Part() String NID,
    @Part() String vehicleType,
    @Part() String vehicleNumber,
    @Part() String country,
    @Part(name: "vehicleLicense") File? vehicleLicense,
    // ignore: non_constant_identifier_names
    @Part(name: "NIDImg") File? NIDImg,
  );
}
