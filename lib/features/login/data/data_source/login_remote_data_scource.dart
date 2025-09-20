import 'package:tracking_app/features/login/domain/entities/login_request_entity.dart';
import 'package:tracking_app/features/login/domain/entities/login_response_entity.dart';

abstract class LoginRemoteDataSource{
  Future<LoginResponseEntity> login ({required LoginRequestEntity loginRequestEntity});
}