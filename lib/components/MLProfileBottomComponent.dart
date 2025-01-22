import 'package:esmv_store/providers/auth_provider.dart';
import 'package:esmv_store/screens/TransactionHistoryScreen.dart';
import 'package:esmv_store/utils/MLImage.dart';
import 'package:flutter/material.dart';
import 'package:esmv_store/main.dart';
import 'package:esmv_store/model/MLProfileCardData.dart';
import 'package:esmv_store/utils/MLColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class MLProfileBottomComponent extends StatefulWidget {
  static String tag = '/MLProfileBottomComponent';

  @override
  MLProfileBottomComponentState createState() => MLProfileBottomComponentState();
}

List<MLProfileCardData> mlProfileDataList() {
  List<MLProfileCardData> list = [];
  list.add(MLProfileCardData(img: ml_prescription2, name: 'Solde comptable', color: Colors.orangeAccent));
  return list;
}

class MLProfileBottomComponentState extends State<MLProfileBottomComponent> {
  List<String> data = <String>['Solde comptable','Logout'];
  List<String> categoriesData = <String>[ 'logout'];
  List<Color> customColor = <Color>[Colors.blueAccent, Colors.orangeAccent];
  List<MLProfileCardData> mlProfileData = mlProfileDataList();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                Provider.of<AuthProvider>(context, listen: false).logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radiusOnly(topRight: 32),
        backgroundColor: appStore.isDarkModeOn ? blackColor : white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Options', style: boldTextStyle(size: 18)),
            ],
          ),

          16.height,
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: boxDecorationRoundedWithShadow(8, backgroundColor: context.cardColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('images/ic_theme.png', height: 24, width: 24, color: Colors.blue).paddingOnly(left: 4),
                    8.width,
                    Text('DarkMode', style: primaryTextStyle()),
                  ],
                ),
                Switch(
                  value: appStore.isDarkModeOn,
                  activeColor: appColorPrimary,
                  onChanged: (s) {
                    appStore.toggleDarkMode(value: s);
                  },
                )
              ],
            ),
          ).onTap(
                () {
              appStore.toggleDarkMode();
            },
          ),
          16.height,
          Column(
            children: data.map(
                  (e) {
                return Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  padding: EdgeInsets.all(12.0),
                  decoration: boxDecorationRoundedWithShadow(8, backgroundColor: context.cardColor),
                  child: Row(
                    children: [
                      Icon(Icons.tab, size: 24, color: Colors.blue),
                      8.width,
                      Text(e.validate(), style: primaryTextStyle()).expand(),
                      Icon(Icons.arrow_forward_ios, color: Colors.grey[300], size: 16),
                    ],
                  ),
                ).onTap(
                      () {
                    if (e == 'Logout') {
                      _showLogoutConfirmationDialog(context);
                    } else if (e == 'Solde comptable') {
                      // Navigate to TransactionHistoryScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TransactionHistoryScreen()),
                      );
                    }else {
                      toasty(context, e.validate());
                    }
                  },
                );
              },
            ).toList(),
          ),
          200.height,
        ],
      ),
    );
  }
}
