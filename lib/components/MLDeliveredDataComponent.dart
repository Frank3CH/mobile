import 'package:esmv_store/l10n/gen/app_localizations.dart';
import 'package:esmv_store/utils/MLImage.dart';
import 'package:flutter/material.dart';
import 'package:esmv_store/utils/MLCommon.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:esmv_store/screens/MLOrderDetailScreen.dart';
import 'package:esmv_store/utils/MLColors.dart';
import 'package:esmv_store/model/Commande.dart';

class MLDeliveredDataComponent extends StatefulWidget {
  final List<Commande> orders;

    MLDeliveredDataComponent({required this.orders});

  static String tag = '/MLDeliveredDataComponent';

  @override
  MLDeliveredDataComponentState createState() => MLDeliveredDataComponentState();
}

class MLDeliveredDataComponentState extends State<MLDeliveredDataComponent> {
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
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: widget.orders.isEmpty
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(AppLocalizations.of(context)!.noactivity, style: secondaryTextStyle()),
        ),
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.orders.map((order) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    decoration: boxDecorationRoundedWithShadow(12, backgroundColor: context.cardColor),
                    child: Column(
                      children: [
                        16.height,
                        Row(
                          children: [
                            commonCachedNetworkImage(
                              ml_ic_mediIconOne,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ).cornerRadiusWithClipRRect(8.0),
                            8.width,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichTextWidget(
                                  overflow: TextOverflow.ellipsis,
                                  list: <TextSpan>[
                                    TextSpan(text: order.ref, style: boldTextStyle()), // Assuming you have a name field
                                    TextSpan(text: ''),
                                  ],
                                ),
                                8.height,
                                Text((' ${AppLocalizations.of(context)!.total} : ${order.products.length} ${AppLocalizations.of(context)!.products}'), style: secondaryTextStyle()),

                                8.height,
                              ],
                            ),
                          ],
                        ).paddingOnly(right: 16.0, left: 16.0),
                        8.height,
                        Divider(thickness: 0.5),
                        8.height,
                        Row(
                          children: [
                            Text('${AppLocalizations.of(context)!.total} : ', style: boldTextStyle()),
                            Text('${order.totalPrice.toStringAsFixed(2)} MRU', style: boldTextStyle(color: mlColorDarkBlue)).expand(),
                            Text(order.dateCreation.toString(), style: boldTextStyle())
                          ],
                        ).paddingOnly(right: 16.0, left: 16.0),
                        16.height,
                      ],
                    ),
                  ).paddingTop(8.0),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    decoration: boxDecorationWithRoundedCorners(
                      backgroundColor: (order.status == 'en attente') ? Colors.orange : mlColorBlue,
                      borderRadius: radius(20),
                    ),
                    child: Text(
                      order.status,
                      style: secondaryTextStyle(color: white),
                    ).paddingOnly(right: 10.0, left: 10.0),
                  ).paddingLeft(16.0),
                ],
              ),
            ],
          ).paddingBottom(16.0).onTap(() {
            MLOrderDetailScreen(order: order).launch(context);
          });
        }).toList(),
      ).paddingOnly(right: 16.0, left: 16.0),
    );
  }
}
