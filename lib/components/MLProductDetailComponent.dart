import 'package:flutter/material.dart';
import 'package:ESMV_STORE/main.dart';
import 'package:nb_utils/nb_utils.dart';

class MLProductDetailComponent extends StatelessWidget {
  final String productName;
  final String description;
  final String price;
  final String ref;
  final String quantity;

  MLProductDetailComponent({required this.productName, required this.description, required this.price,required this.ref,required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radiusOnly(topLeft: 24, topRight: 24),
        backgroundColor: appStore.isDarkModeOn ? black : white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  productName,
                  style: boldTextStyle(size: 16,color: Colors.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          8.height,
          Text(ref, style: boldTextStyle(color: Colors.grey)),
          8.height,
          Row(
            children: [

              4.width
            ],
          ),
          16.height,
          Divider(thickness: 1.0),
          8.height,
          Text('Specification', style: boldTextStyle()),
          16.height,
          Table(
            children: [
              TableRow(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.local_atm, color: Colors.blue, size: 18),
                          4.width,
                          Text('Prix  :  ', style: boldTextStyle()),
                          Text(price, style: boldTextStyle(size: 20, color: Colors.blue.shade600)),
                          Text(' MRU', style: boldTextStyle(size: 20, color: Colors.blue.shade600)),
                        ],
                      ),
                      4.height,
                    ],
                  ).paddingRight(16.0),
                ],
              )
            ],
          ),
          64.height,
        ],
      ),
    );
  }
}
