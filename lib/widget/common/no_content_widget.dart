import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_structure/l10n/app_localizations.dart';
import 'package:sample_structure/main.dart';
import 'package:sample_structure/utils/math_utils.dart';
import 'package:sample_structure/widget/common/cust_text_widget.dart';

class NoContentLabel extends StatelessWidget {
  const NoContentLabel({
    Key? key,
    required this.title,
    this.btnText,
    this.style,
    this.onTap,
  }) : super(key: key);
  final String title;
  final String? btnText;
  final TextStyle? style;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: getVerticalSize(20),
          horizontal: getHorizontalSize(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustText(
              title: title,
              align: TextAlign.center,
              style: style ??
                  Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Theme.of(context).primaryColorDark,
                      ),
            ),
            SizedBox(height: getVerticalSize(20)),
            if (onTap == null)
              const SizedBox()
            else
              Platform.isIOS
                  ? CupertinoButton(
                      onPressed: onTap,
                      child: CustText(
                        title: btnText ?? AppLocalizations.of(getContext).retry,
                        align: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    )
                  : TextButton(
                      onPressed: onTap,
                      child: CustText(
                        title: btnText ?? AppLocalizations.of(getContext).retry,
                        align: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
