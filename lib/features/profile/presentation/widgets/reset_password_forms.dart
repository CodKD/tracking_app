import 'package:flutter/material.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/extensions/spacer_media_quiey.dart';
import 'package:tracking_app/core/utils/components/app_text_form_feild.dart';

import '../../../../core/theme/app_colors.dart';

class ResetPasswordForm extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController newPasswordController;
  final TextEditingController? confirmPasswordController;
  final GlobalKey<FormState> formKey;

  const ResetPasswordForm({
    super.key,
    this.confirmPasswordController,
    required this.passwordController,
    required this.newPasswordController,
    required this.formKey,
  });

  @override
  ResetPasswordFormState createState() => ResetPasswordFormState();
}

class ResetPasswordFormState extends State<ResetPasswordForm> {
  bool _passwordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Text(
            context.l10n.passwordMustContainUpperLowerAndSpecialCharacter,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: AppColors.grey),
          ),
          SizedBox(height: 2.heightPercent(context)),
          AppTextFormField(
            controller: widget.passwordController,
            hintText: context.l10n.enter_your_password,
            isPassword: true,

            suffixIcon: InkWell(
              child: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onTap: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),
          SizedBox(height: 2.heightPercent(context)),

          AppTextFormField(
            controller: widget.newPasswordController,
            hintText: context.l10n.new_password,

            suffixIcon: InkWell(
              child: Icon(
                _newPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onTap: () {
                setState(() {
                  _newPasswordVisible = !_newPasswordVisible;
                });
              },
            ),
            isPassword: true,
          ),
          SizedBox(height: 2.heightPercent(context)),
          AppTextFormField(
            controller: widget.confirmPasswordController,
            hintText: context.l10n.confirm_password,

            suffixIcon: InkWell(
              child: Icon(
                _confirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onTap: () {
                setState(() {
                  _confirmPasswordVisible = !_confirmPasswordVisible;
                });
              },
            ),
            isPassword: true,
          ),
        ],
      ),
    );
  }
}
