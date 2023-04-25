import 'package:flutter/material.dart';
import 'package:sample_structure/main.dart';
import 'package:sample_structure/utils/shared_preference.dart';

Future<void> changeTheme() async {
  await SharedPreferencesHelper.instance.setTheme(
    isDarkMode: !SharedPreferencesHelper.instance.isDarkMode,
  );
  SharedPreferencesHelper.instance.isDarkMode
      ? themeNotifier.value = ThemeData.dark(useMaterial3: true)
      : themeNotifier.value = ThemeData.light(useMaterial3: true);

  themeNotifier.notifyListeners();
}
