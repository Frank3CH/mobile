import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ESMV_STORE/utils/MLColors.dart';
import 'package:ESMV_STORE/utils/MLCommon.dart';
import 'package:ESMV_STORE/main.dart';
import 'package:ESMV_STORE/components/MLCommandeDetailList.dart';
import 'package:provider/provider.dart';
import 'package:ESMV_STORE/providers/order_provider.dart';

class MLCommandeDetailScreen extends StatefulWidget {
  static String tag = '/MLCommandeDetailScreen';
  final int orderId;

  MLCommandeDetailScreen({required this.orderId});

  @override
  MLCommandeDetailScreenState createState() => MLCommandeDetailScreenState();
}

class MLCommandeDetailScreenState extends State<MLCommandeDetailScreen> {
  late Future<void> fetchOrderDetails;
  late OrderProvider orderProvider;

  @override
  void initState() {
    super.initState();
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    fetchOrderDetails = orderProvider.fetchOrderDetails(widget.orderId);
  }

  Future<void> acceptOrder() async {
    try {
      final orderDetails = orderProvider.orderDetails;
      if (orderDetails != null) {
        // Préparer la liste des mises à jour de produits
        final productUpdates = orderDetails['products'].map<Map<String, dynamic>>((product) {
          return {
            'product_id': product['product_id'],
            'quantity': product['quantity'],
          };
        }).toList();

        // Appeler la nouvelle méthode pour valider la commande avec les quantités
        await orderProvider.validateOrderWithQuantities(widget.orderId, productUpdates);
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la validation de la commande')),
      );
    }
  }

  Future<void> rejectOrder() async {
    try {
      await orderProvider.rejectOrder(widget.orderId);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du rejet de la commande')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Container(
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: radiusOnly(topRight: 32),
            backgroundColor: appStore.isDarkModeOn ? black : white,
          ),
          child: Column(
            children: [
              8.height,
              Row(
                children: [
                  mlBackToPreviousWidget(
                      context,
                      appStore.isDarkModeOn ? white : blackColor
                  ),
                  8.width,
                  Text('Commande', style: boldTextStyle(size: 22)),
                ],
              ).paddingAll(16),
              Consumer<OrderProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return CircularProgressIndicator().center();
                  }

                  final orderDetails = provider.orderDetails;
                  if (orderDetails == null) {
                    return Text('Aucune commande trouvée').center();
                  }

                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: MLCommandeDetailList(
                            orderDetails: orderDetails,
                          ),
                        ),
                        if (orderDetails['status'] == 'en attente') ...[
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: acceptOrder,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                    child: Text('Accepter',
                                        style:primaryTextStyle(color: Colors.white, size: 16)),
                                  ),
                                ),
                                16.width,
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: rejectOrder,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: Text('Rejeter',
                                        style:primaryTextStyle(color: Colors.white, size: 16)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else if (orderDetails['status'] == 'Validé')
                          Container(
                            padding: EdgeInsets.all(16),
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: acceptOrder,
                              child: Text('Marquer comme Terminé'),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}