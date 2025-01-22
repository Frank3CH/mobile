import 'package:ESMV_STORE/screens/MLAddToCartScreen.dart';
import 'package:ESMV_STORE/screens/MLDashboardScreen.dart';
import 'package:ESMV_STORE/screens/MLSearchScreen.dart';
import 'package:ESMV_STORE/utils/MLCommon.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ESMV_STORE/components/MLCategoryProductComponent.dart';
import 'package:ESMV_STORE/utils/MLColors.dart';
import 'package:provider/provider.dart';
import 'package:ESMV_STORE/providers/product_provider.dart';
import 'package:ESMV_STORE/providers/cart_provider.dart';

class MLOnlinePharmacyDetailScreen extends StatefulWidget {
  static String tag = '/MLOnlinePharmacyDetailScreen';
  final int? index;
  final int? selectedCategoryId;

  MLOnlinePharmacyDetailScreen({this.index, this.selectedCategoryId});

  @override
  MLOnlinePharmacyDetailScreenState createState() => MLOnlinePharmacyDetailScreenState();
}

class MLOnlinePharmacyDetailScreenState extends State<MLOnlinePharmacyDetailScreen> {
  late List<Widget> data;

  @override
  void initState() {
    super.initState();
    print('MLOnlinePharmacyDetailScreen initState: selectedCategoryId=${widget.selectedCategoryId}');
    data = [
      MLCategoryProductComponent(categoryId: widget.selectedCategoryId),
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

  Future<void> init() async {
    if (widget.selectedCategoryId != null) {
      await context.read<ProductProvider>().fetchProducts(page: 1, refresh: true, categoryId: widget.selectedCategoryId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mlBackToPreviousWidget(context, white),
                    8.width,
                    Text('Liste des medicaments', style: boldTextStyle(color: whiteColor, size: 20)).expand(),
                    Icon(Icons.home_outlined, color: white, size: 24).onTap(() {
                      if (mounted) {
                        MLDashboardScreen().launch(context);
                      }
                    }),
                    8.width,
                    Icon(Icons.search, color: white, size: 24).onTap(() {
                      if (mounted) {
                        MLSearchScreen().launch(context);
                      }
                    }),
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
                      if (mounted) {
                        MLAddToCartScreen().launch(context);
                      }
                    }),
                  ],
                ),
                8.height,
                Row(
                  children: [
                    Text('liste des médicaments', style: secondaryTextStyle(size: 12, color: white.withOpacity(0.4))),
                    (widget.index == 0)
                        ? Text('>', style: secondaryTextStyle(size: 12, color: white.withOpacity(0.4)))
                        : Text('>', style: secondaryTextStyle(size: 12, color: white.withOpacity(0.3))),
                  ],
                ).paddingLeft(8.0),
              ],
            ).paddingAll(16.0),
            data[widget.index!].validate().flexible(),
          ],
        ),
      ),
    );
  }
}
