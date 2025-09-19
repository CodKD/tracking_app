import 'package:flutter/material.dart';
import 'package:tracking_app/core/extensions/project_extensions.dart';
import 'package:tracking_app/core/input_formatter/app_regex.dart';

extension StringValidation on String? {
  //Non_empty validator
  String? validateNonEmpty(BuildContext context) {
    if (this == null || this!.isEmpty) {
      return context.l10n.pleaseEnterValue;
    }
    return null;
  }

  //Non_empty validator for custom parameter
  String? validateEmpty(String customMessage) {
    if (this == null || this!.isEmpty) {
      return customMessage;
    }
    return null;
  }

  //first-last name validator
  String? validateName(BuildContext context) {
    if (this == null || this!.isEmpty) {
      return context.l10n.pleaseEnterName;
    }
    if (!AppRegex.hasNameLength(this!)) {
      return context.l10n.nameMustBeMoreThan3Characters;
    }
    return null;
  }

  //Password validator
  String? validatePassword(BuildContext context) {
    if (this == null || this!.isEmpty) {
      return context.l10n.pleaseEnterYourPassword;
    }
    if (!AppRegex.isPasswordValid(this!)) {
      return context.l10n.passwordMustContainUpperLowerAndSpecialCharacter;
    }
    return null;
  }

  //Confirm password validator
  String? validateConfirmPassword(
    TextEditingController passwordController,
    BuildContext context,
  ) {
    if (this == null || this!.isEmpty) {
      return context.l10n.pleaseEnterYourPassword;
    }
    if (this != passwordController.text) {
      return context.l10n.passwordsDoNotMatch;
    }
    return null;
  }

  //Email validation
  String? validateEmail(BuildContext context) {
    if (this == null || this!.isEmpty) {
      return context.l10n.passwordMustContainUpperLowerAndSpecialCharacter;
    }
    if (!AppRegex.isEmailValid(this!)) {
      return context.l10n.emailMustBeLikeThisExampleGmailCom;
    }
    return null;
  }

  //Phone validation
  String? validatePhoneNumber(BuildContext context) {
    if (this == null || this!.isEmpty) {
      return context.l10n.pleaseEnterYourPhoneNumber;
    }
    if (!AppRegex.isPhoneNumberValid(this!)) {
      return context.l10n.enterAValidEgyptianPhoneNumber;
    }

    return null;
  }
}
