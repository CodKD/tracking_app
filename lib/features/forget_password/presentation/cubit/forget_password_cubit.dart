import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api_layer/api_result/api_result.dart';

import 'package:tracking_app/features/forget_password/domain/usecases/forget_password_use_case.dart';
import 'package:tracking_app/features/forget_password/domain/usecases/reset_password_use_case.dart';
import 'package:tracking_app/features/forget_password/domain/usecases/varify_reset_code_use_case.dart';

import '../../domain/entities/forget_password_response_entity.dart';
import '../../domain/entities/reset_password_response_entity.dart';
import '../../domain/entities/verify_reset_code_entity.dart';

part 'forget_password_state.dart';

@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPassStates> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final VerifyResetCodeUseCase verifyResetCodeUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  ForgetPasswordViewModel({
    required this.forgetPasswordUseCase,
    required this.verifyResetCodeUseCase,
    required this.resetPasswordUseCase,
  }) : super(ForgetPassInitState());

  // Page Controller
  final PageController pageController = PageController(initialPage: 0);

  // Forget Password Controllers
  final TextEditingController emailController = TextEditingController(
  );
  final GlobalKey<FormState> forgetPassFormKey = GlobalKey<FormState>();
  bool forgetPassBtnEnabled = false;

  // OTP Controllers
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> otpFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  bool otpBtnEnabled = false;

  // Reset Password Controllers
  final TextEditingController newPasswordController = TextEditingController(
  );
  final TextEditingController confirmPasswordController = TextEditingController(
  );
  final GlobalKey<FormState> resetPassFormKey = GlobalKey<FormState>();
  bool resetPassBtnEnabled = false;

  @override
  Future<void> close() {
    // Dispose controllers and focus nodes
    emailController.dispose();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in otpFocusNodes) {
      focusNode.dispose();
    }
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    pageController.dispose();
    return super.close();
  }

  // Forget Password Methods
  void validateForgetPassBtn() {
    final isEnabled = emailController.text.trim().isNotEmpty;
    if (forgetPassBtnEnabled != isEnabled) {
      forgetPassBtnEnabled = isEnabled;
      emit(ForgetPassBtnValidationState(isBtnEnabled: forgetPassBtnEnabled));
    }
  }

  Future<void> forgetPasswordRequest() async {
    if (!(forgetPassFormKey.currentState?.validate() ?? false)) return;

    emit(ForgetPassLoadingState());

    try {
      final result = await forgetPasswordUseCase.call(
        email: emailController.text.trim(),
      );

      switch (result) {
        case ApiSuccessResult<ForgetPasswordResponseEntity>():
          // Only navigate to OTP page on successful API call
          _navigateToOtpPage();
          emit(ForgetPassSuccessState());
          break;
        case ApiErrorResult():
          // Stay on current page and show error - DON'T navigate
          emit(ForgetPassFailureState(error: result.errorMessage));
          break;
      }
    } catch (e) {
      emit(ForgetPassFailureState(error: 'An unexpected error occurred'));
    }
  }

  void _navigateToOtpPage() {
    // Clear any previous OTP entries
    _clearOtpFields();

    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    // Emit OTP initial state after navigation
    Future.delayed(const Duration(milliseconds: 100), () {
      emit(OtpInitState());
    });
  }

  // OTP Methods
  void otpTextFieldOnChange(String value, int index, BuildContext context) {
    if (value.length == 1 && index < 5) {
      FocusScope.of(context).requestFocus(otpFocusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(otpFocusNodes[index - 1]);
    }
    validateOtpBtn();
  }

  void validateOtpBtn() {
    final isEnabled = !otpControllers.any(
      (controller) => controller.text.trim().isEmpty,
    );
    if (otpBtnEnabled != isEnabled) {
      otpBtnEnabled = isEnabled;
      emit(OtpBtnValidationState(isBtnEnabled: otpBtnEnabled));
    }
  }

  void onPasteOtp(String pastedText) {
    final characters = pastedText.split('');
    for (int i = 0; i < otpControllers.length; i++) {
      if (i < characters.length && RegExp(r'^[0-9]$').hasMatch(characters[i])) {
        otpControllers[i].text = characters[i];
      } else {
        otpControllers[i].clear();
      }
    }
    if (characters.isNotEmpty) {
      otpFocusNodes.last.requestFocus();
    }
    validateOtpBtn();
  }

  Future<void> otpValidationRequest() async {
    final otpCode = otpControllers
        .map((controller) => controller.text.trim())
        .join();
    if (otpCode.length != 6) {
      emit(OtpFailureState(error: 'Please enter complete OTP'));
      return;
    }

    emit(OtpLoadingState());

    try {
      final result = await verifyResetCodeUseCase.call(resetCode: otpCode);

      switch (result) {
        case ApiErrorResult():
          emit(OtpFailureState(error: result.errorMessage));
          break;
        case ApiSuccessResult<VerifyResetCodeResponseEntity>():
          emit(OtpSuccessState());
          _navigateToResetPasswordPage();

          break;
      }
    } catch (e) {
      emit(OtpFailureState(error: 'An unexpected error occurred'));
    }
  }

  void _navigateToResetPasswordPage() {
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    emit(ResetPassInitState());
  }

  Future<void> resendOtp() async {
    if (emailController.text.trim().isEmpty) {
      emit(OtpFailureState(error: 'Email is required'));
      return;
    }

    emit(OtpLoadingState());

    try {
      final result = await forgetPasswordUseCase.call(
        email: emailController.text.trim(),
      );

      switch (result) {
        case ApiSuccessResult<ForgetPasswordResponseEntity>():
          _clearOtpFields();
          emit(ForgetPassSuccessState());
          emit(OtpInitState());
          break;
        case ApiErrorResult():
          emit(OtpFailureState(error: result.errorMessage));
          break;
      }
    } catch (e) {
      emit(OtpFailureState(error: 'An unexpected error occurred'));
    }
  }

  void _clearOtpFields() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    validateOtpBtn();
  }

  // Reset Password Methods
  void validateResetPassBtn() {
    final isEnabled =
        newPasswordController.text.trim().isNotEmpty &&
        confirmPasswordController.text.trim().isNotEmpty;
    if (resetPassBtnEnabled != isEnabled) {
      resetPassBtnEnabled = isEnabled;
      emit(ResetPassBtnValidationState(isBtnEnabled: resetPassBtnEnabled));
    }
  }

  Future<void> resetPasswordRequest() async {
    if (!(resetPassFormKey.currentState?.validate() ?? false)) return;

    emit(ResetPassLoadingState());

    try {
      final result = await resetPasswordUseCase.call(
        email: emailController.text.trim(),
        newPassword: newPasswordController.text.trim(),
      );

      switch (result) {
        case ApiSuccessResult<ResetPasswordResponseEntity>():
          emit(ResetPassSuccessState());

          break;
        case ApiErrorResult():
          emit(ResetPassFailureState(error: result.errorMessage));
          break;
      }
    } catch (e) {
      emit(ResetPassFailureState(error: 'An unexpected error occurred'));
    }
  }

  // Reset all fields when starting fresh
  void resetAllFields() {
    emailController.clear();
    _clearOtpFields();
    newPasswordController.clear();
    confirmPasswordController.clear();
    forgetPassBtnEnabled = false;
    otpBtnEnabled = false;
    resetPassBtnEnabled = false;
    emit(ForgetPassInitState());
  }
}
