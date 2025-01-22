import 'package:esmv_store/model/Commande.dart';
import 'package:flutter/material.dart';
import 'package:esmv_store/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:esmv_store/model/MLDeliveredData.dart';
import 'package:esmv_store/utils/MLColors.dart';
import 'package:esmv_store/utils/MLDataProvider.dart';

class MLOrderTrackingDetailComponent extends StatefulWidget {
  static String tag = '/MLOrderTrackingDetailComponent';

  final Commande order;

  MLOrderTrackingDetailComponent({required this.order});

  @override
  MLOrderTrackingDetailComponentState createState() => MLOrderTrackingDetailComponentState();
}

class MLOrderTrackingDetailComponentState extends State<MLOrderTrackingDetailComponent> {
  List<MLDeliveredData> descriptionData = mlDeliveredStatusDataList();

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
    Commande order = widget.order;

    return ListView(
      physics: AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(16.0),
      shrinkWrap: true,
      children: [
        16.height,
        Text('Détails', style: boldTextStyle(size: 18)),
        16.height,
        Text('Statut: ${order.status}', style: boldTextStyle()),
        8.height,
        Text('Réference: ${order.ref}', style: secondaryTextStyle()),
        8.height,
        Text('Date: ${order.dateCreation}', style: secondaryTextStyle()),
        16.height,
        Divider(thickness: 0.5),
        16.height,
        Text('Produits', style: boldTextStyle(size: 18)),
        16.height,
        Column(
          children: order.products.map((product) {

            Color quantityColor = product.quantity == 0 ? Colors.red : (appStore.isDarkModeOn ? white : blackColor);

            return Container(
              padding: EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radius(12),
                backgroundColor: context.cardColor,
                border: Border.all(color: mlColorLightGrey),
              ),
              child: Row(
                children: [
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichTextWidget(
                        overflow: TextOverflow.ellipsis,
                        list: <TextSpan>[
                          TextSpan(
                              text: product.name,
                              style: boldTextStyle(color: quantityColor)
                          ),
                          TextSpan(text: ''),
                        ],
                      ),
                      8.height,
                      Text(
                          'Ref: ${product.ref}',
                          style: boldTextStyle(
                              size: 14,
                              color: quantityColor
                          )
                      ),
                      12.height,
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                size: 16,
                                color: quantityColor,
                              ),
                              Text(
                                  'Quantité: ',
                                  style: boldTextStyle(
                                      color: quantityColor,
                                      size: 14
                                  )
                              ),
                              Text(
                                  '${product.quantity} ',
                                  style: boldTextStyle(
                                      color: quantityColor
                                  )
                              ),
                            ],
                          ),
                          Text(
                              '${product.price}MRU/unité',
                              style: boldTextStyle(size: 10, color: mlColorBlue)
                          ),
                        ],
                      ),
                      8.height,
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}