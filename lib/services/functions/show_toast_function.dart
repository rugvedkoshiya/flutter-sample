import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sample_structure/main.dart';


void showToast({required dynamic message}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    // TODO: Add API error here
    msg: message.toString(),
    // msg: message is AppException
    //     ? message.getMessage
    //     : (message?.toString() ?? APIErrorMsg.somethingWentWrong),
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 3,
    backgroundColor: Theme.of(getContext).primaryColorLight,
    textColor: Theme.of(getContext).primaryColorDark,
    // fontSize: getSize(16),
  );
}
