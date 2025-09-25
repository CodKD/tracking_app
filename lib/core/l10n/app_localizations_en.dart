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
      'Email must be like this \nexample@gmail.com';

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
  String get apply => 'Apply';

  @override
  String get country => 'Country';

  @override
  String get email => 'Email';

  @override
  String get first_name => 'First Legal Name';

  @override
  String get last_name => 'Last Legal Name';

  @override
  String get enter_first_name => 'Enter First Legal Name';

  @override
  String get enter_last_name => 'Enter Last Legal Name';

  @override
  String get nID => 'National ID';

  @override
  String get n_iD_img => 'National ID Image';

  @override
  String get vehicle_license => 'Vehicle License';

  @override
  String get vehicle_number => 'Vehicle Number';

  @override
  String get vehicle_type => 'Vehicle Type';

  @override
  String get welcome => 'Welcome!!';

  @override
  String get descriptionApplyPage =>
      'You want to be a delivery man?\nJoin our team';

  @override
  String get descriptionCountry => 'Please select your country';

  @override
  String get descriptionFirstName => 'Please Enter your First Name';

  @override
  String get descriptionLastName => 'Please Enter your Last Name';

  @override
  String get vehicleType => 'Vehicle Type';

  @override
  String get vehicleNumber => 'Vehicle Number';

  @override
  String get vehicleLicense => 'Vehicle License';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get descriptionEmail => 'Please enter a valid email address';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get descriptionPhoneNumber => 'Please enter a valid phone number';

  @override
  String get descriptionVehicleNumber => 'Please enter a valid Vehicle number';

  @override
  String get nId => 'National ID';

  @override
  String get descriptionNId => 'Please enter a valid National ID';

  @override
  String get nIdImg => 'National ID Image';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get passwordError =>
      'Password must be at least 8 characters,\ninclude 1 uppercase letter, 1 number, and 1 symbol.';

  @override
  String get confirmPasswordError => 'Passwords do not match';

  @override
  String get uploadVehicleLicenseError =>
      'Please upload your vehicle license image';

  @override
  String get uploadIdError => 'Please upload your ID image';

  @override
  String get nationalIdError => 'National ID must be exactly 14 digits';
}
