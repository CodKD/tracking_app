import 'package:flutter/material.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/theme/app_styles.dart';
import 'package:tracking_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:tracking_app/features/forget_password/presentation/widgets/forget_password_component.dart';
import 'package:tracking_app/features/forget_password/presentation/widgets/otp_component.dart';
import 'package:tracking_app/features/forget_password/presentation/widgets/reset_password_component.dart';

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
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          forgetPasswordViewModel.resetAllFields();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsets.only(left: context.width * 0.04),
            child: IconButton(
              onPressed: () {
                forgetPasswordViewModel.resetAllFields();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          leadingWidth: context.width * 0.09,
          title: Text('Reset Password', style: AppStyles.appBarTitleStyle),
          centerTitle: true,
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
      ),
    );
  }
}
