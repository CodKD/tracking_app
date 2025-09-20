import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/di/modules/shared_preferences_module.dart';
import 'package:tracking_app/features/login/domain/entities/login_request_entity.dart';
import 'package:tracking_app/features/login/domain/use_cases/login_use_case.dart';
import 'package:tracking_app/features/login/presentation/cubit/login_states.dart';

@injectable
class LoginViewModel extends Cubit<LoginStates>{
  final LoginUseCase loginUseCase;
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: "abdoaswani@gmail.com");
  final TextEditingController passwordController = TextEditingController(text: "Ahmed@123");
  LoginViewModel({required this.loginUseCase}):super(LoginInitState());

  static LoginViewModel get(context) => BlocProvider.of<LoginViewModel>(context);

  void login() async{
    if(formKey.currentState!.validate()){
      emit(LoginLoadingState());
      try{
        var response = await loginUseCase.call(loginRequestEntity: LoginRequestEntity(email: emailController.text, password: passwordController.text));
        await SharedPrefHelper.preferences.setValue("token", response.token);
        emit(LoginSuccessState(response));
      }
      catch(e){
        emit(LoginErrorState("Login failed: ${e.toString()}"));
      }
    }
    else{
      emit(LoginErrorState("Something went wrong"));
    }
  }
}