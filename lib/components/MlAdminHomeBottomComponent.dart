import 'package:ESMV_STORE/main.dart';
import 'package:ESMV_STORE/screens/MlOrdersScreen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class MlAdminHomeBottomComponent extends StatefulWidget {
  @override
  _MlAdminHomeBottomComponentState createState() => _MlAdminHomeBottomComponentState();
}

class _MlAdminHomeBottomComponentState extends State<MlAdminHomeBottomComponent> {
  List<Map<String, dynamic>> data = <Map<String, dynamic>>[
    {'name': 'Commandes en attente', 'icon': Icons.hourglass_empty, 'orderType': 'Commande en attente'},
    {'name': 'Commandes validées (livraison en cours)', 'icon': Icons.check_circle, 'orderType': 'Commande validée'},
    {'name': 'Commandes refusées', 'icon': Icons.cancel, 'orderType': 'Commande refusée'},
    {'name': 'Commandes Terminées', 'icon': Icons.check_box_sharp, 'orderType': 'Commande terminée'},
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
          Flexible(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 11,
                mainAxisSpacing: 11,
              ),
              itemBuilder: (BuildContext context, int index) {
                var item = data[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(

                        builder: (context) => MLOrdersScreen(orderType: item['orderType']),
                      ),
                    );
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
                          height: width / 6,
                          width: width / 6,
                          margin: EdgeInsets.only(bottom: 4, top: 8),
                          padding: EdgeInsets.all(width / 30),
                          decoration: BoxDecoration(
                            color: context.cardColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Icon(item['icon'], size: 50, color: Colors.blue),
                        ),
                        Text(
                          item['name'],
                          style: secondaryTextStyle(size: 14),
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
