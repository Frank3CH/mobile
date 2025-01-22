import 'package:ESMV_STORE/screens/MLSearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ESMV_STORE/model/MLServiceData.dart';
import 'package:ESMV_STORE/screens/MLAddToCartScreen.dart';
import 'package:ESMV_STORE/utils/MLColors.dart';
import 'package:ESMV_STORE/utils/MLDataProvider.dart';
import 'package:ESMV_STORE/utils/MLImage.dart';
import 'package:provider/provider.dart';
import 'package:ESMV_STORE/providers/cart_provider.dart';
import 'package:ESMV_STORE/services/user_service.dart';

class MLHomeTopComponent extends StatefulWidget {
  static String tag = '/MLHomeTopComponent';

  @override
  _MLHomeTopComponentState createState() => _MLHomeTopComponentState();
}

class _MLHomeTopComponentState extends State<MLHomeTopComponent> {
  List<MLServicesData> data = mlServiceDataList();
  String? userName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    init();
    fetchUserName();
  }

  Future<void> init() async {
    //
  }

  Future<void> fetchUserName() async {
    try {
      UserService userProfileService = UserService();
      var profile = await userProfileService.fetchUserProfile();
      setState(() {
        userName = (profile.firstname!+' '+ profile.lastName!);
        setValue('userName', userName);
        isLoading = false;
      });
    } catch (e) {
      print('Failed to load user profile: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: context.width(),
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: mlPrimaryColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(MediaQuery.of(context).size.width, 80.0)),
      ),
      child: Column(
        children: [
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(child: Image.asset(ml_ic_profile_picture!), radius: 22, backgroundColor: mlColorCyan),
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bonjour", style: boldTextStyle(color: whiteColor)),
                      4.height,
                      if (isLoading)
                        CircularProgressIndicator(color: whiteColor)
                      else
                        Text(userName ?? "User", style: secondaryTextStyle(color: white.withOpacity(0.7))),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.search, color: white, size: 24).onTap(
                    () {
                    MLSearchScreen().launch(context);
                    },
                  ),
                  8.width,
                  Stack(
                    children: [
                      Icon(Icons.shopping_bag_outlined, color: white, size: 24),
                      Positioned(
                        top: 0.0,
                        right: 0.0,
                        child: Consumer<CartProvider>(
                          builder: (context, cartProvider, child) {
                            return Container(
                              padding: EdgeInsets.all(2),
                              decoration: boxDecorationWithRoundedCorners(backgroundColor: mlColorRed),
                              constraints: BoxConstraints(minWidth: 12, minHeight: 12),
                              child: Text(
                                cartProvider.cart.items.length.toString(),
                                style: boldTextStyle(size: 8, color: white),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ).onTap(() {
                    MLAddToCartScreen().launch(context);
                  }),

                ],
              )
            ],
          ).paddingOnly(right: 16.0, left: 16.0),
          Container(
            margin: EdgeInsets.only(right: 16.0, left: 16.0),
            transform: Matrix4.translationValues(0, 16.0, 0),
            alignment: Alignment.center,
            decoration: boxDecorationRoundedWithShadow(12, backgroundColor: context.cardColor),
            child: Wrap(
              alignment: WrapAlignment.center,
              direction: Axis.horizontal,
              spacing: 8.0,
              children: data.map(
                    (e) {
                  return Container(
                    constraints: BoxConstraints(minWidth: context.width() * 0.25),
                    padding: EdgeInsets.only(top: 20, bottom: 20.0),
                    child: Column(
                      children: [
                        Image.asset(e.image!, width: 100, height: 100, fit: BoxFit.contain),
                        8.height,
                      ],
                    ),
                  ).onTap(
                        () {},
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
