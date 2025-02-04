import 'package:esmv_store/l10n/gen/app_localizations.dart';
import 'package:esmv_store/providers/auth_provider.dart';
import 'package:esmv_store/screens/MLAddToCartScreen.dart';
import 'package:esmv_store/screens/MLDashboardScreen.dart';
import 'package:esmv_store/screens/MLSearchScreen.dart';
import 'package:esmv_store/utils/MLColors.dart';
import 'package:esmv_store/utils/MLCommon.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:esmv_store/providers/order_provider.dart';

class TransactionHistoryScreen extends StatefulWidget {


  TransactionHistoryScreen();

  @override
  _TransactionHistoryScreenState createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  late Future<void> _factures;

  @override
  void initState() {
    super.initState();
    _factures =
        Provider.of<OrderProvider>(context, listen: false).loadFactures();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                mlBackToPreviousWidget(context, white),
                8.width,
                Text('${AppLocalizations.of(context)!.detsoldecomptable}',
                    style: boldTextStyle(color: whiteColor, size: 20)).expand(),
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
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: boxDecorationWithRoundedCorners(
                            backgroundColor: mlColorRed),
                        constraints: BoxConstraints(
                            minWidth: 12, minHeight: 12),
                        child: Text(
                          '0'.toString(),
                          style: boldTextStyle(size: 8, color: white),
                          textAlign: TextAlign.center,
                        ),
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
          ),
        ),
        body: FutureBuilder<void>(
          future: _factures,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Failed to load transactions',
                  style: boldTextStyle(color: white)));
            } else {
              final orderProvider = Provider.of<OrderProvider>(context);
              return Column(
                children: [
                  Row(
                    children: [
                      Text('Solde :', style: boldTextStyle(
                          size: 20, color: Colors.white))
                          .paddingLeft(80)
                          .expand(),
                      Text(authProvider.userProfile?.solde ?? '0.0',
                          style: secondaryTextStyle(
                              size: 16, color: Colors.white)).paddingRight(80),
                    ],
                  ).paddingAll(8.0),
                  8.height,
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: orderProvider.factures.length,
                        itemBuilder: (context, index) {
                          final facture = orderProvider.factures[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: boxDecorationWithRoundedCorners(
                              borderRadius: radius(12),
                              border: Border.all(color: mlColorLightGrey),
                              backgroundColor: context.cardColor,
                            ),
                            child: ListTile(
                              title: Text('Facture #${facture.pvcnum}',
                                  style: boldTextStyle(color: Colors.black)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${AppLocalizations.of(context)!.echeance}: ${facture.soldeEcheance} MRU',
                                      style: secondaryTextStyle(
                                          color: Colors.grey[700])),
                                ],
                              ),
                              onTap: () {
                                // Add action on tap if needed
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}