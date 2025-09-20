import 'package:injectable/injectable.dart';
import 'package:tracking_app/features/login/domain/entities/login_request_entity.dart';
import 'package:tracking_app/features/login/domain/entities/login_response_entity.dart';
import 'package:tracking_app/features/login/domain/repos/login_repo.dart';

@injectable
class LoginUseCase{
  final LoginRepo _loginRepo;
  LoginUseCase(this._loginRepo);

  Future<LoginResponseEntity> call ({required LoginRequestEntity loginRequestEntity})async{
    return await _loginRepo.login(loginRequestEntity: loginRequestEntity);
  }
}