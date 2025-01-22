import 'package:ESMV_STORE/screens/MLAddToCartScreen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ESMV_STORE/components/MLPharmacyCategoriesComponent.dart';
import 'package:ESMV_STORE/utils/MLColors.dart';
import 'package:ESMV_STORE/utils/MLCommon.dart';
import 'package:ESMV_STORE/utils/MLImage.dart';

class MLOnlinePharmacyScreen extends StatefulWidget {
  static String tag = '/MLOnlinePharmacyScreen';

  @override
  MLOnlinePharmacyScreenState createState() => MLOnlinePharmacyScreenState();
}

class MLOnlinePharmacyScreenState extends State<MLOnlinePharmacyScreen> {
  PageController controller = PageController(
    viewportFraction: 0.8,
    initialPage: 0,
  );
  List<String> slides = <String>[
    ml_ic_pharmacySlide1!,
  ];

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
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 450,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: mlPrimaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          mlBackToPreviousWidget(context, white),
                          8.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Bienvenue', style: secondaryTextStyle(size: 12, color: white.withOpacity(0.5))),
                              4.height,
                              Text('John Doe', style: boldTextStyle(size: 14, color: white)),
                            ],
                          ),
                        ],
                      ).paddingAll(16.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ESMV', style: boldTextStyle(size: 26, color: white)),

                            ],
                          ).expand(),
                          Icon(Icons.search, color: white, size: 24),
                          8.width,
                          Stack(
                            children: [
                              Icon(Icons.shopping_bag_outlined, color: white, size: 24),
                              Positioned(
                                top: 0.0,
                                right: 0.0,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: boxDecorationWithRoundedCorners(backgroundColor: mlColorRed),
                                  constraints: BoxConstraints(minWidth: 12, minHeight: 12),
                                  child: Text(
                                    '0',
                                    style: boldTextStyle(size: 8, color: white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ).onTap(() {
                            MLAddToCartScreen().launch(context);
                          }),
                        ],
                      ).paddingAll(16.0),
                      8.height,
                      Container(
                        height: 180,
                        width: context.width(),
                        child:  commonCachedNetworkImage(
                          ml_ic_esmv_logo!,fit: BoxFit.contain,
                          ).paddingAll(3.0),
                        ),
                      16.height,
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {

                    return MLPharmacyCategoriesComponent();

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
