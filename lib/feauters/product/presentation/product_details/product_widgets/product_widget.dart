import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/default_image.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../domin/product_details/product_models/products_list_model.dart';
import '../details_screen.dart';


class ProductWidget extends StatelessWidget {
  const ProductWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          DetailsScreen(
            proId: product?.id,
            mainImageUrl: product?.mainImage,
          ),
        );
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            margin:
                 const EdgeInsetsDirectional.symmetric(horizontal: AppMargin.m8),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            height: AppSize.s200,
            width: double.infinity,
            decoration: getDeco(borderSize: AppSize.s8),
            child: Hero(
              tag: product?.mainImage ?? 'Details',
              child: DefaultImage(imageUrl: product?.mainImage),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: AppPadding.p4,
              end: AppPadding.p8,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.heart,
                color: ColorManager.darkPrimary,
                size: AppSize.s40,
              ),
            ),
          )
        ],
      ),
    );
  }
}
