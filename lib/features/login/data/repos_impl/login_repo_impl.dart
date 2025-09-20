import 'package:injectable/injectable.dart';
import 'package:tracking_app/features/login/data/data_source/login_remote_data_scource.dart';
import 'package:tracking_app/features/login/domain/entities/login_request_entity.dart';
import 'package:tracking_app/features/login/domain/entities/login_response_entity.dart';
import 'package:tracking_app/features/login/domain/repos/login_repo.dart';

@Injectable(as: LoginRepo)
class LoginRepoImpl extends LoginRepo{
  final LoginRemoteDataSource _loginRemoteDataSource;
  LoginRepoImpl(this._loginRemoteDataSource);

  @override
  Future<LoginResponseEntity> login({required LoginRequestEntity loginRequestEntity}) async{
    try{
      var response = await _loginRemoteDataSource.login(loginRequestEntity: loginRequestEntity);
      return response;
    }catch(e){
      throw Exception("Something went wrong");
    }
  }
}