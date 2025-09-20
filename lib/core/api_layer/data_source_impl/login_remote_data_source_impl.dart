import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_client/api_client.dart';
import 'package:tracking_app/features/login/data/data_source/login_remote_data_scource.dart';
import 'package:tracking_app/features/login/data/model/login_request_dto.dart';
import 'package:tracking_app/features/login/domain/entities/login_request_entity.dart';
import 'package:tracking_app/features/login/domain/entities/login_response_entity.dart';

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl extends LoginRemoteDataSource{
  final ApiClient _apiClient;
  LoginRemoteDataSourceImpl(this._apiClient);

  @override
  Future<LoginResponseEntity> login({required LoginRequestEntity loginRequestEntity}) async{
    try{
      var response = await _apiClient.login(loginRequestDto: LoginRequestDto(email: loginRequestEntity.email,password:loginRequestEntity.password ));
      var statusCode = response.response.statusCode ?? 500;
      var responseBody = response.data;
      if(statusCode >= 200 && statusCode < 300){
        return responseBody.toEntity();
      }else{
        throw Exception("Something went wrong");
      }
    }catch (e){
      throw Exception("Something went wrong");
    }
  }
}