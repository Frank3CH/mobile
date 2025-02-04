import 'package:esmv_store/l10n/gen/app_localizations.dart';
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
      MLOrderSuccessData(title: '${AppLocalizations.of(context)!.orderref} :', data: '#${order['ref']}'),
      MLOrderSuccessData(title: '${AppLocalizations.of(context)!.date} :', data: '#${order['dateCreation']}'),
      MLOrderSuccessData(title: '${AppLocalizations.of(context)!.statut}:', data: '#${order['status']}'),
      MLOrderSuccessData(title: '${AppLocalizations.of(context)!.ordercreator}:', data: '#${order['pharmacien']['userIdentifier']}')
    ];

    double totalPrice = double.parse(order['totalPrice']);

    return Scaffold(
      appBar: AppBar(
        title: Text('${AppLocalizations.of(context)!.orderconf}'),
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
        child: Text('${AppLocalizations.of(context)!.backhome}', style: boldTextStyle(color: white)),
      ).paddingAll(20),
    );
  }
}
