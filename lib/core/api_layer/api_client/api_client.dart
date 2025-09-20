import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tracking_app/core/resources/app_constants.dart';
import 'package:tracking_app/features/login/data/model/login_request_dto.dart';
import 'package:tracking_app/features/login/data/model/login_response_dto.dart';
part 'api_client.g.dart';

@singleton
@RestApi(baseUrl: AppConstants.baseUrl)
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(AppConstants.login)
  Future<HttpResponse<LoginResponseDto>> login({required LoginRequestDto loginRequestDto});
}