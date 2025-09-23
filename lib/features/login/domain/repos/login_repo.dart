import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/login/domain/entities/login_request_entity.dart';
import 'package:tracking_app/features/login/domain/entities/login_response_entity.dart';

abstract class LoginRepo{
  Future<ApiResult<LoginResponseEntity>> login({required LoginRequestEntity loginRequestEntity});
}