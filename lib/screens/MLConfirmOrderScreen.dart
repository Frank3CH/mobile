import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:esmv_store/utils/MLColors.dart';
import 'MLDashboardScreen.dart';
import 'package:esmv_store/components/MLOrderSuccessComponent.dart';
import 'package:esmv_store/model/MLOrderSuccessData.dart';

class MLConfirmOrderScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  MLConfirmOrderScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    List<MLOrderSuccessData> orderDetails = [
      MLOrderSuccessData(title: 'Reference de Commande :', data: '#${order['ref']}'),
      MLOrderSuccessData(title: 'Date Création :', data: '#${order['dateCreation']}'),
      MLOrderSuccessData(title: 'Statut:', data: '#${order['status']}'),
      MLOrderSuccessData(title: 'Créé par:', data: '#${order['pharmacien']['userIdentifier']}')
    ];

    double totalPrice = double.parse(order['totalPrice']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Confirmation'),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return MLOrderSuccessComponent(
            orderDetails: orderDetails,
            totalPrice: totalPrice,
          );
        },
      ),
      bottomNavigationBar: AppButton(
        color: mlColorDarkBlue,
        width: context.width() / 2,
        onTap: () {
          // Navigate to the home screen
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MLDashboardScreen()),
                (Route<dynamic> route) => false,
          );
        },
        child: Text('Back Home', style: boldTextStyle(color: white)),
      ).paddingAll(20),
    );
  }
}
