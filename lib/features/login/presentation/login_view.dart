import 'package:flutter/material.dart';
import 'package:tracking_app/core/extensions/navigator_extensions.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/extensions/validation_ext.dart';
import 'package:tracking_app/core/theme/app_colors.dart';
import 'package:tracking_app/core/theme/app_styles.dart';
import 'package:tracking_app/core/utils/components/app_text_form_feild.dart';
import 'package:tracking_app/core/utils/components/custom_button.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        title: Text(context.l10n.login, style: AppStyles.font20BlackW500),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  24.heightBox,
                  AppTextFormField(
                    hintText: context.l10n.enter_your_email,
                    labelText: context.l10n.email,
                    controller: emailController,
                    isPassword: false,
                    validator: (value) => value.validateEmail(context),
                  ),
                  24.heightBox,
                  AppTextFormField(
                    isPassword: true,
                    hintText: context.l10n.enter_your_password,
                    labelText: context.l10n.password,
                    controller: passwordController,
                    validator: (value) => value.validatePassword(context),
                    suffixIcon: Icon(Icons.visibility_off),
                  ),
                  11.heightBox,
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          value: false,
                          onChanged: (value) {},
                          title: Text(
                            context.l10n.remember_me,
                            style: AppStyles.regular13grey.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
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
                    onPressed: () {},
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
  }
}
