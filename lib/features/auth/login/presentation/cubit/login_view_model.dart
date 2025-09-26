import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';
import 'package:tracking_app/core/modules/shared_preferences_module.dart';
import 'package:tracking_app/core/resources/app_constants.dart';
import 'package:tracking_app/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:tracking_app/features/auth/login/domain/entities/login_response_entity.dart';
import 'package:tracking_app/features/auth/login/domain/use_cases/login_use_case.dart';
import 'package:tracking_app/features/auth/login/presentation/cubit/login_states.dart';

@injectable
class LoginViewModel extends Cubit<LoginStates> {
  final LoginUseCase loginUseCase;
  final SharedPrefHelper sharedPrefHelper;
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool? rememberMe = false;

  LoginViewModel({required this.loginUseCase, required this.sharedPrefHelper})
    : super(LoginInitState());

  void login() async {
    if (formKey.currentState!.validate()) {
      // Check if the cubit is closed before emitting
      if (isClosed) return;

      emit(LoginLoadingState());

      try {
        var response = await loginUseCase.call(
          loginRequestEntity: LoginRequestEntity(
            email: emailController.text,
            password: passwordController.text,
          ),
        );

        // Check if the cubit is closed before emitting
        if (isClosed) return;

        switch (response) {
          case ApiSuccessResult<LoginResponseEntity>():

            // remember me
            saveEmail(emailController.text);
            // Save token to SharedPreferences
            await sharedPrefHelper.setValue(
              AppConstants.tokenKey,
              response.data.token,
            );
            emit(LoginSuccessState(response.data));
            break;
          case ApiErrorResult<LoginResponseEntity>():
            emit(LoginErrorState(response.errorMessage));
            break;
        }
      } catch (e) {
        // Check if the cubit is closed before emitting
        if (isClosed) return;
        emit(LoginErrorState(e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    // Dispose controllers to prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  void setRememberMe(bool? value) {
    rememberMe = value;
    emit(LoginRememberMeState(rememberMe ?? false));
  }

  void saveEmail(String email) async {
    if (rememberMe == true) {
      await sharedPrefHelper.setValue(AppConstants.savedEmailKey, email);
    }
  }

  void loadSavedEmail() {
    String? savedEmail = sharedPrefHelper.getValue(AppConstants.savedEmailKey);
    if (savedEmail != null) {
      emailController.text = savedEmail;
      rememberMe = true;
      emit(LoginRememberMeState(rememberMe ?? false));
    }
  }

}
