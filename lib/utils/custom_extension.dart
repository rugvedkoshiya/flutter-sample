import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sample_structure/main.dart';
import 'package:timeago/timeago.dart' as timeago;

const String spaceDashRegex = r'[^((0-9)|(a-z)|(A-Z)|\s)]';

// String extension
extension StringExtension on String {
  bool get isImage =>
      toLowerCase().endsWith(".jpg") ||
      toLowerCase().endsWith(".jpeg") ||
      toLowerCase().endsWith(".png") ||
      toLowerCase().endsWith(".gif") ||
      toLowerCase().endsWith(".webp") ||
      toLowerCase().endsWith(".heic");

  // Remove special character from string
  String get removeSpecialCharacters =>
      trim().replaceAll(RegExp('[^A-Za-z0-9]'), '');

  // Email validation regular expression
  static const String emailRegx =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  bool get isNetworkImage =>
      toLowerCase().startsWith("http://") ||
      toLowerCase().startsWith("https://");

  bool get isNetworkPdf =>
      toLowerCase().startsWith("http://") ||
      toLowerCase().startsWith("https://") && toLowerCase().endsWith(".pdf");

  // Check route is same route, if its same return empty
  String getRoute(BuildContext context) {
    return ModalRoute.of(context)?.settings.name == this ? "" : this;
  }
}

extension DateTimeExtension on DateTime {
  String get toRelativeDateTime {
    return timeago.format(this, locale: App.getLocale().languageCode);
  }
}

extension LocaleExtension on Locale {
  String get getLanguageName {
    // TODO: Implement dynamic language name
    // return getLanguageMap[languageCode] ?? "";
    return "English";
  }
}

extension PackageInfoExtension on PackageInfo {
  String get getFullVersion => "$version+$buildNumber";
}
