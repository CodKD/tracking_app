import 'package:tracking_app/features/login/domain/entities/login_response_entity.dart';

sealed class LoginStates{}

class LoginInitState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  LoginResponseEntity loginResponseEntity;
  LoginSuccessState(this.loginResponseEntity);
}

class LoginErrorState extends LoginStates{
  final String message;
  LoginErrorState(this.message);
}

class LoginRememberMeState extends LoginStates {
  final bool rememberMe;
  LoginRememberMeState(this.rememberMe);
}
