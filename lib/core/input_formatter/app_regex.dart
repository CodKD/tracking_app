class AppRegex {
  static bool isEmailValid(String email) {
    return RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
    ).hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$",
    ).hasMatch(password);
  }

  static bool isConfirmPasswordValid(String password, String confirmPassword) {
    bool isPasswordFormatValid = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$",
    ).hasMatch(password);

    if (confirmPassword.isEmpty) {
      return false;
    }

    bool doPasswordsMatch = (password == confirmPassword);

    return isPasswordFormatValid && doPasswordsMatch;
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^(2)(01)[0125][0-9]{8}$').hasMatch(phoneNumber);
  }

  static bool hasLowerCase(String password) {
    return RegExp(r'^(?=.*[a-z])').hasMatch(password);
  }

  static bool hasUpperCase(String password) {
    return RegExp(r'^(?=.*[A-Z])').hasMatch(password);
  }

  static bool hasNumber(String password) {
    return RegExp(r'^(?=.*?[0-9])').hasMatch(password);
  }

  static bool hasSpecialCharacter(String password) {
    return RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(password);
  }

  static bool hasMinLength(String password) {
    return RegExp(r'^(?=.{8,})').hasMatch(password);
  }

  static bool hasNameLength(String name) {
    return RegExp(r'^(?=.{3,})').hasMatch(name);
  }

  // National ID: لازم يكون 14 رقم مثلاً
  static bool isNIDValid(String nid) {
    final regex = RegExp(r'^\d{14}$');
    return regex.hasMatch(nid);
  }

  // Vehicle Number: وليكن 6 – 10 أرقام أو حروف
  static bool isVehicleNumberValid(String number) {
    final regex = RegExp(r'^[A-Za-z0-9]{6,10}$');
    return regex.hasMatch(number);
  }
}