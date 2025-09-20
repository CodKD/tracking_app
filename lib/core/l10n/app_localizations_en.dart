// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Tracking App';

  @override
  String get appVersion => '1.0.0';

  @override
  String get pleaseEnterValue => 'Please enter value';

  @override
  String get pleaseEnterName => 'Please enter name';

  @override
  String get nameMustBeMoreThan3Characters =>
      'Name must be more than 3 characters';

  @override
  String get passwordMustContainUpperLowerAndSpecialCharacter =>
      'Password must contain upper, lower, and special character';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get pleaseEnterYourPassword => 'Please enter your password';

  @override
  String get pleaseEnterYourEmail => 'Please enter your email';

  @override
  String get emailMustBeLikeThisExampleGmailCom =>
      'Email must be like this \"example@gmail.com';

  @override
  String get pleaseEnterYourPhoneNumber => 'Please enter your phone number';

  @override
  String get enterAValidEgyptianPhoneNumber =>
      'Enter a valid Egyptian phone number (e.g., 01xxxxxxxxx)';

  @override
  String get home => 'Home';

  @override
  String get orders => 'Orders';

  @override
  String get profile => 'Profile';

  @override
  String get welcome_to_flowery_rider_app => 'Welcome To \nFlowery Rider App';

  @override
  String get login => 'Login';

  @override
  String get apply_now => 'Apply now';

  @override
  String get version => 'v 1.0.0-beta.1';

  @override
  String get enter_your_email => 'Enter your email';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get enter_your_password => 'Enter your password';

  @override
  String get remember_me => 'Remember me';

  @override
  String get forgot_password => 'Forgot password?';

  @override
  String get continue_btn => 'Continue';
}
