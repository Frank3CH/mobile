import 'package:ESMV_STORE/providers/cart_provider.dart';
import 'package:ESMV_STORE/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ESMV_STORE/screens/MLSplashScreen.dart';
import 'package:ESMV_STORE/screens/MLLoginScreen.dart';
import 'package:ESMV_STORE/screens/MLDashboardScreen.dart';
import 'package:ESMV_STORE/store/AppStore.dart';
import 'package:ESMV_STORE/utils/AppTheme.dart';
import 'package:ESMV_STORE/utils/MLDataProvider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:ESMV_STORE/providers/auth_provider.dart';
import 'package:ESMV_STORE/providers/product_provider.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          supportedLocales: LanguageDataModel.languageLocales(),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) => locale,
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
