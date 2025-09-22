part of 'forget_password_cubit.dart';

sealed class ForgetPassStates {}

// Initial States
class ForgetPassInitState extends ForgetPassStates {}

class OtpInitState extends ForgetPassStates {}

class ResetPassInitState extends ForgetPassStates {}

// Loading States
class ForgetPassLoadingState extends ForgetPassStates {}

class OtpLoadingState extends ForgetPassStates {}

class ResetPassLoadingState extends ForgetPassStates {}

// Success States
class ForgetPassSuccessState extends ForgetPassStates {}

class OtpSuccessState extends ForgetPassStates {}

class ResetPassSuccessState extends ForgetPassStates {}

// Failure States
class ForgetPassFailureState extends ForgetPassStates {
  final String error;
  ForgetPassFailureState({required this.error});
}

class OtpFailureState extends ForgetPassStates {
  final String error;
  OtpFailureState({required this.error});
}

class ResetPassFailureState extends ForgetPassStates {
  final String error;
  ResetPassFailureState({required this.error});
}

// Button Validation States
class ForgetPassBtnValidationState extends ForgetPassStates {
  final bool isBtnEnabled;
  ForgetPassBtnValidationState({required this.isBtnEnabled});
}

class OtpBtnValidationState extends ForgetPassStates {
  final bool isBtnEnabled;
  OtpBtnValidationState({required this.isBtnEnabled});
}

class ResetPassBtnValidationState extends ForgetPassStates {
  final bool isBtnEnabled;
  ResetPassBtnValidationState({required this.isBtnEnabled});
}
