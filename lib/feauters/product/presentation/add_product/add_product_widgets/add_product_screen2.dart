import 'package:flutter/material.dart';
import 'package:merchant_app/core/components/button.dart';
import 'package:merchant_app/core/components/toast_notifications.dart';
import 'package:merchant_app/feauters/product/presentation/add_delivery_areas/add_delivery_areas_screen.dart';
import 'package:merchant_app/feauters/product/presentation/add_product/add_product_cubit/add_product_cubit.dart';
import 'package:merchant_app/feauters/product/presentation/add_product/add_product_cubit/add_product_states.dart';
import 'package:merchant_app/feauters/product/presentation/add_product/add_product_widgets/add_dialog.dart';
import '../../../../../core/components/text_button.dart';
import '../../../../../core/components/text_form_field.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../domin/add_product/request/add_production_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductionScreen2 extends StatefulWidget {
  const AddProductionScreen2({Key? key, required this.addProductionRequest})
      : super(key: key);
  final AddProductionRequest addProductionRequest;

  @override
  _AddProductionScreen2State createState() => _AddProductionScreen2State();
}

class _AddProductionScreen2State extends State<AddProductionScreen2> {
  TextEditingController priceOfProductController = TextEditingController();
  TextEditingController sizeOfProductController = TextEditingController();
  TextEditingController lengthOfProductController = TextEditingController();
  TextEditingController widthOfProductController = TextEditingController();
  TextEditingController colorOfProductController = TextEditingController();
  TextEditingController quantityOfProductController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  List<Class>? Classes = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductionCubit(),
      child: BlocConsumer<AddProductionCubit,AddProductionStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = AddProductionCubit.get(context);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSize.s8),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TFF(
                      controller: priceOfProductController,
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
                      controller: sizeOfProductController,
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
                      controller: lengthOfProductController,
                      label: 'Length',
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
                      controller: widthOfProductController,
                      label: 'Width',
                      prefixIcon: Icons.attach_money_outlined,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Width Must not be empty';
                        }
                      },
                    ),
                    const SizedBox(
                      height: AppSize.s8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultButton(
                            function: () {
                              print('------------ ');
                              print(Classes!.isEmpty);
                              cubit.addProduction(addProductRequest:  widget.addProductionRequest);
                              navigateTo(
                                  context,
                                  AddDeliveryAreasScreen()
                              );
                            },
                            text: 'Finish',
                          ),
                        ),
                        const SizedBox(
                          width: AppSize.s8,
                        ),
                        Expanded(
                          child: DefaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {

                                widget.addProductionRequest.classes?.add(Class(
                                  price: priceOfProductController.text,
                                  size: sizeOfProductController.text,
                                  length: lengthOfProductController.text,
                                  width: widthOfProductController.text,
                                ));
                                print("///////////////////////////////////////");
                                print(widget.addProductionRequest.classes?.first.price);
                                print(widget.addProductionRequest.classes?.first.size);
                                print(widget.addProductionRequest.classes?.first.length);
                                print(widget.addProductionRequest.classes?.first.width);
                                print("///////////////////////////////////////");


                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return AddDialog(
                                      addProductionRequest: widget
                                          .addProductionRequest,);
                                  },
                                );
                              }
                            },
                            text: 'Go Next',
                          ),
                        ),
                      ],
                    ),
                    const Text('print what the user select'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildListWidget(List<Class>? classes) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Text(classes?[index].length ??
                'length : ${classes?[index].length} '),
            Text(classes?[index].width ?? 'width : ${classes?[index].width} '),
            Text(classes?[index].size ?? 'size : ${classes?[index].size} '),
            Text(classes?[index].price ?? 'price : ${classes?[index].price} '),
            //classes?[index].group.forEach((element) { })
            Text(classes?[index].group?[0].quantity.toString() ??
                'price : ${classes?[index].price} '),
          ],
        );
      },
      itemCount: classes?.length,
    );
  }
}
