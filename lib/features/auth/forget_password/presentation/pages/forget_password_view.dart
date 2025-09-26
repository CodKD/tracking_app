import 'package:flutter/material.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/theme/app_styles.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/widgets/forget_password_component.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/widgets/otp_component.dart';
import 'package:tracking_app/features/auth/forget_password/presentation/widgets/reset_password_component.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  late final ForgetPasswordViewModel forgetPasswordViewModel;

  @override
  void initState() {
    super.initState();
    forgetPasswordViewModel = getIt<ForgetPasswordViewModel>();
  }

  @override
  void dispose() {
    forgetPasswordViewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: context.width * 0.04),
          child: IconButton(
            onPressed: () {
              forgetPasswordViewModel.resetAllFields();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        leadingWidth: context.width * 0.09,
        title: Text(context.l10n.password, style: AppStyles.appBarTitleStyle),
        centerTitle: false,
      ),
      body: PageView(
        controller: forgetPasswordViewModel.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ForgetPasswordComponent(viewModel: forgetPasswordViewModel),
          OtpComponent(viewModel: forgetPasswordViewModel),
          ResetPasswordComponent(viewModel: forgetPasswordViewModel),
        ],
      ),
    );
  }
}
