import 'package:ESMV_STORE/screens/MLSearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:ESMV_STORE/components/MLCheckOutComponent.dart';
import 'package:ESMV_STORE/components/MLShoppingCartComponent.dart';
import 'package:ESMV_STORE/utils/MLColors.dart';
import 'package:ESMV_STORE/main.dart';
import 'package:ESMV_STORE/providers/cart_provider.dart';
import 'package:ESMV_STORE/services/order_service.dart';

import 'MLConfirmOrderScreen.dart';

class MLAddToCartScreen extends StatefulWidget {
  static String tag = '/MLShoppingCartScreen';

  @override
  MLAddToCartScreenState createState() => MLAddToCartScreenState();
}

class MLAddToCartScreenState extends State<MLAddToCartScreen> {
  int currentWidget = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    // Any initialization code can go here
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> createOrder(BuildContext context) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    try {
      final orderData = {
        'pharmacien_id': 1, // Remplacer par les données réelles
        'fournisseur_id': 1, // Remplacer par les données réelles
        'order_products': cartProvider.cart.items.map((item) => {
          'product_id': item.product.id,
          'quantity': item.quantity,
        }).toList(),
      };

      final response = await OrderService().createOrder(orderData);

      if (response.statusCode == 201) {
        final order = response.data;
        print(order);
        cartProvider.clearCart();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MLConfirmOrderScreen(order: order),
          ),
        );
      } else {
        print('Error: ${response.data}');
      }
    } catch (e) {
      print('Error: $e');

    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Stack(
          children: [
            Container(
              height: context.height(),
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radiusOnly(topRight: 32),
                backgroundColor: appStore.isDarkModeOn ? black : white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    8.height,
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: appStore.isDarkModeOn ? white : blackColor,
                          size: 22,
                        ).onTap(
                              () {
                            currentWidget == 0
                                ? Navigator.of(context).pop()
                                : setState(() {
                              currentWidget--;
                            });
                          },
                        ),
                        currentWidget == 0
                            ? Row(
                          children: [
                            Text('Votre Panier', style: boldTextStyle(size: 24)),
                            8.width,
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: boxDecorationWithRoundedCorners(
                                backgroundColor: mlColorDarkBlue,
                                boxShape: BoxShape.circle,
                              ),
                              child: Text('${cartProvider.cart.items.length}',
                                  style: secondaryTextStyle(size: 18, color: white)),
                            ),
                            80.width,
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.add, color: Colors.white),
                                onPressed: () {
                                  if (mounted) {
                                    MLSearchScreen().launch(context);
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                            : Text('Votre Commande', style: boldTextStyle(size: 22)),
                      ],
                    ).paddingAll(16.0),
                    8.height,
                    Column(
                      children: [
                        Divider(height: 0.5),
                        currentWidget == 0 ? MLShoppingCartComponent() : MLCheckOutComponent(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                width: context.width(),
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radius(0.0),
                  backgroundColor: context.cardColor,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 0.0)],
                ),
                child: currentWidget == 0
                    ? Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    8.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total', style: secondaryTextStyle(size: 16)),
                        Text('${cartProvider.totalPrice.toStringAsFixed(2)} MRU', style: boldTextStyle()),
                      ],
                    ),
                    32.width,
                    AppButton(
                      color: mlColorDarkBlue,
                      onTap: () {
                        setState(() {
                          currentWidget++;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Commandez', style: boldTextStyle(color: white)),
                          4.width,
                          Icon(Icons.arrow_forward_ios, color: white, size: 16),
                        ],
                      ),
                    ).expand()
                  ],
                )
                    : AppButton(
                  color: mlColorDarkBlue,
                  width: context.width() / 2,
                  onTap: () {
                    createOrder(context);
                  },
                  child: Text('Confirm', style: boldTextStyle(color: white)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
