import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:merchant_app/core/components/default_dismissable_new.dart';
import 'package:merchant_app/core/components/default_image.dart';
import 'package:merchant_app/core/components/default_label.dart';
import 'package:merchant_app/core/components/get_photo_from_gallery.dart';
import 'package:merchant_app/core/components/my_listview.dart';
import 'package:merchant_app/core/components/my_text.dart';
import 'package:merchant_app/core/components/text_form_field.dart';
import 'package:merchant_app/core/components/toast_notifications.dart';
import 'package:merchant_app/core/network/local/cache_helper.dart';
import 'package:merchant_app/core/network/local/keys.dart';
import 'package:merchant_app/core/resources/color_manager.dart';
import 'package:merchant_app/core/resources/constants_manager.dart';
import 'package:merchant_app/core/resources/string_manager.dart';
import 'package:merchant_app/core/resources/styles_manager.dart';
import 'package:merchant_app/core/validations/validations.dart';
import 'package:merchant_app/feauters/layouts/home_leyout/home_layout_cubit/home_layout_cubit.dart';
import 'package:merchant_app/feauters/product/domin/add_category/request/add_category_request.dart';
import 'package:merchant_app/feauters/product/presentation/add_category/add_category_cubit/add_category_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/feauters/product/presentation/add_product/add_product_cubit/add_product_states.dart';
import '../../../../core/components/button.dart';
import '../../../../core/functions.dart';
import '../../../../core/resources/values_manager.dart';
import '../../domin/add_product/response/get_categories_response.dart';
import '../add_product/add_product_cubit/add_product_cubit.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController imageCategoryController = TextEditingController();
  TextEditingController arNameCategoryController = TextEditingController();
  TextEditingController enNameCategoryController = TextEditingController();

  List<CategoryData> myList = [];
  bool isUpdate = false;

  String catId = '';

  var formKey = GlobalKey<FormState>();
  AddCategoryRequest addCategoryRequest = AddCategoryRequest();
  File? imageOfCategory;

  @override
  void initState() {
    super.initState();
    myList = AddProductionCubit.get(context).categories;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCategoryCubit, AddCategoryStates>(
      listener: (context, state) {
        if (state is UpdateCategoryDoneState) {
          showToast(
              text: 'Category data Updated Done', state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Category'),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  addCategoryWidget(),
                  getMyCategories(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget addCategoryWidget() {
    return BlocConsumer<AddCategoryCubit, AddCategoryStates>(
      listener: (context, state) {
        if (state is AddCategoryDoneState) {
          setState(() {});
          print("---------------------------------------------");
          print(myList.length);
          showToast(
              text: 'Adding New Category Done', state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSize.s12, AppSize.s20, AppSize.s12, AppSize.s12),
            child: Column(
              children: [
                TFF(
                  controller: imageCategoryController,
                  label: 'image of category',
                  readOnly: true,
                  prefixIcon: Icons.image_outlined,
                  suffix: Icons.arrow_drop_down_outlined,
                  suffixPressed: () async {
                    setState(() {});
                    imageOfCategory = await takePhoto();
                    imageCategoryController.text =
                        imageOfCategory!.path.split('/').last;
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Image of category Must not be empty';
                    }
                  },
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),
                TFF(
                  controller: arNameCategoryController,
                  label: 'name  of category in arabic',
                  prefixIcon: Icons.drive_file_rename_outline,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'name  of category in arabic Must not be empty';
                    } else if (!Validations.isWriteInArabicValid(value)) {
                      return 'name of category in Arabic Must be in Arabic';
                    } else if ((!isUpdate) &&
                        AddProductionCubit.get(context)
                            .arCategories
                            .contains(value)) {
                      return 'this Name is already existed';
                    }
                  },
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),
                TFF(
                  controller: enNameCategoryController,
                  label: 'name of category in english',
                  prefixIcon: Icons.drive_file_rename_outline,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'name of category in english Must not be empty';
                    } else if (!Validations.isWriteInEnglishValid(value)) {
                      return 'name of category in english Must be in english';
                    } else if ((!isUpdate) &&
                        AddProductionCubit.get(context)
                            .enCategories
                            .contains(value)) {
                      return 'this Name is already existed';
                    }
                  },
                ),
                const SizedBox(
                  height: AppSize.s28,
                ),
                isUpdate
                    ? SizedBox(
                        height: 60.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 5,
                              child: DefaultButton(
                                function: () async {
                                  if (formKey.currentState!.validate()) {
                                    addCategoryRequest.arName =
                                        arNameCategoryController.text;
                                    addCategoryRequest.enName =
                                        enNameCategoryController.text;
                                    imageCategoryController.text =
                                        imageOfCategory!.path.split('/').last;

                                    if (catId.isNotEmpty) {
                                      AddCategoryCubit.get(context)
                                          .updateCategory(
                                        catId: catId,
                                        arName: arNameCategoryController.text,
                                        enName: enNameCategoryController.text,
                                        imageName: imageCategoryController.text,
                                        imageOfCate: imageOfCategory!,
                                        context: context,
                                      );
                                    } else {
                                      showToast(
                                        text:
                                            'Please Selecte an Item to Update',
                                        state: ToastStates.WARNING,
                                      );
                                    }
                                  }
                                },
                                text: 'Update',
                              ),
                            ),
                            const SizedBox(width: AppSize.s8),
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isUpdate = false;
                                    imageCategoryController.clear();
                                    arNameCategoryController.clear();
                                    enNameCategoryController.clear();
                                  });
                                },
                                icon: const Icon(
                                  CupertinoIcons.trash,
                                  color: ColorManager.error,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : BlocConsumer<AddProductionCubit, AddProductionStates>(
                        listener: (context, state) {
                          if (state is GetCategoriesDoneState) {
                            myList = state.data;
                            setState(() {});
                          }
                        },
                        builder: (context, state) {
                          return DefaultButton(
                            function: () async {
                              if (formKey.currentState!.validate()) {
                                addCategoryRequest.arName =
                                    arNameCategoryController.text;
                                addCategoryRequest.enName =
                                    enNameCategoryController.text;
                                imageCategoryController.text =
                                    imageOfCategory!.path.split('/').last;
                                AddCategoryCubit.get(context).addCategory(
                                  arName: arNameCategoryController.text,
                                  enName: enNameCategoryController.text,
                                  imageName: imageCategoryController.text,
                                  imageOfCate: imageOfCategory!,
                                  context: context,
                                );
                                AddProductionCubit.get(context)
                                    .getMerchantCategories(
                                        merchantId: Constants.sId);
                              }
                            },
                            text: 'Add Category',
                          );
                        },
                      )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getMyCategories() {
    print(AddProductionCubit.get(context).arCategories);
    return Column(
      children: [
        const DefaultLabel(text: 'Your All Categories...'),
        Conditional.single(
          context: context,
          conditionBuilder: (context) => myList.isNotEmpty,
          widgetBuilder: (context) {
            return BlocConsumer<AddProductionCubit, AddProductionStates>(
              listener: (context, state) {
                if (state is GetCategoriesDoneState) {
                  myList = state.data;
                  setState(() {});
                }
              },
              builder: (context, state) {
                return MyListView<CategoryData>(
                  fetchData: () {},
                  list: myList,
                  noMoreData: true,
                  itemBuilder: (context, CategoryData data) =>
                      categoryWidget(data: data),
                );
              },
            );
          },
          fallbackBuilder: (context) => Container(),
        ),
      ],
    );
  }

  Widget categoryWidget({required CategoryData data}) {
    return DefaultDismissibleNew(
      function: () {
        myList.remove(data);
        AddCategoryCubit.get(context).deleteCategory(
          catId: data.sId ?? '',
          context: context,
        );
      },
      widget: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [

              Container(
                height: AppSize.s200,
                margin: const EdgeInsetsDirectional.all(AppSize.s8),
                decoration: getDeco(),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: DefaultImage(
                  imageUrl: data.imageOfCate,
                  clickable: true,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: AppPadding.p8,
                  end: AppPadding.p8,
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      catId = data.sId ?? '';
                      isUpdate = true;
                      arNameCategoryController.text = data.arName ?? '';
                      enNameCategoryController.text = data.enName ?? '';
                    });
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: ColorManager.black,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsetsDirectional.all(AppMargin.m8),
            padding: const EdgeInsetsDirectional.all(AppPadding.p4),
            decoration: getDeco(
              color: ColorManager.warning.withOpacity(.4),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MText(
                  text: data.enName ?? '',
                  notTR: true,
                  style: getMediumStyle(
                    color: ColorManager.black,
                    fontSize: AppSize.s18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
