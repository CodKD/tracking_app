// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'تتبع الطلبات';

  @override
  String get appVersion => '1.0.0';

  @override
  String get pleaseEnterValue => 'ادخل قيمة';

  @override
  String get pleaseEnterName => 'من فضلك ادخل الاسم';

  @override
  String get nameMustBeMoreThan3Characters =>
      'الاسم يجب ان يكون اكبر من 3 حروف';

  @override
  String get passwordMustContainUpperLowerAndSpecialCharacter =>
      'يحب ان يحتوي علي حرف كبير و حرف صغير ورمز مميز';

  @override
  String get passwordsDoNotMatch => 'كلمة المرور غير متطابقه';

  @override
  String get pleaseEnterYourPassword => 'ادخل كلمة المرور';

  @override
  String get pleaseEnterYourEmail => 'ادخل البريد الالكتروني';

  @override
  String get emailMustBeLikeThisExampleGmailCom =>
      'البريد الالكتروني يجب ان يكون  \"example@gmail.com';

  @override
  String get pleaseEnterYourPhoneNumber => 'ادخل رقم الهاتف ';

  @override
  String get enterAValidEgyptianPhoneNumber =>
      'ادخل رفم هاتف مصري  (e.g., 01xxxxxxxxx)';

  @override
  String get home => 'الرئيسية';

  @override
  String get orders => 'الطلبات';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get apply => 'تقديم';

  @override
  // TODO: implement Country
  String get Country => 'دولة';

  @override
  // TODO: implement Email
  String get Email => 'البريد الالكتروني';

  @override
  // TODO: implement FirstName
  String get FirstName => 'الاسم الاول';

  @override
  // TODO: implement LastName
  String get LastName => 'الاسم الاخير';

  @override
  // TODO: implement NID
  String get NID => 'الرقم القومي';

  @override
  // TODO: implement NIDImg
  String get NIDImg => 'صورة الرقم القومي';

  @override
  // TODO: implement VehicleLicense
  String get VehicleLicense => 'رخصة السيارة';

  @override
  // TODO: implement VehicleNumber
  String get VehicleNumber => 'رقم السيارة';

  @override
  // TODO: implement VehicleType
  String get VehicleType => 'نوع السيارة';
}
