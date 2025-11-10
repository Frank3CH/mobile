import 'package:esmv_store/l10n/gen/app_localizations.dart';
import 'package:esmv_store/screens/MLProductDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:esmv_store/model/product.dart';
import 'package:esmv_store/providers/product_provider.dart';
import 'package:esmv_store/utils/MLColors.dart';
import 'package:esmv_store/utils/MLCommon.dart';
import 'package:esmv_store/main.dart';

class MLSearchScreen extends StatefulWidget {
  static String tag = '/MLSearchScreen';

  @override
  MLSearchScreenState createState() => MLSearchScreenState();
}

class MLSearchScreenState extends State<MLSearchScreen> {
  TextEditingController searchController = TextEditingController();
  late final Autocomplete<Product> textField;
  List<Product> data = [];
  List<String?> choice = ['None'];
  bool? selectedIndex = false;

  static String _displayStringForOption(Product option) => option.name.validate();

  @override
  void initState() {
    super.initState();
    textField = Autocomplete<Product>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.length < 3) {
          return const Iterable<Product>.empty();
        }
        return context.read<ProductProvider>().products.where(
              (Product product) {
            return product.name.toLowerCase().contains(textEditingValue.text.toLowerCase());
          },
        );
      },
      onSelected: (Product product) {
        print('You just selected ${product.name}');
      },
    );
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                mlBackToPreviousIcon(context, white),
                8.width,
                Text('${AppLocalizations.of(context)!.rechercher}', style: boldTextStyle(size: 20, color: white)).expand(),
              ],
            ).paddingAll(16.0),
            16.height,
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                width: context.width(),
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radiusOnly(topRight: 32),
                  backgroundColor: appStore.isDarkModeOn ? black : white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.search, color: mlColorBlue, size: 24).expand(flex: 1),
                        8.width,
                        Expanded(
                          flex: 13,
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: '${AppLocalizations.of(context)!.rechercherproduct}',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              if (value.length > 3) {
                                context.read<ProductProvider>().searchProducts(value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    16.height,
                    Text('Résultats', style: boldTextStyle()),
                    Expanded(
                      child: Consumer<ProductProvider>(
                        builder: (context, productProvider, child) {
                          if (productProvider.isLoading) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (productProvider.products.isEmpty) {
                            return Text('${AppLocalizations.of(context)!.noproductfound}.');
                          }
                          return ListView.separated(
                            itemCount: productProvider.products.length,
                            separatorBuilder: (context, index) => Divider(),
                            itemBuilder: (context, index) {
                              Product product = productProvider.products[index];
                              return ListTile(
                                title: Text(product.name),
                                subtitle: Text('${AppLocalizations.of(context)!.reference} :${product.ref}' , style: secondaryTextStyle(size: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
                                onTap: () {
                                  MLProductDetailScreen(productId: product.id).launch(context);
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
