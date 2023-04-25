// Hide keyboard on tap outside field
import 'package:flutter/material.dart';

void hideKeyboard(BuildContext context) {
  final FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}
