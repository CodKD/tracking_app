import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/resources/app_constants.dart';
import '../modules/shared_preferences_module.dart';

@injectable
class LocaleCubit extends Cubit<Locale> {
    final SharedPrefHelper sharedPrefHelper;

  LocaleCubit({required this.sharedPrefHelper}) : super(const Locale("en")) {
    _loadSavedLang();

  }

  void _loadSavedLang() {
    final savedLang = sharedPrefHelper.getValue(AppConstants.languageKey);
    if (savedLang != null && savedLang.isNotEmpty) {
      emit(Locale(savedLang));
    }
  }

  void changeLang(String langCode) {
    sharedPrefHelper.setValue(AppConstants.languageKey, langCode);
    emit(Locale(langCode));
  }
}
