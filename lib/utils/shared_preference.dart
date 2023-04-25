import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  SharedPreferencesHelper._();
  static SharedPreferencesHelper instance = SharedPreferencesHelper._();

  // Shared preference keys
  static const String _localeKey = 'locale';
  static const String _themeKey = 'theme';

  // Variables...

  late SharedPreferences _prefs;
  bool _isDarkMode =
      SchedulerBinding.instance.window.platformBrightness == Brightness.light;
  late PackageInfo packageInfo;

  // Load saved data...
  Future<void> loadSavedData() async {
    _prefs = await SharedPreferences.getInstance();
    // _getUserDetail();
    _getTheme();
    loadPackageInfo();
  }

  //!------------------------------------------------- Setter --------------------------------------------------//

  // Set locale to storage
  Future<void> setLcoale(String locale) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(_localeKey, locale);
  }

  // Set theme data
  Future<void> setTheme({required bool isDarkMode}) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool(_themeKey, isDarkMode);
    // _prefs.remove(_kTheme);
    _isDarkMode = isDarkMode;
  }

//!------------------------------------------------- Getter --------------------------------------------------//
  // Get locale from storage
  String? get getLocale => _prefs.getString(_localeKey);

  // Load package information
  Future<void> loadPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  // Get darkmode sattus
  bool get isDarkMode => _isDarkMode;

  // Get themeData
  ThemeData get getTheme => _getTheme();

  // Get themeData
  ThemeData _getTheme() {
    if (_prefs.getBool(_themeKey) != null) {
      _isDarkMode = _prefs.getBool(_themeKey)!;
    } else {
      _isDarkMode = SchedulerBinding.instance.window.platformBrightness ==
          Brightness.light;
    }
    return _isDarkMode
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true);
  }

//!----------------------------------------------- Remove Cache Data --------------------------------------------------//
}
