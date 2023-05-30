import 'package:flutter/material.dart';
import '../../../core/components/my_divider.dart';
import '../../../core/functions.dart';
import '../../../core/resources/color_manager.dart';
import '../../feauters/home/domin/response/get_merchant_response.dart';
import '../../feauters/home/presentation/home_cubit/widget_home_screen/add_dialog.dart';
import '../../feauters/product/domin/add_product/response/add_image_response.dart';
import '../../feauters/product/presentation/add_offer_to_product/add_offer_to_product_screen.dart';



class MyListView extends StatelessWidget {
  final List<Products> products;
  final bool isSelectionMode;
  final Set<int> selectedIndices;
  final Function(int) onProductSelected;

  const MyListView({
    Key? key,
    required this.products,
    this.isSelectionMode = false,
    this.selectedIndices = const {},
    required this.onProductSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        var product = products[index];
        return Column(
          children: [
            ListTile(
              title: Text('${product.name}'),
              subtitle: Text('${product.name}'),
              leading: const Icon(Icons.photo),
              trailing: isSelectionMode
                  ? Checkbox(
                value: selectedIndices.contains(index),
                onChanged: (value) {
                  onProductSelected(index);
                },
              )
                  : buildPopupMenuButton(context, index),
              onTap: () {
                if (isSelectionMode) {
                  onProductSelected(index);
                }
              },
              onLongPress: () {
                onProductSelected(index);
              },
              selected: isSelectionMode && selectedIndices.contains(index),
            ),
            MyDivider(
              margin: 8.0,
              width: getScreenWidth(context) / 1.2,
              alignment: AlignmentDirectional.centerStart,
              color: ColorManager.lightPrimary,
            ),
          ],
        );
      },
    );
  }

  Widget buildPopupMenuButton(BuildContext context, int index) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) =>
      <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'option1',
          child: Text('edit'),
        ),
        const PopupMenuItem<String>(
          value: 'option2',
          child: Text('add offer'),
        ),
        const PopupMenuItem<String>(
          value: 'option3',
          child: Text('add to hot Selling'),
        ),
      ],
      onSelected: (String result) {
        switch (result) {
          case 'option2':
            navigateTo(
                context,
                AddOfferToProductScreen(
                  productsIds: [products[index].sId!],
                ));
            break;
          case 'option3':
            addToHotSelling(products[index].sId!, context);
            break;
          default:
          // Do something whenan option is selected
            break;
        }
      },
    );
  }

  Future<void> addToHotSelling(String productId, BuildContext context) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AddDialogHotSelling(
          productId: productId,
        );
      },
    );
  }
}