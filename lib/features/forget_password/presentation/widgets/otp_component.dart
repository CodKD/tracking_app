import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_app/core/dialog/dialog.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/input_formatter/paste_input_formatter.dart';
import 'package:tracking_app/core/theme/app_colors.dart';
import 'package:tracking_app/core/theme/app_styles.dart';
import 'package:tracking_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';

class OtpComponent extends StatelessWidget {
  final ForgetPasswordViewModel viewModel;

  const OtpComponent({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordViewModel, ForgetPassStates>(
      bloc: viewModel,
      builder: (context, state) {
        final isError = state is OtpFailureState;

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.05,
            ).copyWith(top: context.height * 0.05),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.l10n.email_verification,
                    style: AppStyles.medium18black,
                    textAlign: TextAlign.center,
                  ),
                  16.heightBox,
                  Text(
                    context
                        .l10n
                        .please_enter_the_6_digit_code_sent_to_your_email,
                    style: AppStyles.regular14grey,
                    textAlign: TextAlign.center,
                  ),
                  32.heightBox,
                  // OTP Input Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        height: context.height * 0.08,
                        width: context.width * 0.12,
                        child: TextFormField(
                          controller: viewModel.otpControllers[index],
                          focusNode: viewModel.otpFocusNodes[index],
                          onChanged: (value) => viewModel.otpTextFieldOnChange(
                            value,
                            index,
                            context,
                          ),
                          style: AppStyles.regular16black,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: '',
                            fillColor: isError
                                ? AppColors.white
                                : AppColors.pink[10],
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isError
                                    ? AppColors.red
                                    : Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isError
                                    ? AppColors.red
                                    : Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: isError ? AppColors.red : AppColors.pink,
                                width: 2,
                              ),
                            ),
                          ),
                          inputFormatters: [
                            PasteInputFormatter(onPaste: viewModel.onPasteOtp),
                          ],
                        ),
                      );
                    }),
                  ),
                  // Error Message
                  if (isError) ...[
                    8.heightBox,
                    Text(
                      state.error,
                      style: AppStyles.regular14grey.copyWith(
                        color: AppColors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  if (!isError) 8.heightBox,
                  24.heightBox,
                  // Continue Button
                  FilledButton(
                    onPressed: viewModel.otpBtnEnabled
                        ? () => viewModel.otpValidationRequest()
                        : null,

                    child: Text(context.l10n.continue_btn),
                  ),
                  24.heightBox,
                  // Resend OTP
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: context.l10n.didnt_receive_the_code,
                      style: AppStyles.regular16black,
                      children: [
                        TextSpan(
                          text: context.l10n.resend,
                          style: AppStyles.regular16black.copyWith(
                            color: AppColors.pink,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => viewModel.resendOtp(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is OtpLoadingState) {
          DialogUtils.showLoading(
            context: context,
            loadingMessage: context.l10n.loading,
          );
        } else if (state is OtpSuccessState) {
          DialogUtils.hideLoading(context);
        } else if (state is ForgetPassSuccessState) {
          // This is when OTP is resent
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            content: context.l10n.verification_code_sent_to_your_email,
            negActions: context.l10n.ok,
          );
        } else if (state is OtpFailureState) {
          DialogUtils.hideLoading(context);
          // Error is already shown in the UI
        }
      },
    );
  }
}
