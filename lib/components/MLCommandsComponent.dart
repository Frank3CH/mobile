import 'package:flutter/material.dart';
import 'package:ESMV_STORE/screens/MLCommandeDetailScreen.dart';
import 'package:nb_utils/nb_utils.dart';

class MLCommandsComponent extends StatelessWidget {
  final List<dynamic> orders;

  MLCommandsComponent({required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - kToolbarHeight - kBottomNavigationBarHeight,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          final orderId = order['id'];
          final pharmacien = order['pharmacien'];
          final orderRef = order['ref'];
          final orderStatus = order['status'];
          final totalPrice = order['total_price'];

          return Container(
            margin: EdgeInsets.only(bottom: 5),
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              backgroundColor: context.cardColor,
            ),
            child: ListTile(
              title: Text(
                'Commande #$orderRef',
                style: boldTextStyle(size: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Statut: $orderStatus   CLIENT : $pharmacien',
                    style: secondaryTextStyle(size: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Prix total: ${totalPrice.toString()} MRU',
                    style: boldTextStyle(size: 14, color: Colors.blue),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MLCommandeDetailScreen(orderId: orderId),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
