import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/dialog/dialog.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/input_formatter/app_regex.dart';
import 'package:tracking_app/core/theme/app_styles.dart';
import 'package:tracking_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';

class ForgetPasswordComponent extends StatelessWidget {
  final ForgetPasswordViewModel viewModel;

  const ForgetPasswordComponent({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordViewModel, ForgetPassStates>(
      bloc: viewModel,
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.05,
            ).copyWith(top: context.height * 0.05),
            child: Form(
              key: viewModel.forgetPassFormKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Forget Password",
                      style: AppStyles.medium18black,
                      textAlign: TextAlign.center,
                    ),
                    16.heightBox,
                    Text(
                      "Please enter your email to receive a link to create a new password via email",
                      style: AppStyles.regular14grey,
                      textAlign: TextAlign.center,
                    ),
                    32.heightBox,
                    TextFormField(
                      controller: viewModel.emailController,
                      validator: (value) =>
                          AppRegex.isEmailValid(value?.trim() ?? '')
                          ? null
                          : "Please enter a valid email",
                      onChanged: (_) => viewModel.validateForgetPassBtn(),
                      style: AppStyles.regular16black,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: AppStyles.regular14grey,
                        labelText: "Email",
                        labelStyle: AppStyles.regular14black,
                      ),
                    ),
                    48.heightBox,
                    FilledButton(
                      onPressed: viewModel.forgetPassBtnEnabled
                          ? () => viewModel.forgetPasswordRequest()
                          : null,
                      child: Text("Send"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is ForgetPassLoadingState) {
          DialogUtils.showLoading(
            context: context,
            loadingMessage: "Checking email...",
          );
        } else if (state is ForgetPassSuccessState) {
          DialogUtils.hideLoading(context);
          // Show success message briefly before navigation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Verification code sent to your email"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        } else if (state is ForgetPassFailureState) {
          DialogUtils.hideLoading(context);
          // Show error message and stay on current screen
          DialogUtils.showMessage(
            context: context,
            title: "Email Not Found",
            content: state.error,
            negActions: "Try Again",
          );
        }
      },
    );
  }
}
