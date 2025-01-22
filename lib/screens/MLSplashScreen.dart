import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:esmv_store/screens/MLLoginScreen.dart';
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

    // Check if the user is already logged in
    bool isLoggedIn = getBoolAsync('isLoggedIn', defaultValue: false);


      MLLoginScreen().launch(context, isNewTask: true);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(ml_ic_medilab_logo!, height: 150, width: 150, fit: BoxFit.fill).center(),
    );
  }
}
