import 'package:esmv_store/l10n/gen/app_localizations.dart';
import 'package:esmv_store/utils/MLImage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:esmv_store/utils/MLCommon.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:esmv_store/utils/MLColors.dart';
import 'package:esmv_store/providers/cart_provider.dart';

class MLShoppingCartComponent extends StatefulWidget {
  static String tag = '/MLShoppingCartComponent';

  @override
  MLShoppingCartComponentState createState() => MLShoppingCartComponentState();
}

class MLShoppingCartComponentState extends State<MLShoppingCartComponent> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Column(
      children: cartProvider.cart.items.map((item) {
        TextEditingController quantityController = TextEditingController(
          text: item.quantity.toString(),
        );

        return Container(
          decoration: boxDecorationRoundedWithShadow(8, backgroundColor: context.cardColor),
          child: Column(
            children: [
              16.height,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.width,
                  commonCachedNetworkImage(
                    ml_ic_mediIconTwo,
                    height: 100,
                    width: 70,
                    fit: BoxFit.cover,
                  ).cornerRadiusWithClipRRect(8.0),
                  12.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.product.name,
                          style: boldTextStyle(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        4.height,
                        Row(
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.price} : ',
                              style: boldTextStyle(size: 16, color: Colors.black),
                            ),
                            Text(
                              '${item.product.price} MRU',
                              style: boldTextStyle(size: 14, color: mlColorBlue),
                            ),
                          ],
                        ),
                        4.height,
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: boxDecorationWithRoundedCorners(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      backgroundColor: context.cardColor,
                    ),
                    child: Row(
                      children: [
                        Tooltip(
                          message: AppLocalizations.of(context)!.reduceQuantity,
                          child: Icon(Icons.remove, size: 20)
                              .onTap(() {
                            int currentQuantity = int.parse(quantityController.text);
                            if (currentQuantity > 1) {
                              int newQuantity = currentQuantity - 1;
                              quantityController.text = newQuantity.toString();
                              cartProvider.updateItemQuantity(item.product, newQuantity);
                            }
                          }),
                        ),
                        8.width,
                        SizedBox(
                          width: 50,
                          child: TextField(
                            controller: quantityController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              isDense: true,
                            ),
                            onSubmitted: (value) {
                              int? newQuantity = int.tryParse(value);
                              if (newQuantity != null &&
                                  newQuantity > 0 &&
                                  newQuantity <= item.product.quantity) {
                                cartProvider.updateItemQuantity(item.product, newQuantity);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      newQuantity == null
                                          ? AppLocalizations.of(context)!.invalidQuantity
                                          : AppLocalizations.of(context)!.quantityNotAvailable(item.product.quantity.toString()),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                quantityController.text = item.quantity.toString();
                              }
                            },
                          ),
                        ),
                        8.width,
                        Tooltip(
                          message: AppLocalizations.of(context)!.increaseQuantity,
                          child: Icon(Icons.add, size: 20)
                              .onTap(() {
                            int currentQuantity = int.parse(quantityController.text);
                            if (currentQuantity < item.product.quantity) {
                              int newQuantity = currentQuantity + 1;
                              quantityController.text = newQuantity.toString();
                              cartProvider.updateItemQuantity(item.product, newQuantity);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    AppLocalizations.of(context)!.maxStockReached(item.product.quantity.toString()),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              16.height,
              // Full-width delete button
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(AppLocalizations.of(context)!.confirmDeletion),
                        content: Text(AppLocalizations.of(context)!.confirmDeletionMessage),
                        actions: [
                          TextButton(
                            child: Text(AppLocalizations.of(context)!.cancel),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: Text(
                              AppLocalizations.of(context)!.delete,
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              cartProvider.removeFromCart(item.product);
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)!.itemRemoved),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete_outline, color: Colors.red, size: 20),
                      8.width,
                      Text(
                        AppLocalizations.of(context)!.deleteItem,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).paddingBottom(16.0),
        );
      }).toList(),
    ).paddingOnly(top: 16, right: 16, left: 16, bottom: 70);
  }
}