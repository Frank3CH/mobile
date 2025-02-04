import 'package:esmv_store/l10n/gen/app_localizations.dart';
import 'package:esmv_store/providers/cart_provider.dart';
import 'package:esmv_store/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:esmv_store/screens/MLSplashScreen.dart';
import 'package:esmv_store/screens/MLLoginScreen.dart';
import 'package:esmv_store/screens/MLDashboardScreen.dart';
import 'package:esmv_store/store/AppStore.dart';
import 'package:esmv_store/utils/AppTheme.dart';
import 'package:esmv_store/utils/MLDataProvider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:esmv_store/providers/auth_provider.dart';
import 'package:esmv_store/providers/product_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize(aLocaleLanguageList: languageList());
  await Firebase.initializeApp();
  appStore.toggleDarkMode(value: getBoolAsync('isDarkModeOnPref'));
  defaultRadius = 10;
  defaultToastGravityGlobal = ToastGravity.BOTTOM;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: Observer(
        builder: (_) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '${'EMSV STORE'}${!isMobile ? ' ${platformName()}' : ''}',
          theme: !appStore.isDarkModeOn ? AppThemeData.lightTheme : AppThemeData.darkTheme,
          navigatorKey: navigatorKey,
          scrollBehavior: SBehavior(),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: _locale, // Use the selected locale
          localeResolutionCallback: (locale, supportedLocales) {
            // Return the locale if it's supported, otherwise fallback to the default locale
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          initialRoute: '/MLSplashScreen',
          routes: {
            '/MLSplashScreen': (context) => MLSplashScreen(),
            '/MLLoginScreen': (context) => MLLoginScreen(),
            '/MLDashboardScreen': (context) => MLDashboardScreen(),
          },
        ),
      ),
    );
  }
}