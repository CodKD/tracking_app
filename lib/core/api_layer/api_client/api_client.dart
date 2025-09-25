import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tracking_app/core/api_layer/models/response/auth/apply_response.dart';

import 'endpoints.dart';

part 'api_client.g.dart';

@singleton
@RestApi(baseUrl: Endpoints.baseUrl)
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

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
