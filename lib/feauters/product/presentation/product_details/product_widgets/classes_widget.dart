// ignore_for_file: must_be_immutable

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:merchant_app/feauters/product/presentation/product_details/product_widgets/pair_widget.dart';
import '../../../../../core/components/button.dart';
import '../../../../../core/components/default_label.dart';
import '../../../../../core/components/my_page_view.dart';
import '../../../../../core/components/my_text.dart';

import '../../../../../core/components/text_form_field.dart';
import '../../../../../core/components/toast_notifications.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/fonts_manager.dart';
import '../../../../../core/resources/string_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../domin/product_details/product_models/single_pro_model.dart';
import '../../update_product/update_product_cubit/update_product_cubit.dart';
import '../product_details_cubit/product_cubit.dart';

class ClassesWidget extends StatefulWidget {
  const ClassesWidget({
    Key? key,
    this.proClasses,
    this.proId,
  }) : super(key: key);

  final List<SingleProClass>? proClasses;
  final String? proId;

  @override
  State<ClassesWidget> createState() => _ClassesWidgetState();
}

class _ClassesWidgetState extends State<ClassesWidget> {
  var formKey1 = GlobalKey<FormState>();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productSizeController = TextEditingController();
  TextEditingController productLengthController = TextEditingController();
  TextEditingController productWidthController = TextEditingController();
  double classesHeight = AppSize.s150;

  var classPageController = PageController();

  int groupSelectedIndex = 0;
  String? groupId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DefaultLabel(text: AppStrings.classes),
            MyPageView(
              height: 280.0,
              controller: classPageController,
              pageWidget: (context, index) => buildClassItem(index),
              itemCount: widget.proClasses?.length ?? 0,
            ),
          ],
        );
      },
    );
  }

  Widget  buildClassItem(index) {
    return Card(
      margin: const EdgeInsetsDirectional.all(AppMargin.m8),
      child: Container(
        decoration: getDeco(withShadow: true, color: ColorManager.white),
        margin: const EdgeInsetsDirectional.all(AppMargin.m8),
        padding: const EdgeInsetsDirectional.all(AppPadding.p12),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Stack(alignment: AlignmentDirectional.topEnd, children: [
              IconButton(
                onPressed: () {
                  productPriceController.text =
                      widget.proClasses![index].price.toString();
                  productWidthController.text =
                      widget.proClasses![index].width.toString();
                  productLengthController.text =
                      widget.proClasses![index].length.toString();
                  productSizeController.text =
                      widget.proClasses![index].size.toString();
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: getScreenHeight(context) / 1.15,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(AppPadding.p16),
                              child: Text(
                                'Insert new Class Info',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Expanded(
                              child: buildFieldsOfClassInfo(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(AppPadding.p16),
                              child: BlocConsumer<UpdateProductCubit,
                                  UpdateProductState>(
                                listener: (context, state) {
                                  if (state is UpdateProductInfoDoneState) {
                                    setState(() {
                                      ProductCubit().getSinglePro(
                                          proId: widget.proId!);
                                    });
                                    showToast(
                                        text: 'Updating Done',
                                        state: ToastStates.SUCCESS);
                                  }
                                },
                                builder: (context, state) {
                                  return DefaultButton(
                                      function: () {
                                        UpdateProductCubit.get(context).updateClassInfo(
                                          priceProduct: int.parse(productPriceController.text),
                                          lengthProduct: int.parse(productLengthController.text),
                                          widthProduct: int.parse(productWidthController.text),
                                          sizeProduct: productSizeController.text,
                                          classId: widget.proClasses![index].id!,
                                        );
                                      },
                                      text: 'Update ClassInfo');
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: ColorManager.black,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.proClasses?[index].priceAfterDiscount != null
                      ? offerWidget(
                          price1: widget.proClasses?[index].price.toString(),
                          price2: widget.proClasses?[index].priceAfterDiscount
                              .toString(),
                        )
                      : PairWidget(
                          label: AppStrings.classPrice,
                          value: widget.proClasses?[index].price.toString(),
                          notTR: true,
                        ),
                  PairWidget(
                    label: AppStrings.classSize,
                    value: widget.proClasses?[index].size,
                    notTR: true,
                  ),
                  PairWidget(
                    label: AppStrings.classLength,
                    value: widget.proClasses?[index].length.toString(),
                    notTR: true,
                  ),
                  PairWidget(
                    label: AppStrings.classWidth,
                    value: widget.proClasses?[index].width.toString(),
                    notTR: true,
                  ),
                  colorsWidget(widget.proClasses?[index].group, index),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget colorsWidget(List<SingleProGroup>? groups, classIndex) {
    groupId = groups?[groupSelectedIndex].id;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppPadding.p8, vertical: AppPadding.p8),
      child: SizedBox(
        height: 40.0,
        child: Row(
          children: [
            MText(
              text: AppStrings.existColors,
              color: ColorManager.black,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Conditional.single(
                  context: context,
                  conditionBuilder: (context) => index == groupSelectedIndex,
                  widgetBuilder: (context) {
                    return Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: AppPadding.p4),
                      child: DottedBorder(
                        color: ColorManager.darkPrimary,
                        borderPadding: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(AppSize.s4),
                        child: buildColorItem(index, groups),
                      ),
                    );
                  },
                  fallbackBuilder: (context) {
                    return buildColorItem(index, groups);
                  },
                ),
                itemCount: widget.proClasses?[classIndex].group.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildColorItem(int index, List<SingleProGroup>? groups) {
    return GestureDetector(
      onTap: () {
        setState(() {
          groupSelectedIndex = index;
          groupId = groups?[index].id;
        });
      },
      child: Container(
        height: 30.0,
        width: 30.0,
        margin: const EdgeInsetsDirectional.all(AppMargin.m4),
        decoration: BoxDecoration(
          color: getRandomColor(),
          borderRadius: BorderRadiusDirectional.circular(AppSize.s4),
        ),
      ),
    );
  }

  Widget offerWidget({
    required String? price1,
    required String? price2,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppPadding.p8, vertical: AppPadding.p4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: MText(
              text: AppStrings.offers,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: getMediumStyle(
                color: ColorManager.black,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(
              start: AppMargin.m4,
              end: AppMargin.m8,
            ),
            width: 2.0,
            height: 14.0,
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadiusDirectional.circular(AppSize.s4),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  price1 ?? '',
                  style: const TextStyle(
                    fontSize: AppSize.s12,
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 2.85,
                    color: ColorManager.error,
                    fontWeight: FontWeightManager.light,
                  ),
                ),
                const SizedBox(width: AppSize.s8),
                Text(
                  price2 ?? '',
                  style: const TextStyle(
                    fontSize: AppSize.s18,
                    color: ColorManager.success,
                    fontWeight: FontWeightManager.extraBold,
                  ),
                ),
                const SizedBox(width: AppSize.s4),
                MText(
                  text: AppStrings.sp,
                  textAlign: TextAlign.center,
                  style: getMediumStyle(
                    color: ColorManager.darkPrimary,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildFieldsOfClassInfo() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Form(
        key: formKey1,
        child: Column(
          children: [
            TFF(
              controller: productPriceController,
              label: 'price',
              prefixIcon: Icons.attach_money_outlined,
              keyboardType: TextInputType.number,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'price Must not be empty';
                }
              },
            ),
            const SizedBox(
              height: AppSize.s8,
            ),
            TFF(
              controller: productSizeController,
              label: 'Size',
              prefixIcon: Icons.attach_money_outlined,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Size Must not be empty';
                }
              },
            ),
            const SizedBox(
              height: AppSize.s8,
            ),
            TFF(
              controller: productLengthController,
              label: 'Length',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.attach_money_outlined,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Length Must not be empty';
                }
              },
            ),
            const SizedBox(
              height: AppSize.s8,
            ),
            TFF(
              controller: productWidthController,
              label: 'Width',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.attach_money_outlined,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Width Must not be empty';
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
