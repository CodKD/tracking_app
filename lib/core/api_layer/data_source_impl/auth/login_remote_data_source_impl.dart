import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_client/api_client.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/auth/login/data/data_source/contract/login_remote_data_scource.dart';
import 'package:tracking_app/features/auth/login/data/model/login_request_dto.dart';
import 'package:tracking_app/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:tracking_app/features/auth/login/domain/entities/login_response_entity.dart';

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl extends LoginRemoteDataSource{
  final ApiClient _apiClient;
  LoginRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<LoginResponseEntity>> login({required LoginRequestEntity loginRequestEntity}) async{
    try{
      var response = await _apiClient.login(loginRequestDto: LoginRequestDto(email: loginRequestEntity.email,password:loginRequestEntity.password ));
      var statusCode = response.response.statusCode ?? 500;
      var responseBody = response.data;
      if(statusCode >= 200 && statusCode < 300){
        return ApiSuccessResult<LoginResponseEntity>(responseBody.toEntity());
      }else{
        return ApiErrorResult<LoginResponseEntity>(responseBody.error ?? "An error occurred");
      }
    }catch (e){
      return ApiErrorResult<LoginResponseEntity>(e.toString());
    }
  }
}