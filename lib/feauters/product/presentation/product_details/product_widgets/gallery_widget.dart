
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/feauters/product/presentation/product_details/product_widgets/video_widget.dart';

import '../../../../../core/components/default_image.dart';
import '../../../../../core/components/my_page_view.dart';
import '../../../../../core/config/urls.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../product_details_cubit/product_cubit.dart';



class GalleryWidget extends StatelessWidget {
  GalleryWidget({
    Key? key,
    required this.mainImageUrl,
  }) : super(key: key);

  final String? mainImageUrl;

  final PageController galleryController = PageController();

  final double galleryHeight = AppSize.s260;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ProductCubit cubit = ProductCubit.get(context);
        if (state is GetProductGalleryDoneState || cubit.gallery.isNotEmpty) {
          return MyPageView(
            controller: galleryController,
            height: galleryHeight,
            pageWidget: (context, index) {
              if (index == 0) {
                return buildMainImage(context);
              } else if (index == cubit.gallery.length + 1 &&
                  cubit.videoUrl.isNotEmpty) {
                return Container(); /*VideoWidget(
                  videoUrl: cubit.videoUrl,
                );*/
              } else {
                return Hero(
                  tag: Urls.filesUrl + (cubit.gallery[index - 1] ?? ''),
                  child: DefaultImage(
                    imageUrl: cubit.gallery[index - 1],
                    clickable: true,
                    height: galleryHeight,
                  ),
                );
              }
            },
            itemCount: (cubit.videoUrl.isNotEmpty ? 1 : 0) +
                (1 + cubit.gallery.length),
          );
        } else {
          return buildMainImage(context);
        }
      },
    );
  }

  Widget buildMainImage(context) {
    return Hero(
      tag: mainImageUrl ?? '',
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          DefaultImage(
            imageUrl: mainImageUrl,
            clickable: true,
            fit: BoxFit.cover,
            height: galleryHeight,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              margin: const EdgeInsetsDirectional.all(AppMargin.m8),
              height: 40.0,
              width: 40.0,
              decoration: getDeco(withShadow: true, borderSize: AppSize.s8),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: ColorManager.white,
                  size: AppSize.s25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
