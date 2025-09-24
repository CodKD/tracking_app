import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/dialog/dialog.dart';
import 'package:tracking_app/core/extensions/navigator_extensions.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/extensions/validation_ext.dart';
import 'package:tracking_app/core/route/app_routes.dart';
import 'package:tracking_app/core/theme/app_colors.dart';
import 'package:tracking_app/core/theme/app_styles.dart';
import 'package:tracking_app/core/utils/components/app_text_form_feild.dart';
import 'package:tracking_app/core/utils/components/custom_button.dart';
import 'package:tracking_app/features/login/presentation/cubit/login_states.dart';

import 'cubit/login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginViewModel>()..loadSavedEmail(),
      child: BlocConsumer<LoginViewModel, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            DialogUtils.hideLoading(context);
            DialogUtils.showMessage(
              context: context,
              content: state.message,
              posActions: context.l10n.ok,
            );
          } else if (state is LoginLoadingState) {
            DialogUtils.showLoading(
              context: context,
              loadingMessage: context.l10n.loading,
            );
          } else if (state is LoginSuccessState) {
            DialogUtils.hideLoading(context);
            DialogUtils.showMessage(
              context: context,
              content: context.l10n.success,
              posActions: context.l10n.ok,
              posFunction: (p0) {
                context.pushReplacementNamed(AppRoutes.homeScreen);
              },
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: IconButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      context.pop();
                      context.read<LoginViewModel>().close();
                    }
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ),
              title: Text(context.l10n.login, style: AppStyles.font20BlackW500),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: context.read<LoginViewModel>().formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        24.heightBox,
                        AppTextFormField(
                          hintText: context.l10n.enter_your_email,
                          labelText: context.l10n.email,
                          isPassword: false,
                          validator: (value) => value.validateEmail(context),
                          controller: context
                              .read<LoginViewModel>()
                              .emailController,
                        ),
                        24.heightBox,
                        AppTextFormField(
                          isPassword: true,
                          hintText: context.l10n.enter_your_password,
                          labelText: context.l10n.password,
                          validator: (value) => value.validatePassword(context),
                          suffixIcon: const Icon(Icons.visibility_off),
                          controller: context
                              .read<LoginViewModel>()
                              .passwordController,
                        ),
                        11.heightBox,
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                value: context
                                    .read<LoginViewModel>()
                                    .rememberMe,
                                onChanged: context
                                    .read<LoginViewModel>()
                                    .setRememberMe,
                                title: Text(
                                  context.l10n.remember_me,
                                  style: AppStyles.regular13grey.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pushNamed(
                                  AppRoutes.forgetPasswordScreen,
                                );
                              },
                              child: Text(
                                context.l10n.forgot_password,
                                style: AppStyles.font12blackW400.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        32.heightBox,
                        CustomButton(
                          onPressed: () {
                            if (context
                                .read<LoginViewModel>()
                                .formKey
                                .currentState!
                                .validate()) {
                              context.read<LoginViewModel>().login();
                            }
                          },
                          borderRadius: 100,
                          child: Text(
                            context.l10n.continue_btn,
                            style: AppStyles.medium16white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
