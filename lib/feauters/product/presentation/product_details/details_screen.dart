import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:merchant_app/core/components/text_form_field.dart';
import 'package:merchant_app/core/components/toast_notifications.dart';
import 'package:merchant_app/feauters/product/presentation/product_details/product_details_cubit/product_cubit.dart';
import 'package:merchant_app/feauters/product/presentation/product_details/product_widgets/ar_vr_widget.dart';
import 'package:merchant_app/feauters/product/presentation/product_details/product_widgets/classes_widget.dart';
import 'package:merchant_app/feauters/product/presentation/product_details/product_widgets/delivery_area_widget.dart';
import 'package:merchant_app/feauters/product/presentation/product_details/product_widgets/gallery_widget.dart';
import 'package:merchant_app/feauters/product/presentation/product_details/product_widgets/pair_widget.dart';

import '../../../../core/components/button.dart';
import '../../../../core/components/default_label.dart';
import '../../../../core/components/my_text.dart';
import '../../../../core/components/text_button.dart';
import '../../../../core/functions.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../add_category/add_category_screen.dart';
import '../add_product/add_product_cubit/add_product_cubit.dart';
import '../update_product/update_product_cubit/update_product_cubit.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.proId,
    required this.mainImageUrl,
  }) : super(key: key);

  final String? proId;
  final String? mainImageUrl;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var formKey1 = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productGuaranteeController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();

  TextEditingController productManufacturingMaterialController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    productId = widget.proId;
  }

  String? productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()
        ..getSinglePro(proId: widget.proId ?? '')
        ..getProductGallery(proId: widget.proId ?? '')
        ..getVideoOfProduct(proId: widget.proId ?? '')
        ..getVR(proId: widget.proId ?? '')
        ..getAR(proId: widget.proId ?? ''),
      child: BlocConsumer<ProductCubit, ProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ProductCubit cubit = ProductCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: AppSize.s25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GalleryWidget(
                        mainImageUrl: widget.mainImageUrl,
                      ),
                      const SizedBox(height: AppSize.s8),
                      buildTitleWidget(cubit),
                      ClassesWidget(
                        proClasses: cubit.product.productClass,
                        proId: cubit.product.id,
                      ),
                      const SizedBox(height: AppSize.s8),
                      buildMainDescription(cubit),
                      DeliveryAreaWidget(
                        areas: cubit.product.deliveryAreas,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTitleWidget(ProductCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p8,
      ),
      child: Row(
        children: [
          Expanded(
            child: MText(
              text: cubit.product.name ?? '',
              notTR: true,
              textAlign: TextAlign.start,
              style: getMediumStyle(
                color: ColorManager.black,
                fontSize: AppSize.s18,
              ),
            ),
          ),
          Expanded(child: ArVRWidget(cubit: cubit)),
        ],
      ),
    );
  }

  Widget buildMainDescription(ProductCubit cubit) {
    return Stack(alignment: AlignmentDirectional.topEnd, children: [
      Padding(
        padding: const EdgeInsetsDirectional.only(
          top: AppPadding.p8,
          end: AppPadding.p8,
        ),
        child: IconButton(
          onPressed: () {
            productNameController.text = cubit.product.name!;
            productDescriptionController.text = cubit.product.descreption!;
            productManufacturingMaterialController.text =
                cubit.product.manufacturingMaterial!;
            productGuaranteeController.text =
                cubit.product.guarantee!.toString();
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
                          'Insert new Info',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: buildFieldsOfProductInfo(cubit),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p16),
                        child: BlocConsumer<UpdateProductCubit,
                            UpdateProductState>(
                          listener: (context, state) {
                            if (state is UpdateProductInfoDoneState) {
                              setState(() {
                                ProductCubit().product=cubit.product;
                                ProductCubit()
                                    .getSinglePro(proId: cubit.product.id!);
                              });
                              showToast(
                                  text: 'Updating Done',
                                  state: ToastStates.SUCCESS);
                            }
                          },
                          builder: (context, state) {
                            return DefaultButton(
                                function: () {
                                  if (formKey1.currentState!.validate() &&
                                      dropdownvalue!.isNotEmpty) {
                                    UpdateProductCubit.get(context)
                                        .updateProductInfo(
                                            nameProduct:
                                                productNameController.text,
                                            discriptionProduct:
                                                productDescriptionController
                                                    .text,
                                            mineCategoriesProduct:
                                                dropdownvalue ?? "No Selected",
                                            manifacturingMaterialProduct:
                                                productManufacturingMaterialController
                                                    .text,
                                            guaranteeProduct: int.parse(
                                                productGuaranteeController
                                                    .text),
                                            proId: cubit.product.id!);
                                  }
                                },
                                text: 'Update Info');
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
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DefaultLabel(text: AppStrings.mainDescriptions),
          const SizedBox(height: AppSize.s8),
          PairWidget(
            label: AppStrings.productName,
            value: cubit.product.name,
            notTR: true,
          ),
          PairWidget(
            label: AppStrings.mainCategory,
            value: cubit.product.mainCategorie,
            notTR: true,
          ),
          /*  PairWidget(
            label: AppStrings.ownerName,
            value: cubit.product.ownerId?.fullName,
            notTR: true,
          ),*/
          PairWidget(
            label: AppStrings.guarantee,
            value: cubit.product.guarantee.toString(),
            notTR: true,
          ),
          PairWidget(
            label: AppStrings.manufacturingMaterial,
            value: cubit.product.manufacturingMaterial,
            notTR: true,
          ),
          PairWidget(
            label: AppStrings.description,
            value: cubit.product.descreption,
            notTR: true,
          ),
        ],
      ),
    ]);
  }

  String? dropdownvalue;

  buildFieldsOfProductInfo(ProductCubit cubit) {
    var cubitAddProduct = AddProductionCubit.get(context);
    dropdownvalue = cubit.product.mainCategorie;
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Form(
        key: formKey1,
        child: Column(
          children: [
            TFF(
              controller: productNameController,
              label: 'product name',
              prefixIcon: Icons.production_quantity_limits_outlined,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Name Of Product Must not be empty';
                }
              },
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    value: dropdownvalue,
                    items: cubitAddProduct.arCategories
                        .map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          // Adjust the padding as needed
                          child: Text(item ?? ''),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropdownvalue = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Select a Category',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.category_outlined),
                      contentPadding: EdgeInsets.all(5.0),
                    ),
                  ),
                ),
                DTextButton(
                  text: 'Add Cat',
                  function: () {
                    navigateTo(context, const AddCategoryScreen());
                  },
                ),
              ],
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            TFF(
              controller: productDescriptionController,
              label: 'product description',
              prefixIcon: Icons.description_outlined,
              height: 20.0,
              maxLines: 2,
              keyboardType: TextInputType.multiline,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'description Of Product Must not be empty';
                }
              },
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            TFF(
              controller: productManufacturingMaterialController,
              label: 'Manufacturing Material product',
              prefixIcon: Icons.precision_manufacturing_outlined,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Manufacturing Material Of Product Must not be empty';
                }
              },
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            TFF(
              controller: productGuaranteeController,
              label: 'Guarantee',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.handshake_outlined,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Guarantee Must not be empty';
                }
              },
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
          ],
        ),
      ),
    );
  }
}
