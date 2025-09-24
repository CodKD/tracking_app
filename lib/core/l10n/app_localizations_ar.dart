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
  String get welcome_to_flowery_rider_app =>
      'مرحباً بك \n في تطبيق فلاوري للسائق ';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get apply_now => 'التقديم الان';

  @override
  String get version => 'v 1.0.0-beta.1';

  @override
  String get enter_your_email => 'ادخل العنوان الالكتروني';

  @override
  String get email => 'العنوان الالكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get enter_your_password => 'ادخل كلمة المرور';

  @override
  String get remember_me => 'تذكرني';

  @override
  String get forgot_password => 'نسيت كلمة المرور؟';

  @override
  String get continue_btn => 'الاستمرار';

  @override
  String get ok => 'حسناً';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get success => 'تم بنجاح';
}
