import 'package:flutter/material.dart';
import 'package:sample_structure/l10n/app_localizations.dart';
import 'package:sample_structure/main.dart';
import 'package:sample_structure/utils/custom_extension.dart';
import 'package:sample_structure/widget/common/cust_text_widget.dart';

class LanguageDialogWidget extends StatelessWidget {
  const LanguageDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColorLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.all(10.0),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: AppLocalizations.supportedLocales.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: CustText(
                title: AppLocalizations.supportedLocales[index].getLanguageName,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColorDark,
                    ),
              ),
              tileColor: Theme.of(context).primaryColorLight,
              onTap: () async {
                App.setLocale(AppLocalizations.supportedLocales[index]);
                Navigator.pop(context);
                // Navigator.pop(context);
              },
            );
          },
        ),
      ),
    );
  }
}
