import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../../../../core/components/default_label.dart';
import '../../../../../core/components/my_text.dart';
import '../../../../../core/components/price_widget.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/string_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../domin/product_details/product_models/single_pro_model.dart';



class DeliveryAreaWidget extends StatelessWidget {
  const DeliveryAreaWidget({
    Key? key,
    required this.areas,
  }) : super(key: key);

  final List<SingleProDeliveryArea>? areas;

  @override
  Widget build(BuildContext context) {
    return Conditional.single(
      context: context,
      conditionBuilder: (context) => areas != null && areas!.isNotEmpty,
      widgetBuilder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DefaultLabel(text: AppStrings.deliveryAreas),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.delivery_dining_rounded,
                      color: ColorManager.primary,
                    ),
                    title: MText(
                      text: areas?[index].location ?? '',
                      color: ColorManager.black,
                      notTR: true,
                    ),
                    trailing: priceWidget(
                      price: areas?[index].deliveryPrice.toString() ?? '',
                      fontSize: AppSize.s12,
                    ),
                  ),
                );
              },
              itemCount: areas?.length,
            ),
          ],
        );
      },
      fallbackBuilder: (context) {
        return Center(
          child: MText(
            text: 'This Product Not Available For Delivery!',
            notTR: true,
          ),
        );
      },
    );
  }
}
