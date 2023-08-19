
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:merchant_app/feauters/product/presentation/product_details/product_widgets/product_widget.dart';

import '../../../../core/components/loading.dart';
import '../../../../core/components/my_divider.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import 'merchant_layout_cubit/merchant_layout_cubit.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    Key? key,
    required this.merchantId,
  }) : super(key: key);

  final String merchantId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MerchantLayoutCubit, MerchantLayoutStates>(
      listener: (context, state) {
        if(state is GetMerchantProDoneState){

        }
        if(MerchantLayoutCubit.get(context).products.isNotEmpty){

        }
      },
      builder: (context, state) {
        MerchantLayoutCubit cubit = MerchantLayoutCubit.get(context);

        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              cubit.products.isNotEmpty || state is GetMerchantProDoneState,
          widgetBuilder: (context) {
            return Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                vertical: AppPadding.p8,
              ),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ProductWidget(
                    product: cubit.products[index],
                  );
                },
                itemCount: cubit.products.length,
                separatorBuilder: (BuildContext context, int index) {
                  return MyDivider(
                    margin: 4,
                    color: ColorManager.white,
                  );
                },
              ),
            );
          },
          fallbackBuilder: (context) => const DefaultLoading(),
        );
      },
    );
  }
}
