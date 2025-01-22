import 'package:esmv_store/main.dart';
import 'package:esmv_store/screens/MLUserCommandsScreen.dart';
import 'package:esmv_store/utils/MLImage.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:esmv_store/screens/MLOnlinePharmacyDetailScreen.dart';
import 'package:esmv_store/screens/TransactionHistoryScreen.dart';

class MLPharmacyCategoriesComponent extends StatefulWidget {
  static String tag = '/MLPharmacyCategoriesComponent';

  @override
  MLPharmacyCategoriesComponentState createState() => MLPharmacyCategoriesComponentState();
}

class MLPharmacyCategoriesComponentState extends State<MLPharmacyCategoriesComponent> {


  final List<Map<String, dynamic>> screens = [
    {
      'name': 'Passer une commande',
      'icon': ml_prescription1,
      'screen': (context) => MLOnlinePharmacyDetailScreen(index: 0, selectedCategoryId: 1),
    },
    {
      'name': 'Détails Solde Comptable',
      'icon': ml_prescription3,
      'screen': (context) => TransactionHistoryScreen(),
    },
    {'name': 'Commandes en attentes', 'icon': ml_document_wait, 'screen': (context) => MLUserCommandsScreen(status:'en attente')},
    {'name': 'Commandes validées (livraison en cours)', 'icon': ml_document_valid, 'screen': (context) => MLUserCommandsScreen(status:'Validé')},
    {'name': 'Commandes refusées', 'icon': ml_document_rejected, 'screen': (context) => MLUserCommandsScreen(status:'refusé')},
    {'name': 'Commandes terminées', 'icon': ml_document_final, 'screen': (context) => MLUserCommandsScreen(status:'terminé')},
  ];



  @override
  Widget build(BuildContext context) {
    var width = context.width();

    return Container(
      height: MediaQuery.of(context).size.height - kToolbarHeight - kBottomNavigationBarHeight,
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radiusOnly(topRight: 32),
        backgroundColor: appStore.isDarkModeOn ? black : white,
      ),
      child: Column(
        children: [
          16.height,
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: screens.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (BuildContext context, int index) {
                var screenData = screens[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: screenData['screen']));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: white,
                      boxShadow: defaultBoxShadow(),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: width / 7,
                          width: width / 7,
                          margin: EdgeInsets.only(bottom: 8, top: 8),
                          padding: EdgeInsets.all(width / 30),
                          decoration: BoxDecoration(
                            color: context.cardColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Image.asset(
                            screenData['icon'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          screenData['name'],
                          style: secondaryTextStyle(size: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
