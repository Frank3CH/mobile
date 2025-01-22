import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ESMV_STORE/components/MLNotificationComponent.dart';
import 'package:ESMV_STORE/model/MLNotificationData.dart';
import 'package:ESMV_STORE/utils/MLColors.dart';
import 'package:ESMV_STORE/utils/MLString.dart';
import 'package:ESMV_STORE/main.dart';

class MLNotificationFragment extends StatefulWidget {
  static String tag = '/MLNotificationFragment';

  @override
  MLNotificationFragmentState createState() => MLNotificationFragmentState();
}

class MLNotificationFragmentState extends State<MLNotificationFragment> {
  List<MLNotificationData> data = [];
  bool checked = false;
  int? newNotification = 3;
  Color customColor = mlColorBlue;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Container(
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: radiusOnly(topRight: 32),
            backgroundColor: appStore.isDarkModeOn ? black : white,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(mlNotification!, style: boldTextStyle(size: 20)),
                      8.width
                    ],
                  ).expand(),
                ],
              ).paddingAll(16.0),
              MLNotificationComponent().expand(),
              8.height,
            ],
          ),
        ),
      ),
    );
  }
}
