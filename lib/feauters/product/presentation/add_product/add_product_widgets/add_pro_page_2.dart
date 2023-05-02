import 'package:flutter/material.dart';
import 'package:merchant_app/core/components/button.dart';
import 'package:merchant_app/core/components/toast_notifications.dart';

import '../../../../../core/components/text_button.dart';
import '../../../../../core/components/text_form_field.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../domin/add_product/request/add_production_request.dart';

class BuildPageTwo extends StatefulWidget {
  const BuildPageTwo({Key? key}) : super(key: key);

  @override
  _BuildPageTwoState createState() => _BuildPageTwoState();
}

class _BuildPageTwoState extends State<BuildPageTwo> {
  TextEditingController priceOfProductController = TextEditingController();
  TextEditingController sizeOfProductController = TextEditingController();
  TextEditingController lengthOfProductController = TextEditingController();
  TextEditingController widthOfProductController = TextEditingController();
  TextEditingController colorOfProductController = TextEditingController();
  TextEditingController quantityOfProductController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var formKey1 = GlobalKey<FormState>();

  List<Group>? group = [];
  // List<Group>? group = []; // I Make Error

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TFF(
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
            DefaultButton(
              function: () {
                if (!formKey.currentState!.validate()) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return myDialog(context);
                    },
                  );
                }
              },
              text: 'Go Next',
            ),
          ],
        ),
      ),
    );
  }

  Widget myDialog(context) {
    return AlertDialog(
      title: const Text('Complete Data Entry'),
      content: Form(
        key: formKey1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TFF(
              controller: quantityOfProductController,
              label: 'Quantity',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.attach_money_outlined,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Quantity Must not be empty';
                }
              },
            ),
            const SizedBox(
              height: AppSize.s8,
            ),
            TFF(
              controller: colorOfProductController,
              label: 'Color',
              prefixIcon: Icons.attach_money_outlined,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Color Must not be empty';
                }
              },
            ),
            const SizedBox(
              height: AppSize.s8,
            ),
          ],
        ),
      ),
      actions: [
        DTextButton(
          text: 'Yes',
          function: () {
            if (formKey1.currentState!.validate()) {
              group?.add(
                Group(
                  quantity: int.parse(quantityOfProductController.text),
                  color: colorOfProductController.text,
                ),
              );
            }
          },
        ),
        DTextButton(
          text: 'Add More?',
          function: () {
            quantityOfProductController.clear();
            colorOfProductController.clear();
          },
        ),
        DTextButton(
          text: 'Finish',
          function: () {
            if (group != null && group!.isNotEmpty) {
              Navigator.of(context).pop();
            } else {
              showToast(
                  text: 'At Least Insert One Properity',
                  state: ToastStates.WARNING);
            }
          },
        ),
      ],
    );
  }
}
