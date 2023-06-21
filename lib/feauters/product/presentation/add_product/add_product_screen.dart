import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:merchant_app/core/components/button.dart';
import 'package:merchant_app/core/components/text_button.dart';
import 'package:merchant_app/core/components/toast_notifications.dart';
import 'package:merchant_app/core/functions.dart';
import 'package:merchant_app/core/resources/values_manager.dart';
import 'package:merchant_app/feauters/product/presentation/add_category/add_category_screen.dart';
import 'package:merchant_app/feauters/product/presentation/add_product/add_product_cubit/add_product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/feauters/product/presentation/add_product/add_product_cubit/add_product_states.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/components/default_loading.dart';
import '../../../../core/components/text_form_field.dart';
import '../../../../core/resources/color_manager.dart';
import '../../domin/add_product/request/add_production_request.dart';
import 'add_product_widgets/add_product_screen2.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController nameOfProductController = TextEditingController();
  TextEditingController descriptionOfProductController =
      TextEditingController();
  TextEditingController manufacturingMaterialOfProductController =
      TextEditingController();
  TextEditingController guaranteeOfProductController = TextEditingController();
  TextEditingController testController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var boardController = PageController();

  AddProductionRequest addProductionRequest = AddProductionRequest();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductionCubit, AddProductionStates>(
        listener: (context, state) {
          if(state is AddProductionDoneState){
            showToast(text: state.addProductResponse.message!, state: ToastStates.SUCCESS);
          }
        },
        builder: (context, state) {
          if (state is GetCategoriesLoadingState) {
            return Center(
              child: DefaultLoading(),
            );
          } else {
            return Center(
              child: onBoarding(),
            );
          }
        });
  }

  Widget onBoarding() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: boardController,
              onPageChanged: (int index) {},
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return buildPageOne(context);
                } else if (formKey.currentState!.validate()) {
                  addProductionRequest.name = nameOfProductController.text;
                  addProductionRequest.descreption =
                      descriptionOfProductController.text;
                  addProductionRequest.guarantee =
                      guaranteeOfProductController.text;
                  addProductionRequest.manufacturingMaterial =
                      manufacturingMaterialOfProductController.text;


                  return AddProductionScreen2(
                    addProductionRequest: addProductionRequest,
                  );
                }
              },
              itemCount: 2,
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Row(
            children: [
              const SizedBox(
                width: AppSize.s8,
              ),
              SmoothPageIndicator(
                controller: boardController,
                effect: const ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: ColorManager.primary,
                  dotHeight: 10.0,
                  dotWidth: 10.0,
                  spacing: 5,
                  expansionFactor: 4,
                ),
                count: 2,
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  String? dropdownvalue;

  Widget buildPageOne(context) {
    var cubit = AddProductionCubit.get(context);
    //her is warning check if language is english and replace category.arName with category.enName
    dropdownvalue = cubit.arCategories[0];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSize.s8),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TFF(
                controller: nameOfProductController,
                label: 'Name Of Product',
                prefixIcon: Icons.production_quantity_limits,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Name Of Product Must not be empty';
                  }
                },
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
              TFF(
                controller: descriptionOfProductController,
                label: 'description about Product',
                prefixIcon: Icons.description_outlined,
                height: 30.0,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'description Of Product Must not be empty';
                  }
                },
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      value: dropdownvalue,
                      items: cubit.arCategories
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
                          addProductionRequest.mainCategorie = dropdownvalue;
                          print(dropdownvalue);
                          print(addProductionRequest.mainCategorie);
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
                height: AppSize.s18,
              ),
              TFF(
                controller: manufacturingMaterialOfProductController,
                label: 'Manufacturing Material',
                prefixIcon: Icons.precision_manufacturing_outlined,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Manufacturing Material Of Product Must not be empty';
                  }
                },
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
              TFF(
                controller: guaranteeOfProductController,
                label: 'Guarantee',
                keyboardType: TextInputType.number,
                prefixIcon: Icons.handshake_outlined,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Guarantee Must not be empty';
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
