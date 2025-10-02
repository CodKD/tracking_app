import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Tracking App'**
  String get appName;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'1.0.0'**
  String get appVersion;

  /// No description provided for @pleaseEnterValue.
  ///
  /// In en, this message translates to:
  /// **'Please enter value'**
  String get pleaseEnterValue;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter name'**
  String get pleaseEnterName;

  /// No description provided for @nameMustBeMoreThan3Characters.
  ///
  /// In en, this message translates to:
  /// **'Name must be more than 3 characters'**
  String get nameMustBeMoreThan3Characters;

  /// No description provided for @passwordMustContainUpperLowerAndSpecialCharacter.
  ///
  /// In en, this message translates to:
  /// **'Password must contain upper, lower, and special character'**
  String get passwordMustContainUpperLowerAndSpecialCharacter;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @pleaseEnterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterYourPassword;

  /// No description provided for @pleaseEnterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterYourEmail;

  /// No description provided for @emailMustBeLikeThisExampleGmailCom.
  ///
  /// In en, this message translates to:
  /// **'Email must be like this \nexample@gmail.com'**
  String get emailMustBeLikeThisExampleGmailCom;

  /// No description provided for @pleaseEnterYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get pleaseEnterYourPhoneNumber;

  /// No description provided for @enterAValidEgyptianPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid Egyptian phone number (e.g., 01xxxxxxxxx)'**
  String get enterAValidEgyptianPhoneNumber;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @welcome_to_flowery_rider_app.
  ///
  /// In en, this message translates to:
  /// **'Welcome To \nFlowery Rider App'**
  String get welcome_to_flowery_rider_app;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @apply_now.
  ///
  /// In en, this message translates to:
  /// **'Apply now'**
  String get apply_now;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'v 1.0.0-beta.1'**
  String get version;

  /// No description provided for @enter_your_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enter_your_email;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enter_your_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enter_your_password;

  /// No description provided for @remember_me.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get remember_me;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgot_password;

  /// No description provided for @continue_btn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_btn;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @please_enter_your_email_to_receive_a_verification_code.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email to receive a verification code to create a new password via email'**
  String get please_enter_your_email_to_receive_a_verification_code;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @verification_code_sent_to_your_email.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent to your email'**
  String get verification_code_sent_to_your_email;

  /// No description provided for @email_not_found.
  ///
  /// In en, this message translates to:
  /// **'Email Not Found'**
  String get email_not_found;

  /// No description provided for @try_again.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get try_again;

  /// No description provided for @email_verification.
  ///
  /// In en, this message translates to:
  /// **'Email Verification'**
  String get email_verification;

  /// No description provided for @please_enter_the_6_digit_code_sent_to_your_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter the 6-digit code sent to your email'**
  String get please_enter_the_6_digit_code_sent_to_your_email;

  /// No description provided for @didnt_receive_the_code.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code? '**
  String get didnt_receive_the_code;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @please_enter_your_new_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter your new password'**
  String get please_enter_your_new_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @enter_your_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get enter_your_new_password;

  /// No description provided for @confirm_your_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirm_your_password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @password_reset_success_please_login_again_with_your_new_password.
  ///
  /// In en, this message translates to:
  /// **'Password reset successfully! Please login again with your new password.'**
  String get password_reset_success_please_login_again_with_your_new_password;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forget_password;

  /// No description provided for @apply_submitted_successfully.
  ///
  /// In en, this message translates to:
  /// **'Your application has been submitted!'**
  String get apply_submitted_successfully;

  /// No description provided for @apply_submitted_description.
  ///
  /// In en, this message translates to:
  /// **'Thank you for providing your application,\nwe will review your application and will\nget back to you soon.'**
  String get apply_submitted_description;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @first_name.
  ///
  /// In en, this message translates to:
  /// **'First Legal Name'**
  String get first_name;

  /// No description provided for @last_name.
  ///
  /// In en, this message translates to:
  /// **'Last Legal Name'**
  String get last_name;

  /// No description provided for @enter_first_name.
  ///
  /// In en, this message translates to:
  /// **'Enter First Legal Name'**
  String get enter_first_name;

  /// No description provided for @enter_last_name.
  ///
  /// In en, this message translates to:
  /// **'Enter Last Legal Name'**
  String get enter_last_name;

  /// No description provided for @nID.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get nID;

  /// No description provided for @n_iD_img.
  ///
  /// In en, this message translates to:
  /// **'National ID Image'**
  String get n_iD_img;

  /// No description provided for @vehicle_license.
  ///
  /// In en, this message translates to:
  /// **'Vehicle License'**
  String get vehicle_license;

  /// No description provided for @vehicle_number.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Number'**
  String get vehicle_number;

  /// No description provided for @vehicle_type.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Type'**
  String get vehicle_type;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!!'**
  String get welcome;

  /// No description provided for @descriptionApplyPage.
  ///
  /// In en, this message translates to:
  /// **'You want to be a delivery man?\nJoin our team'**
  String get descriptionApplyPage;

  /// No description provided for @descriptionCountry.
  ///
  /// In en, this message translates to:
  /// **'Please select your country'**
  String get descriptionCountry;

  /// No description provided for @descriptionFirstName.
  ///
  /// In en, this message translates to:
  /// **'Please Enter your First Name'**
  String get descriptionFirstName;

  /// No description provided for @descriptionLastName.
  ///
  /// In en, this message translates to:
  /// **'Please Enter your Last Name'**
  String get descriptionLastName;

  /// No description provided for @vehicleType.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Type'**
  String get vehicleType;

  /// No description provided for @vehicleNumber.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Number'**
  String get vehicleNumber;

  /// No description provided for @vehicleLicense.
  ///
  /// In en, this message translates to:
  /// **'Vehicle License'**
  String get vehicleLicense;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @descriptionEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get descriptionEmail;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @descriptionPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get descriptionPhoneNumber;

  /// No description provided for @descriptionVehicleNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid Vehicle number'**
  String get descriptionVehicleNumber;

  /// No description provided for @nId.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get nId;

  /// No description provided for @descriptionNId.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid National ID'**
  String get descriptionNId;

  /// No description provided for @nIdImg.
  ///
  /// In en, this message translates to:
  /// **'National ID Image'**
  String get nIdImg;

  /// No description provided for @passwordError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters,\ninclude 1 uppercase letter, 1 number, and 1 symbol.'**
  String get passwordError;

  /// No description provided for @confirmPasswordError.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get confirmPasswordError;

  /// No description provided for @uploadVehicleLicenseError.
  ///
  /// In en, this message translates to:
  /// **'Please upload your vehicle license image'**
  String get uploadVehicleLicenseError;

  /// No description provided for @uploadIdError.
  ///
  /// In en, this message translates to:
  /// **'Please upload your ID image'**
  String get uploadIdError;

  /// No description provided for @nationalIdError.
  ///
  /// In en, this message translates to:
  /// **'National ID must be exactly 14 digits'**
  String get nationalIdError;

  /// No description provided for @enter_vehicle_number.
  ///
  /// In en, this message translates to:
  /// **'Enter your vehicle number'**
  String get enter_vehicle_number;

  /// No description provided for @enter_phone.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enter_phone;

  /// No description provided for @enter_mail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enter_mail;

  /// No description provided for @enter_national_id.
  ///
  /// In en, this message translates to:
  /// **'Enter your national ID'**
  String get enter_national_id;

  /// No description provided for @choose_vehicle_license_img.
  ///
  /// In en, this message translates to:
  /// **'choose vehicle license image'**
  String get choose_vehicle_license_img;

  /// No description provided for @choose_national_id_img.
  ///
  /// In en, this message translates to:
  /// **'choose national ID image'**
  String get choose_national_id_img;

  /// No description provided for @areYouSureYouWantToLogOut.
  ///
  /// In en, this message translates to:
  /// **'Are You Sure You Want To Log Out'**
  String get areYouSureYouWantToLogOut;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get confirmLogout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @oldPassword.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get oldPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @enterOldPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter old password'**
  String get enterOldPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get enterNewPassword;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @passwordChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get passwordChangedSuccessfully;

  /// No description provided for @currentOrders.
  ///
  /// In en, this message translates to:
  /// **'Current Orders'**
  String get currentOrders;

  /// No description provided for @pastOrders.
  ///
  /// In en, this message translates to:
  /// **'Past Orders'**
  String get pastOrders;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @orderId.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get orderId;

  /// No description provided for @customerName.
  ///
  /// In en, this message translates to:
  /// **'Customer Name'**
  String get customerName;

  /// No description provided for @customerPhone.
  ///
  /// In en, this message translates to:
  /// **'Customer Phone'**
  String get customerPhone;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get deliveryAddress;

  /// No description provided for @orderStatus.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get orderStatus;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @photo_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Photo updated successfully'**
  String get photo_updated_successfully;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get changePhoto;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
