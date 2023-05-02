import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:merchant_app/core/resources/values_manager.dart';
import 'package:merchant_app/feauters/product/presentation/add_product/add_product_cubit/add_product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/feauters/product/presentation/add_product/add_product_cubit/add_product_states.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/components/button.dart';
import '../../../../core/components/drop_down_butten.dart';
import '../../../../core/components/text_form_field.dart';
import '../../../../core/functions.dart';
import '../../../../core/resources/color_manager.dart';
import '../../domin/add_product/request/add_production_request.dart';
import '../../domin/add_product/request/info_product.dart';
import '../add_image_product/add_image_product_screen.dart';
import 'add_product_widgets/add_pro_page_2.dart';

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
  TextEditingController priceOfProductController = TextEditingController();
  TextEditingController sizeOfProductController = TextEditingController();
  TextEditingController lengthOfProductController = TextEditingController();
  TextEditingController widthOfProductController = TextEditingController();
  TextEditingController colorOfProductController = TextEditingController();
  TextEditingController quantityOfProductController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  List<InfoProduct> rows = [];
  var boardController = PageController();

  AddProductionRequest addProductionRequest = AddProductionRequest();

  void _addRow() {
    setState(() {
      rows.add(InfoProduct(
          width: '2',
          length: '5',
          size: 'Fit for two people',
          price: '5000',
          quantity: '5',
          color: 'red'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add product'),
      ),
      body: BlocProvider(
        create: (context) => AddProductionCubit(),
        child: BlocConsumer<AddProductionCubit, AddProductionStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Center(
                child: onBoarding(),
              );
            }),
      ),
    );
  }

  Widget onBoarding() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
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
                } else {
                  return const BuildPageTwo();
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

  Widget buildPageOne(context) {
    return Padding(
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
              prefixIcon: Icons.handshake_outlined,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Guarantee Must not be empty';
                }
              },
            ),
            const SizedBox(
              height: AppSize.s18,
            ),
            /* TFF(
                            controller: priceOfProductController,
                            label: 'price',
                            prefixIcon: Icons.attach_money_outlined,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'price Must not be empty';
                              }
                            },
                          ),
                          const SizedBox(
                            height: AppSize.s18,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TFF(
                                  controller: sizeOfProductController,
                                  label: 'Size',
                                  prefixIcon: Icons.attach_money_outlined,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Size Must not be empty';
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: AppSize.s18,
                              ),
                              Expanded(
                                child: TFF(
                                  controller: lengthOfProductController,
                                  label: 'Length',
                                  prefixIcon: Icons.attach_money_outlined,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Length Must not be empty';
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: AppSize.s18,
                              ),
                              Expanded(
                                child: TFF(
                                  controller: widthOfProductController,
                                  label: 'Width',
                                  prefixIcon: Icons.attach_money_outlined,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Width Must not be empty';
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: AppSize.s18,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TFF(
                                  controller: quantityOfProductController,
                                  label: 'Quantity',
                                  prefixIcon:
                                      Icons.production_quantity_limits_outlined,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Quantity Must not be empty';
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: AppSize.s18,
                              ),
                              Expanded(
                                child: TFF(
                                  controller: colorOfProductController,
                                  label: 'Color',
                                  prefixIcon: Icons.color_lens_outlined,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Color Must not be empty';
                                    }
                                  },
                                ),
                              ),

                            ],
                          ),*/
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: generateDataTable(),
            // ),
            DefaultButton(
              text: 'add More',
              function: () {
                _addRow();
              },
            ),
            const SizedBox(
              height: AppSize.s18,
            ),
            DefaultButton(
              text: 'add',
              function: () {
                navigateTo(
                  context,
                  AddImageProductScreen(),
                );
                // if (formKey.currentState!.validate()) {
                //   addProductionRequest.name =
                //       nameOfProductController.text;
                //   addProductionRequest.descreption =
                //       descriptionOfProductController.text;
                //   addProductionRequest.guarantee =
                //       guaranteeOfProductController.text;
                //   addProductionRequest.manufacturingMaterial =
                //       manufacturingMaterialOfProductController
                //           .text;
                //   // addProductionRequest.classes[0].price=priceOfProductController.text;
                //
                // }
              },
            ),
          ],
        ),
      ),
    );
  }


  DataTable generateDataTable() {
    DataTable dataTable = DataTable(
      // Datatable widget that have the property columns and rows.
      columns: const [
        // Set the name of the column
        DataColumn(
          label: Text('Length'),
        ),
        DataColumn(
          label: Text('Width'),
        ),
        DataColumn(
          label: Text('Size'),
        ),

        DataColumn(
          label: Text('Price'),
        ),
        DataColumn(
          label: Text('Quantity'),
        ),
        DataColumn(
          label: Text('Color'),
        ),
      ],
      rows: List<DataRow>.generate(
        rows.length,
        (index) => DataRow(
          cells: [
            DataCell(TextFormField()),
            DataCell(Text(rows[index].length)),
            DataCell(Text(rows[index].size)),
            DataCell(Text(rows[index].price)),
            DataCell(Text(rows[index].quantity)),
            DataCell(Text(rows[index].color)),
          ],
        ),
      ),
    );
    return dataTable;
  }
}
