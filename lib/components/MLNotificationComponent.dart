import 'package:flutter/material.dart';
import 'package:ESMV_STORE/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ESMV_STORE/model/MLNotificationData.dart';
import 'package:ESMV_STORE/utils/MLColors.dart';
import 'package:ESMV_STORE/services/notification_service.dart';

class MLNotificationComponent extends StatefulWidget {
  static String tag = '/MLNotificationComponent';

  @override
  MLNotificationComponentState createState() => MLNotificationComponentState();
}

class MLNotificationComponentState extends State<MLNotificationComponent> {
  List<MLNotificationData> data = [];
  bool checked = false;
  int? newNotification = 3;
  Color customColor = mlColorBlue;

  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    init();
    fetchNotifications();
  }

  Future<void> init() async {
    //
  }

  Future<void> fetchNotifications() async {
    try {
      List<MLNotificationData> notifications = await _notificationService.fetchNotifications();
      setState(() {
        data = notifications;
      });
    } catch (e) {
      print('Failed to fetch notifications: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: data.isEmpty
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Aucune notification', style: secondaryTextStyle()),
        ),
      )
          : Column(
        children: data.map((e) {
          return Container(
            margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
            padding: EdgeInsets.all(16.0),
            decoration: boxDecorationRoundedWithShadow(
              8,
              backgroundColor: appStore.isDarkModeOn ? scaffoldDarkColor : white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 65,
                  width: 65,
                  decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: appStore.isDarkModeOn ? scaffoldDarkColor : Colors.grey.shade50,
                    borderRadius: radius(8),
                  ),
                  child: Image.asset((e.image).validate(), fit: BoxFit.fill),
                ),
                8.width,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (e.title).validate(),
                      style: secondaryTextStyle(color: appStore.isDarkModeOn ? white : blackColor),
                    ),
                    8.height,
                    (e.status != '')
                        ? Text(
                      (e.status).validate(),
                      style: secondaryTextStyle(),
                    )
                        : 0.height,
                    (e.status != '') ? 8.height : 0.height,
                    Row(
                      children: [
                        Text((e.time).validate(), style: boldTextStyle(size: 14, color: Colors.blue)).expand(),
                        (e.status != '')
                            ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: getStatusColor(e.status),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            (e.status).validate(),
                            style: secondaryTextStyle(color: white),
                          ).paddingOnly(left: 8.0, right: 8.0),
                        )
                            : Container(width: 0, height: 0),
                      ],
                    ),
                  ],
                ).expand(),
              ],
            ),
          );
        }).toList(),
      ).paddingOnly(right: 16.0, left: 16.0),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Refusé':
        return mlColorRed;
      case 'en attente':
        return Colors.lightBlue; // Couleur bleu ciel pour en attente
      case 'traitement en cours':
        return Colors.green; // Couleur verte pour traitement en cours
      default:
        return Colors.grey;
    }
  }
}
