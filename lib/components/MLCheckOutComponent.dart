import 'package:ESMV_STORE/utils/MLImage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ESMV_STORE/utils/MLCommon.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ESMV_STORE/utils/MLColors.dart';
import 'package:ESMV_STORE/providers/cart_provider.dart';

class MLCheckOutComponent extends StatefulWidget {
  static String tag = '/MLCheckOutComponent';

  @override
  MLCheckOutComponentState createState() => MLCheckOutComponentState();
}

class MLCheckOutComponentState extends State<MLCheckOutComponent> {
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
    final cartProvider = Provider.of<CartProvider>(context);
    log(cartProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          16.height,
          Container(
            decoration: boxDecorationWithRoundedCorners(
              border: Border.all(color: mlColorLightGrey),
              backgroundColor: context.cardColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                8.height,
                Text(
                  'Détails de votre Commande',
                  style: secondaryTextStyle(size: 16),
                ).paddingSymmetric(horizontal: 8),
                8.height,
                Divider(height: 0.5),
                Column(
                  children: cartProvider.cart.items.map(
                        (item) {
                      return Row(
                        children: [
                          commonCachedNetworkImage(
                            ml_ic_mediTwo,
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ).cornerRadiusWithClipRRect(8.0),
                          8.width,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.name,
                                  style: boldTextStyle(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2, // Allow up to 2 lines before truncating
                                ),
                                6.height,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.shopping_bag_outlined, size: 18, color: textSecondaryColorGlobal),
                                    Text('Quantity: ', style: boldTextStyle(size: 14, color: textSecondaryColorGlobal)),
                                    Text('${item.quantity}', style: boldTextStyle(size: 14)),
                                    50.width,
                                    Text('${item.product.price} MRU', style: boldTextStyle(size: 14, color: mlColorBlue)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ).paddingAll(8.0);
                    },
                  ).toList(),
                )
              ],
            ),
          ),
          64.height,
        ],
      ).paddingAll(16.0),
    );
  }
}
