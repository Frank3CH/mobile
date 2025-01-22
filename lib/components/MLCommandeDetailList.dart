import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:esmv_store/utils/MLColors.dart';

class MLCommandeDetailList extends StatefulWidget {
  final Map<String, dynamic> orderDetails;

  MLCommandeDetailList({required this.orderDetails});

  @override
  MLCommandeDetailListState createState() => MLCommandeDetailListState();
}
class MLCommandeDetailListState extends State<MLCommandeDetailList> {
  late Map<String, dynamic> orderDetails;

  @override
  void initState() {
    super.initState();
    orderDetails = widget.orderDetails;
    print(widget.orderDetails);
  }

  void updateQuantity(int index, int newQuantity) {
    if (newQuantity >= 0 && newQuantity <= orderDetails['products'][index]['available_quantity']) {
      setState(() {
        orderDetails['products'][index]['quantity'] = newQuantity;
        calculateTotalPrice();
      });
    }
  }

  void calculateTotalPrice() {
    double total = 0;
    for (var product in orderDetails['products']) {
      total += (product['quantity'] * product['price']);
    }
    setState(() {
      orderDetails['total_price'] = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isPending = orderDetails['status'] == 'en attente';

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: boxDecorationWithRoundedCorners(
          border: Border.all(color: mlColorLightGrey),
          borderRadius: radius(12),
          backgroundColor: context.cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(orderDetails['ref'].toString(),
                style: boldTextStyle()
            ),
            16.height,
            Divider(thickness: 0.5),
            16.height,
            ...orderDetails['products'].map<Widget>((product) {
              int index = orderDetails['products'].indexOf(product);
              return Container(
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: mlColorLightGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product['name'].toString(),
                        style: primaryTextStyle(color: mlColorDarkBlue, size: 16)
                    ),
                    8.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'Stock disponible: ${product['available_quantity']}',
                            style: secondaryTextStyle()
                        ),
                        if (isPending)
                          Container(
                            width: 100,
                            child: TextFormField(
                              initialValue: product['quantity'].toString(),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 0
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onChanged: (value) {
                                final newQuantity = int.tryParse(value);
                                if (newQuantity != null) {
                                  updateQuantity(index, newQuantity);
                                }
                              },
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                    'Total: ${orderDetails['total_price'].toString()} €',
                    style: boldTextStyle(color: mlColorDarkBlue, size: 18)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
