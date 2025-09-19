import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tracking_app/core/resources/app_constants.dart';
import '../di/modules/shared_preferences_module.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale("en")) {
    _loadSavedLang();
  }

  void _loadSavedLang() {
    final savedLang = SharedPrefHelper().getValue(AppConstants.languageKey);
    if (savedLang != null && savedLang.isNotEmpty) {
      emit(Locale(savedLang));
    }
  }

  void changeLang(String langCode) {
    SharedPrefHelper().setValue(AppConstants.languageKey, langCode);
    emit(Locale(langCode));
  }
}
