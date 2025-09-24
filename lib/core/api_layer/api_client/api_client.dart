import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tracking_app/core/api_layer/models/request/auth/apply_request.dart';
import 'package:tracking_app/core/api_layer/models/response/auth/apply_response.dart';

import 'endpoints.dart';

part 'api_client.g.dart';

@singleton
@RestApi(baseUrl: Endpoints.baseUrl)
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(Endpoints.apply)
  Future<ApplyResponse> apply(@Body() ApplyRequest applyRequest);
}
