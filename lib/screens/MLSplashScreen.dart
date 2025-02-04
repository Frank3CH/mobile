import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:esmv_store/screens/MLLoginScreen.dart';
import 'package:esmv_store/screens/MLDashboardScreen.dart';
import 'package:esmv_store/utils/MLImage.dart';

class MLSplashScreen extends StatefulWidget {
  @override
  _MLSplashScreenState createState() => _MLSplashScreenState();
}

class _MLSplashScreenState extends State<MLSplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await 3.seconds.delay;

    bool isLoggedIn = getBoolAsync('isLoggedIn', defaultValue: false);
    bool isAdmin = getBoolAsync('isAdmin', defaultValue: false);

    if (isLoggedIn) {
      /// Navigate to Dashboard directly if logged in
      MLDashboardScreen(isAdmin: isAdmin).launch(context, isNewTask: true);
    } else {
      /// Navigate to Login Screen if not logged in
      MLLoginScreen().launch(context, isNewTask: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(ml_ic_medilab_logo!, height: 150, width: 150, fit: BoxFit.fill).center(),
    );
  }
}
