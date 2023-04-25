import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sample_structure/l10n/app_localizations.dart';
import 'package:sample_structure/screen/home.dart';
import 'package:sample_structure/utils/shared_preference.dart';
import 'package:sample_structure/widget/global/internet_sensetive_widget.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
BuildContext get getContext => navigatorKey.currentState!.context;
ValueNotifier<ThemeData> themeNotifier = ValueNotifier(
  ThemeData.light(useMaterial3: true),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.instance.loadSavedData();
  themeNotifier = ValueNotifier(SharedPreferencesHelper.instance.getTheme);
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  static Future<void> setLocale(Locale locale) async {
    final _AppState? state = getContext.findAncestorStateOfType<_AppState>();
    state!.setLocale(locale);
  }

  static Locale getLocale() {
    final state = getContext.findAncestorStateOfType<_AppState>();
    return state!.getLocale();
  }

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Locale getLocale() {
    final String? storedLocale = SharedPreferencesHelper.instance.getLocale;
    return storedLocale != null
        ? AppLocalizations.supportedLocales
            .firstWhere((locale) => locale.languageCode == storedLocale)
        : const Locale("en");
  }

  Future<void> setLocale(Locale locale) async {
    await SharedPreferencesHelper.instance.setLcoale(locale.languageCode);
    themeNotifier.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, theme, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: AppLocalizations.of(context).appName,
          locale: getLocale(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          theme: theme,
          home: const InternetSensitiveWidget(child: HomeScreen()),
        );
      },
    );
  }
}
