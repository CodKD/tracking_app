import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/dialog/dialog.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/extensions/validation_ext.dart';
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
                      context.l10n.forget_password,
                      style: AppStyles.medium18black,
                      textAlign: TextAlign.center,
                    ),
                    16.heightBox,
                    Text(
                      context
                          .l10n
                          .please_enter_your_email_to_receive_a_verification_code,
                      style: AppStyles.regular14grey,
                      textAlign: TextAlign.center,
                    ),
                    32.heightBox,
                    TextFormField(
                      controller: viewModel.emailController,
                      validator: (value) => value?.validateEmail(context),
                      onChanged: (_) => viewModel.validateForgetPassBtn(),
                      style: AppStyles.regular16black,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: context.l10n.email,
                        hintStyle: AppStyles.regular14grey,
                        labelText: context.l10n.email,
                        labelStyle: AppStyles.regular14black,
                      ),
                    ),
                    48.heightBox,
                    FilledButton(
                      onPressed: viewModel.forgetPassBtnEnabled
                          ? () => viewModel.forgetPasswordRequest()
                          : null,
                      child: Text(context.l10n.send),
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
            loadingMessage: context.l10n.loading,
          );
        } else if (state is ForgetPassSuccessState) {
          DialogUtils.hideLoading(context);
          // Show success message briefly before navigation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.verification_code_sent_to_your_email),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        } else if (state is ForgetPassFailureState) {
          DialogUtils.hideLoading(context);
          // Show error message and stay on current screen
          DialogUtils.showMessage(
            context: context,
            content: context.l10n.email_not_found,
            negActions: context.l10n.try_again,
          );
        }
      },
    );
  }
}
