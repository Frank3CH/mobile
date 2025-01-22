import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:esmv_store/components/MLHomeTopComponent.dart';

import 'package:esmv_store/components/MLPharmacyCategoriesComponent.dart';

class MLHomeFragment extends StatefulWidget {
  static String tag = '/MLHomeFragment';

  @override
  _MLHomeFragmentState createState() => _MLHomeFragmentState();
}

class _MLHomeFragmentState extends State<MLHomeFragment> {
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
            16.height,
            MLPharmacyCategoriesComponent(),
            64.height,
          ],
        ),
      ),
    );
  }
}
