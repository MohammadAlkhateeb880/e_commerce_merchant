import 'package:flutter/material.dart';
import 'package:merchant_app/core/components/text_form_field.dart';
import 'package:merchant_app/core/resources/values_manager.dart';
import 'package:merchant_app/feauters/product/domin/add_product/request/add_offer_to_product_request.dart';
import 'package:merchant_app/feauters/product/presentation/add_offer_to_product/add_offer_to_product/add_offer_to_product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/button.dart';
import '../../../../core/components/toast_notifications.dart';

class AddOfferToProductScreen extends StatefulWidget {
   AddOfferToProductScreen({Key? key,required this.productsIds}) : super(key: key);
  List<String>? productsIds=[];
  @override
  State<AddOfferToProductScreen> createState() =>
      _AddOfferToProductScreenState();
}

class _AddOfferToProductScreenState extends State<AddOfferToProductScreen> {
  DateTime selectedDate = DateTime.now();
  TextEditingController startDateOfOffersControllers = TextEditingController();
  TextEditingController endDateOfOffersControllers = TextEditingController();
  TextEditingController valueOfOffersControllers = TextEditingController();

  AddOfferToProductsRequest addOfferToProductsRequest=AddOfferToProductsRequest();
  var formKey = GlobalKey<FormState>();

  int _selectedIndex = 0;

  Future<void> _selectDate(BuildContext context,
      TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2023, 5),
        lastDate: DateTime(2025));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controller.text = picked
            .toString()
            .split(' ')
            .first; // set the selected date to the text controller
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddOfferToProductCubit(),
      child: BlocConsumer<AddOfferToProductCubit,AddOfferToProductStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          AddOfferToProductCubit cubit =AddOfferToProductCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add Offer'),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(AppSize.s14),
                  child: Column(
                    children: [
                      TFF(
                        controller: startDateOfOffersControllers,
                        readOnly: true,
                        label: 'Start Date Of Offer',
                        prefixIcon: Icons.date_range_outlined,
                        suffix: Icons.arrow_drop_down_rounded,
                        suffixPressed: () {
                          _selectDate(context, startDateOfOffersControllers);
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Start Date Must not be empty';
                          }
                        },
                      ),
                      const SizedBox(
                        height: AppSize.s28,
                      ),
                      TFF(
                        controller: endDateOfOffersControllers,
                        readOnly: true,
                        label: 'End Date Of Offer',
                        prefixIcon: Icons.date_range_outlined,
                        suffix: Icons.arrow_drop_down_rounded,
                        suffixPressed: () {
                          _selectDate(context, endDateOfOffersControllers);
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'End Date Must not be empty';
                          }
                        },
                      ),
                      const SizedBox(
                        height: AppSize.s16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<int>(
                              title: const Text('percentage'),
                              value: 0,
                              groupValue: _selectedIndex,
                              onChanged: (value) {
                                setState(() {
                                  _selectedIndex = value!;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<int>(
                              title: const Text('discount'),
                              value: 1,
                              groupValue: _selectedIndex,
                              onChanged: (value) {
                                setState(() {
                                  _selectedIndex = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSize.s16,
                      ),
                      TFF(
                        controller: valueOfOffersControllers,
                        keyboardType: TextInputType.number,
                        label: 'Value Of Offer',
                        prefixIcon: Icons.date_range_outlined,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Value of Offer Must not be empty';
                          }
                        },
                      ),
                      const SizedBox(
                        height: AppSize.s100,
                      ),
                      DefaultButton(function: () {
                        DateTime startDate = DateTime.parse(startDateOfOffersControllers.text);
                        DateTime endDate = DateTime.parse(endDateOfOffersControllers.text);
                        if (startDate.isAfter(endDate)) {
                          showToast(
                              text: 'Invalid inserted',
                              state: ToastStates.ERROR);
                        }
                        else if (formKey.currentState!.validate()) {
                          addOfferToProductsRequest.startDateOfOffers=startDateOfOffersControllers.text;
                          addOfferToProductsRequest.endDateOfOffers=endDateOfOffersControllers.text;
                          addOfferToProductsRequest.valueOfOffer=int.parse(valueOfOffersControllers.text);
                          addOfferToProductsRequest.typeOfOffer= (_selectedIndex == 1)? 'discount' : 'percentage';
                          addOfferToProductsRequest.productsIds=[];
                          addOfferToProductsRequest.productsIds?.addAll(widget.productsIds!);
                          print("*************************");
                          print( addOfferToProductsRequest.productsIds?.first);
                          cubit.addOfferToProduct(addOfferToProductsRequest: addOfferToProductsRequest);
                        }
                      }, text: 'Add Offer',),

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
}
