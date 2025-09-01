import 'dart:convert';

import 'package:app_core/app_core.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture_template/src/localization/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final Future<SharedPreferences> instanceFuture = SharedPreferences.getInstance();
  SettingsCubit() : super(SettingsInitial());

  _emitState(SettingsState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  void changeLocale(Locale locale) {
    var currentState = state;
    if (currentState is SettingsLoaded) {
      _emitState(currentState.copyWith(locale: locale));
      _saveSettingsToLocal();
    }
  }

  void changeThemeColor(Color themeColor) {
    var currentState = state;
    if (currentState is SettingsLoaded) {
      _emitState(currentState.copyWith(themeSettings: ThemeSettings(sourceColor: themeColor, themeMode: currentState.themeSettings.themeMode)));
      _saveSettingsToLocal();
    }
  }

  _saveSettingsToLocal() async {
    var currentState = state;
    if (currentState is SettingsLoaded) {
      // save to local

      var store = await instanceFuture;

      store.setString(Constant.LS_Settings, jsonEncode(currentState.toJson()));
    }
  }

  _loadSettingsFromLocal() async {
    try {
      var store = await instanceFuture;
      var settings = store.getString(Constant.LS_Settings);
      if (settings != null) {
        var settingsJson = jsonDecode(settings);
        return SettingsLoaded.fromJson(settingsJson);
      }
      return null;
    } on Exception {
      return null;
    }
  }

  void loadData() async {
    var savedSettings = await _loadSettingsFromLocal();
    if (savedSettings != null) {
      _emitState(savedSettings);
    } else {
      _emitState(
        SettingsLoaded(
          locale: AppLocalizations.supportedLocales.firstWhere((element) => element.languageCode == 'en'),
          themeSettings: ThemeSettings(sourceColor: Constant.primaryColor, themeMode: ThemeMode.system),
        ),
      );
    }
  }

  void changThemeMode(ThemeMode themeMode) {
    var currentState = state;
    if (currentState is SettingsLoaded) {
      _emitState(currentState.copyWith(themeSettings: ThemeSettings(sourceColor: currentState.themeSettings.sourceColor, themeMode: themeMode)));

      _saveSettingsToLocal();
    }
  }

  //toggle theme
  void toggleTheme() {
    var currentState = state;
    if (currentState is SettingsLoaded) {
      var newThemeMode = currentState.themeSettings.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
      _emitState(currentState.copyWith(themeSettings: ThemeSettings(sourceColor: currentState.themeSettings.sourceColor, themeMode: newThemeMode)));

      _saveSettingsToLocal();
    }
  }
}
