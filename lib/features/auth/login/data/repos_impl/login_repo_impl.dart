import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/features/auth/login/data/data_source/contract/login_remote_data_scource.dart';
import 'package:tracking_app/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:tracking_app/features/auth/login/domain/entities/login_response_entity.dart';
import 'package:tracking_app/features/auth/login/domain/repos/login_repo.dart';

@Injectable(as: LoginRepo)
class LoginRepoImpl extends LoginRepo{
  final LoginRemoteDataSource _loginRemoteDataSource;
  LoginRepoImpl(this._loginRemoteDataSource);

  @override
  Future<ApiResult<LoginResponseEntity>> login({required LoginRequestEntity loginRequestEntity}) async{
    try{
      var response = await _loginRemoteDataSource.login(loginRequestEntity: loginRequestEntity);
      return response;
    }catch(e){
      return ApiErrorResult<LoginResponseEntity>( e.toString());
    }
  }
}