import 'package:flutter/material.dart';

import '../../feauters/home/presentation/home_cubit/home_cubit.dart';
import '../../feauters/product/presentation/add_ar_product/add_ar_product_screen.dart';
import '../../feauters/product/presentation/add_delivery_areas/add_delivery_areas_screen.dart';
import '../../feauters/product/presentation/add_image_product/add_image_product_screen.dart';
import '../../feauters/product/presentation/add_offer_to_product/add_offer_to_product_screen.dart';
import '../../feauters/product/presentation/add_vedio_product/add_video_product_screen.dart';
import '../../feauters/product/presentation/add_vr_product/add_vr_product_screen.dart';
import '../functions.dart';
import 'add_to_hot_selling.dart';

Widget buildPopupMenuButton(BuildContext context, int index) {
  return PopupMenuButton<String>(
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      const PopupMenuItem<String>(
        value: 'option1',
        child: Text('add images'),
      ),
      const PopupMenuItem<String>(
        value: 'option2',
        child: Text('add video'),
      ),
      const PopupMenuItem<String>(
        value: 'option3',
        child: Text('Add VR'),
      ),
      const PopupMenuItem<String>(
        value: 'option4',
        child: Text('add AR'),
      ),
      const PopupMenuItem<String>(
        value: 'option5',
        child: Text('add Delivery Areas'),
      ),
      const PopupMenuItem<String>(
        value: 'option6',
        child: Text('add offer'),
      ),
      const PopupMenuItem<String>(
        value: 'option7',
        child: Text('add to Hot Selling'),
      ),
    ],
    onSelected: (String result) {
      switch (result) {
        case 'option1':
          navigateTo(
              context,
              AddImageProductScreen(
                idProduct: HomeCubit.get(context).products[index].sId!,
              ));
          break;
        case 'option2':
          navigateTo(
              context,
              AddVideoProductScreen(
                idProduct: HomeCubit.get(context).products[index].sId!,
              ));
          break;
        case 'option3':
          navigateTo(
              context,
              AddVRProductScreen(
                idProduct: HomeCubit.get(context).products[index].sId!,
              ));
          break;
        case 'option4':
          navigateTo(
              context,
              AddARProductScreen(
                idProduct: HomeCubit.get(context).products[index].sId!,
              ));
          break;
        case 'option5':
          navigateTo(
              context,
              AddDeliveryAreasScreen(
                idProduct: HomeCubit.get(context).products[index].sId!,
              ));
          break;
        case 'option6':
          navigateTo(
              context,
              AddOfferToProductScreen(
                productsIds: [HomeCubit.get(context).products[index].sId!],
              ));
          break;
        case 'option7':
          addToHotSelling(context, HomeCubit.get(context).products[index].sId!);
          break;
        default:
          // Do something when an option is selected
          break;
      }
    },
  );
}
