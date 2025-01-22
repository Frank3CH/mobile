import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ESMV_STORE/main.dart';
import 'package:ESMV_STORE/model/MLOrderSuccessData.dart';
import 'package:ESMV_STORE/utils/MLColors.dart';

class MLOrderSuccessComponent extends StatelessWidget {
  final List<MLOrderSuccessData> orderDetails;
  final double totalPrice;

  MLOrderSuccessComponent({required this.orderDetails, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radiusOnly(topRight: 32),
        backgroundColor: appStore.isDarkModeOn ? black : white,
      ),
      child: Column(
        children: [
          16.height,
          Text('Commande total', style: secondaryTextStyle(size: 16)),
          8.height,
          Text('${totalPrice} MRU', style: boldTextStyle(size: 18)),
          16.height,
          Divider(height: 0.5),
          16.height,
          Column(
            children: orderDetails.map(
                  (e) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.rounded_corner, size: 16, color: black),
                    4.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.title.validate(), style: primaryTextStyle()),
                        4.height,
                        Text(e.data.validate(), style: boldTextStyle(color: mlColorBlue, size: 18)),
                      ],
                    ),
                  ],
                ).paddingBottom(16.0);
              },
            ).toList(),
          ),
          42.height,
        ],
      ),
    );
  }
}
