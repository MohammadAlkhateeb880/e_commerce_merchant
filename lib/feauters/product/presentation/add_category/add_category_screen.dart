import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merchant_app/core/components/get_photo_from_gallery.dart';
import 'package:merchant_app/core/components/text_form_field.dart';
import 'package:merchant_app/core/components/toast_notifications.dart';
import 'package:merchant_app/core/validations/validations.dart';
import 'package:merchant_app/feauters/product/domin/add_category/request/add_category_request.dart';
import 'package:merchant_app/feauters/product/presentation/add_category/add_category_cubit/add_category_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  var formKey = GlobalKey<FormState>();
  AddCategoryRequest addCategoryRequest = AddCategoryRequest();
  File? imageOfCategory;

  @override
  Widget build(BuildContext context) {
    var getCategoryCubit = AddProductionCubit.get(context);
    List<String> arNames = [];
    List<String> enNames = [];
    if (getCategoryCubit.categories.isNotEmpty) {
      for (CategoryData element in getCategoryCubit.categories) {
        arNames.add(element.arName!);
        enNames.add(element.enName!);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: BlocProvider(
        create: (context) => AddCategoryCubit(),
        child: BlocConsumer<AddCategoryCubit, AddCategoryStates>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = AddCategoryCubit.get(context);
            return SingleChildScrollView(
                child: Form(
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
                        } else if (arNames.contains(value)) {
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
                        } else if (enNames.contains(value)) {
                          return 'this Name is already existed';
                        }
                      },
                    ),
                    const SizedBox(
                      height: AppSize.s28,
                    ),
                    DefaultButton(
                      function: () async {
                        if (formKey.currentState!.validate()) {
                          addCategoryRequest.arName =
                              arNameCategoryController.text;
                          addCategoryRequest.enName =
                              enNameCategoryController.text;
                          imageCategoryController.text =
                              imageOfCategory!.path.split('/').last;
                          cubit.addCategory(
                            arName: arNameCategoryController.text,
                            enName: enNameCategoryController.text,
                            imageName: imageCategoryController.text,
                            imageOfCate: imageOfCategory!,
                            context: context,
                          );
                        }
                      },
                      text: 'Add Category',
                    )
                  ],
                ),
              ),
            ));
          },
        ),
      ),
    );
  }
}
