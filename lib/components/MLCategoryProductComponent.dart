import 'package:flutter/material.dart';
import 'package:ESMV_STORE/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ESMV_STORE/components/MLPharmacyProductComponent.dart';
import 'package:provider/provider.dart';
import 'package:ESMV_STORE/providers/product_provider.dart';

class MLCategoryProductComponent extends StatelessWidget {
  final int? categoryId;

  MLCategoryProductComponent({this.categoryId}) {
    print('MLCategoryProductComponent created with categoryId: $categoryId');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radiusOnly(topRight: 32),
        backgroundColor: appStore.isDarkModeOn ? black : white,
      ),
      child: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,
              Expanded(
                child: MLPharmacyProductComponent(
                  categoryId: categoryId,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
