// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:merchant_app/core/components/text_form_field.dart';
import 'package:merchant_app/core/resources/values_manager.dart';
import 'package:merchant_app/feauters/product/domin/add_product/request/add_delivery_areas_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/feauters/product/presentation/add_delivery_areas/add_delivery_areas_cubit/add_delivery_areas_cubit.dart';
import 'package:merchant_app/feauters/product/presentation/add_delivery_areas/add_delivery_areas_cubit/add_delivery_areas_states.dart';

import '../../../../core/components/button.dart';
import '../../../../core/functions.dart';
import '../add_vr_product/add_vr_product_screen.dart';

class AddDeliveryAreasScreen extends StatefulWidget {
  const AddDeliveryAreasScreen({Key? key}) : super(key: key);

  @override
  _AddDeliveryAreasScreenState createState() => _AddDeliveryAreasScreenState();
}

class _AddDeliveryAreasScreenState extends State<AddDeliveryAreasScreen> {
  AddDeliveryAreasRequest addDeliveryAreasRequest = AddDeliveryAreasRequest();
  List<Areas> areas = [];
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  TextEditingController deliveryPriceController = TextEditingController();
  final GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AddDeliveryAreasCubit(),
      child: BlocConsumer<AddDeliveryAreasCubit, AddDeliveryAreasStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          AddDeliveryAreasCubit cubit = AddDeliveryAreasCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Add Delivery Areas"),
            ),
            body: addCSCPicker(),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                navigateTo(
                  context,
                  AddVRProductScreen(),
                );
                if (areas.isNotEmpty) {
                  addDeliveryAreasRequest.areas = areas;
                  cubit.addDeliveryAreas(
                      addDeliveryAreasRequest: addDeliveryAreasRequest,
                      id: '644e53ddba14d7b6e090e059');
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget addCSCPicker() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSize.s12),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CSCPicker(
                key: _cscPickerKey,
                layout: Layout.vertical,
                //flagState: CountryFlag.DISABLE,
                onCountryChanged: (country) {
                  setState(() {
                    countryValue = country;
                  });
                },
                onStateChanged: (state) {
                  if (state != null) {
                    stateValue = state;
                  }
                },
                onCityChanged: (city) {
                  if (city != null) {
                    cityValue = city;
                  }
                },

                countryDropdownLabel: "*Country",
                stateDropdownLabel: "*State",
                cityDropdownLabel: "*City",
                dropdownDialogRadius: 30,
                searchBarRadius: 30,
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
              TFF(
                  controller: deliveryPriceController,
                  keyboardType: TextInputType.phone,
                  label: 'delivery Price',
                  prefixIcon: Icons.attach_money_outlined,
                  validator: (value) {}),
              const SizedBox(
                height: AppSize.s28,
              ),
              DefaultButton(
                  function: () {
                    if (formKey.currentState!.validate() &&
                        countryValue.isNotEmpty &&
                        stateValue.isNotEmpty &&
                        cityValue.isNotEmpty) {
                      address = "$countryValue-$stateValue-$cityValue";
                      areas.add(
                        Areas(
                          location: address,
                          deliveryPrice:
                              int.parse(deliveryPriceController.text),
                        ),
                      );
                      setState(() {});
                    }
                  },
                  text: 'Add'),
              buildListWidget(areas),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListWidget(List<Areas>? areas) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Text(areas?[index].location ?? 'No Location'),
            Text(areas?[index].deliveryPrice.toString() ?? 'No no Price'),
          ],
        );
      },
      itemCount: areas?.length,
    );
  }
}
