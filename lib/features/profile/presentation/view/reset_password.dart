import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/extensions/spacer_media_quiey.dart';

import '../../../../core/api_layer/models/request/change_password_request_body.dart';
import '../../../../core/di/di.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/components/custom_button.dart';
import '../view_model/reset/reset_cubit.dart';
import '../widgets/reset_password_forms.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() =>
      _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late final TextEditingController passwordController;
  late final TextEditingController newPasswordController;
  late final ResetPasswordCubit resetPasswordCubit;
  late final GlobalKey<FormState> formKey =
      GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    newPasswordController = TextEditingController();
    resetPasswordCubit = getIt<ResetPasswordCubit>();
  }

  @override
  void dispose() {
    passwordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => resetPasswordCubit,
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(context.l10n.reset_password),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ResetPasswordForm(
                    passwordController:
                        passwordController,
                    newPasswordController:
                        newPasswordController,
                    formKey: formKey,
                  ),
                  SizedBox(
                    height: 2.5.heightPercent(context),
                  ),
                  CustomButton(
                    size: const Size(double.infinity, 48),
                    borderRadius: 30,
                    child: state is ChangePasswordLoading
                        ? const CircularProgressIndicator.adaptive(
                            backgroundColor:
                                AppColors.white,
                          )
                        : Text(context.l10n.update),
                    onPressed: () {
                      if (formKey.currentState!
                          .validate()) {
                        resetPasswordCubit.changePassword(
                          ChangePasswordRequestBody(
                            passwordController.text,

                            newPasswordController.text,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          switch (state) {
            case ChangePasswordLoading():
              const Center(
                child:
                    CircularProgressIndicator.adaptive(),
              );
              break;
            case ChangePasswordSuccess():
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    context.l10n.reset_password,
                  ),
                ),
              );
              Navigator.pop(context);
              break;
            case ChangePasswordError():
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );

              break;
            default:
          }
        },
      ),
    );
  }
}
