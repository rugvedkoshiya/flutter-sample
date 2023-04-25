// ignore_for_file: inference_failure_on_function_invocation

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sample_structure/l10n/app_localizations.dart';
import 'package:sample_structure/widget/common/cust_text_widget.dart';

class InternetSensitiveWidget extends StatefulWidget {
  final Widget child;

  const InternetSensitiveWidget({super.key, required this.child});

  @override
  State<InternetSensitiveWidget> createState() =>
      _InternetSensitiveWidgetState();
}

class _InternetSensitiveWidgetState extends State<InternetSensitiveWidget> {
  late StreamSubscription<InternetConnectionStatus>
      internateConnectivitySubscription;
  bool isDialogShowing = false;
  InternetConnectionChecker internateConnectivity = InternetConnectionChecker();

  @override
  void initState() {
    internateConnectivitySubscription =
        internateConnectivity.onStatusChange.listen(checkNetworkConnection);
    super.initState();
  }

  @override
  void dispose() {
    internateConnectivitySubscription.cancel();
    super.dispose();
  }

  void checkNetworkConnection(InternetConnectionStatus status) {
    if (status == InternetConnectionStatus.disconnected) {
      if (isDialogShowing == false) {
        isDialogShowing = true;
        showConnectivityDialog(
          onTap: () {
            internateConnectivity.hasConnection.then(
              (value) => checkNetworkConnection(
                value == true
                    ? InternetConnectionStatus.connected
                    : InternetConnectionStatus.disconnected,
              ),
            );
          },
        );
      }
    } else {
      if (isDialogShowing) {
        Navigator.of(context).pop();
        isDialogShowing = false;
      }
    }
  }

  void showConnectivityDialog({required Function() onTap}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            icon: const Icon(Icons.network_check_rounded),
            title: CustText(
              title: AppLocalizations.of(context).noInternet,
              align: TextAlign.center,
            ),
            content:  CustText(
              title: AppLocalizations.of(context).noInternetMsg,
            ),
            actions: [
              CupertinoButton(
                onPressed: onTap,
                child:  CustText(
                  title: AppLocalizations.of(context).retry,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
