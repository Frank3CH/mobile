import 'package:ESMV_STORE/components/MLHomeTopComponent.dart';
import 'package:ESMV_STORE/components/MlAdminHomeBottomComponent.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class MLAdminhomefragment extends StatefulWidget {
  static String tag = '/MLAdminhomefragment';
  @override
  _MLAdminhomefragmentState createState() => _MLAdminhomefragmentState();
}

class _MLAdminhomefragmentState extends State<MLAdminhomefragment> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MLHomeTopComponent(),
            22.height,
             MlAdminHomeBottomComponent(),
          ],
        ),
      ),
    );
  }
}
