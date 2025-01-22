import 'package:flutter/material.dart';
import 'package:ESMV_STORE/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ESMV_STORE/components/MLPharmacyProductComponent.dart';

class MLCategoryComponent extends StatefulWidget {
  static String tag = '/MLCategoryComponent';

  @override
  MLCategoryComponentState createState() => MLCategoryComponentState();
}

class MLCategoryComponentState extends State<MLCategoryComponent> {


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
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radiusOnly(topRight: 32),
        backgroundColor: appStore.isDarkModeOn ? black : white,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Catégories', style: boldTextStyle(size: 20)).paddingOnly(right: 16.0, left: 16.0),

            8.height,
            Divider(thickness: 0.5),
            MLPharmacyProductComponent()
          ],
        ),
      ).paddingTop(32.0),
    );
  }
}
