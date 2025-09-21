import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/dialog/dialog.dart';
import 'package:tracking_app/core/extensions/navigator_extensions.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/input_formatter/app_regex.dart';
import 'package:tracking_app/core/route/app_routes.dart';
import 'package:tracking_app/core/theme/app_styles.dart';
import 'package:tracking_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';

class ResetPasswordComponent extends StatefulWidget {
  final ForgetPasswordViewModel viewModel;

  const ResetPasswordComponent({super.key, required this.viewModel});

  @override
  State<ResetPasswordComponent> createState() => _ResetPasswordComponentState();
}

class _ResetPasswordComponentState extends State<ResetPasswordComponent> {
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordViewModel, ForgetPassStates>(
      bloc: widget.viewModel,
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.05,
            ).copyWith(top: context.height * 0.05),
            child: SingleChildScrollView(
              child: Form(
                key: widget.viewModel.resetPassFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Reset Password",
                      style: AppStyles.medium18black,
                      textAlign: TextAlign.center,
                    ),
                    16.heightBox,
                    Text(
                      "Please enter your new password",
                      style: AppStyles.regular14grey,
                      textAlign: TextAlign.center,
                    ),
                    32.heightBox,
                    // New Password Field
                    TextFormField(
                      controller: widget.viewModel.newPasswordController,
                      validator: (value) =>
                          AppRegex.isPasswordValid(value?.trim() ?? '')
                          ? null
                          : context
                                .l10n
                                .passwordMustContainUpperLowerAndSpecialCharacter,
                      onChanged: (_) => widget.viewModel.validateResetPassBtn(),
                      style: AppStyles.regular16black,
                      obscureText: !_isNewPasswordVisible,
                      decoration: InputDecoration(
                        hintText: "Enter your new password",
                        hintStyle: AppStyles.regular14grey,
                        labelText: "New Password",
                        labelStyle: AppStyles.regular14black,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isNewPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isNewPasswordVisible = !_isNewPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    24.heightBox,
                    // Confirm Password Field
                    TextFormField(
                      controller: widget.viewModel.confirmPasswordController,
                      validator: (value) =>
                          AppRegex.isConfirmPasswordValid(
                            value?.trim() ?? '',
                            widget.viewModel.newPasswordController.text.trim(),
                          )
                          ? null
                          : context.l10n.passwordsDoNotMatch,
                      onChanged: (_) => widget.viewModel.validateResetPassBtn(),
                      style: AppStyles.regular16black,
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        hintText: "Confirm your password",
                        hintStyle: AppStyles.regular14grey,
                        labelText: "Confirm Password",
                        labelStyle: AppStyles.regular14black,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    48.heightBox,
                    // Reset Button
                    FilledButton(
                      onPressed: widget.viewModel.resetPassBtnEnabled
                          ? () => widget.viewModel.resetPasswordRequest()
                          : null,
                      child: Text("Reset Password"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is ResetPassLoadingState) {
          DialogUtils.showLoading(
            context: context,
            loadingMessage: "Resetting password...",
          );
        } else if (state is ResetPassSuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            content:
                "Password reset successfully! Please login with your new password.",
            posActions: "OK",
          );
          Future.delayed(const Duration(seconds: 1), () {
            // ignore: use_build_context_synchronously
            context.pushReplacementNamed(AppRoutes.homeScreen);
          });
        } else if (state is ResetPassFailureState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            title: "Error",
            content: state.error,
            negActions: "OK",
          );
        }
      },
    );
  }
}
