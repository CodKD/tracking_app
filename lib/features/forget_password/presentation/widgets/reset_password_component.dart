import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/dialog/dialog.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/extensions/validation_ext.dart';
import 'package:tracking_app/core/theme/app_styles.dart';
import 'package:tracking_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:tracking_app/features/login/presentation/login_view.dart';

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
                      context.l10n.reset_password,
                      style: AppStyles.medium18black,
                      textAlign: TextAlign.center,
                    ),
                    16.heightBox,
                    Text(
                      context.l10n.please_enter_your_new_password,
                      style: AppStyles.regular14grey,
                      textAlign: TextAlign.center,
                    ),
                    32.heightBox,
                    // New Password Field
                    TextFormField(
                      controller: widget.viewModel.newPasswordController,
                      validator: (value) => value.validatePassword(context),
                      onChanged: (_) => widget.viewModel.validateResetPassBtn(),
                      style: AppStyles.regular16black,
                      obscureText: !_isNewPasswordVisible,
                      obscuringCharacter: "★",
                      decoration: InputDecoration(
                        hintText: context.l10n.enter_your_new_password,
                        hintStyle: AppStyles.regular14grey,
                        labelText: context.l10n.new_password,
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
                      validator: (value) => value.validateConfirmPassword(
                        widget.viewModel.newPasswordController,
                        context,
                      ),
                      onChanged: (_) => widget.viewModel.validateResetPassBtn(),
                      style: AppStyles.regular16black,
                      obscureText: !_isConfirmPasswordVisible,
                      obscuringCharacter: "★",
                      decoration: InputDecoration(
                        hintText: context.l10n.confirm_your_password,
                        hintStyle: AppStyles.regular14grey,
                        labelText: context.l10n.confirm_password,
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
                      child: Text(context.l10n.reset_password),
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
            loadingMessage: context.l10n.loading,
          );
        } else if (state is ResetPassSuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            content: context
                .l10n
                .password_reset_success_please_login_again_with_your_new_password,
            posActions: context.l10n.ok,
            posFunction: (context) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (builder) => const LoginView()),
                (route) {
                  return false;
                },
              );
            },
          );
        } else if (state is ResetPassFailureState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            title: context.l10n.error,
            content: state.error,
            negActions: context.l10n.ok,
          );
        }
      },
    );
  }

  /// Navigates to login screen and clears the entire navigation stack
}
