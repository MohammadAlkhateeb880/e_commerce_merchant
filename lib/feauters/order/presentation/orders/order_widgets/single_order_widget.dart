import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/default_image.dart';
import '../../../../../core/components/my_text.dart';
import '../../../../../core/components/pair_widget.dart';
import '../../../../../core/components/price_widget.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/string_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../order/domin/response/single_order_response.dart';


class SingleOrderWidget extends StatelessWidget {
  const SingleOrderWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final SingleOrderData? data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildMainDetailsAboutOrder(),
          buildItemsOfOrder(),
        ],
      ),
    );
  }

  Widget buildMainDetailsAboutOrder() {
    return Container(
      margin:  const EdgeInsetsDirectional.all(AppMargin.m8),
      padding: const EdgeInsetsDirectional.all(AppPadding.p12),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadiusDirectional.circular(AppSize.s8),
        boxShadow: const [
          BoxShadow(
            color: ColorManager.grey,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PairWidget(
            label: AppStrings.totalPrice,
            value: data!.totalPrice.toString() + AppStrings.sp,
            notTR: true,
          ),
          PairWidget(
            label: AppStrings.orderStatus,
            value: data?.status,
            notTR: true,
          ),
          PairWidget(
            label: AppStrings.paymentMethod,
            value: data?.paymentMethod,
            notTR: true,
          ),
          PairWidget(
            label: AppStrings.paymentStatus,
            value: data?.paymentStatus,
            notTR: true,
          ),
        ],
      ),
    );
  }

  Widget buildItemsOfOrder() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return buildItemWidget(item: data?.items[index], context: context);
      },
      itemCount: data?.items.length,
    );
  }

  Widget buildItemWidget({
    required SingleOrderItem? item,
    required BuildContext context,
  }) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          margin: const EdgeInsetsDirectional.all(AppMargin.m8),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadiusDirectional.circular(AppSize.s8),
            boxShadow: const [
              BoxShadow(
                color: ColorManager.grey,
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DefaultImage(
                imageUrl: item?.singleProduct?.product?.mainImage ?? '',
                height: AppSize.s200,
                clickable: true,
              ),
              const SizedBox(height: AppSize.s8),
              MText(
                text: item?.singleProduct?.product?.name ?? '',
                color: ColorManager.black,
                notTR: true,
              ),
              const SizedBox(height: AppSize.s4),
              priceWidget(
                price: item?.price.toString() ?? '',
              ),
              PairWidget(
                label: AppStrings.fromMerchant,
                value: item?.singleProduct?.ownerProduct?.fullName ?? '',
              ),
              PairWidget(
                label: AppStrings.color,
                value: item?.singleProduct?.group?.color ?? '',
                notTR: true,
              ),
              PairWidget(
                label: AppStrings.classSize,
                value: item?.singleProduct?.singleProductClass?.size ?? '',
                notTR: true,
              ),
              PairWidget(
                label: AppStrings.classLength,
                value: item?.singleProduct?.singleProductClass?.length
                        .toString() ??
                    '',
                notTR: true,
              ),
              PairWidget(
                label: AppStrings.classWidth,
                value:
                    item?.singleProduct?.singleProductClass?.width.toString() ??
                        '',
                notTR: true,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(
            end: AppPadding.p8,
            bottom: AppPadding.p8,
          ),
          child: IconButton(
            onPressed: () {
              // navigateTo(
              //   context,
              //   DetailsScreen(
              //     proId: item?.singleProduct?.product?.id ?? '',
              //     mainImageUrl: item?.singleProduct?.product?.mainImage ?? '',
              //   ),
              // );
            },
            icon: const Icon(
              CupertinoIcons.info_circle,
              color: ColorManager.darkPrimary,
              size: AppSize.s30,
            ),
          ),
        ),
      ],
    );
  }
}
