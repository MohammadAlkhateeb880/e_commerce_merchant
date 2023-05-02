import 'package:flutter/material.dart';
import 'package:merchant_app/core/components/button.dart';
import 'package:merchant_app/core/components/toast_notifications.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../../../../core/components/text_button.dart';
import '../../../../../core/components/text_form_field.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../domin/add_product/request/add_production_request.dart';
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
  List<Class>? Classes = [];

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
            Text(''),
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
            IconButton(
              icon: const Icon(Icons.color_lens_outlined),
              //child: Text('Pick a color'),
              onPressed: _openColorPicker,
            ),
            Container(
              height: 50,
              width: 50,
              color: _currentColor,
            ),
            // TFF(
            //   controller: colorOfProductController,
            //   label: 'Color',
            //   prefixIcon: Icons.attach_money_outlined,
            //   validator: (String value) {
            //     if (value.isEmpty) {
            //       return 'Color Must not be empty';
            //     }
            //   },
            // ),
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
                  text: 'At Least Insert One Property',
                  state: ToastStates.WARNING);
            }
          },
        ),
      ],
    );
  }

  Color _currentColor = Colors.blue;

  void _openColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _currentColor,
              onColorChanged: (Color color) {
                setState(() {
                  _currentColor = color;
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildListWidget(List<Class>? classes) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Text(classes?[index].length?? 'length : ${classes?[index].length} '),
            Text(classes?[index].width?? 'width : ${classes?[index].width} '),
            Text(classes?[index].size?? 'size : ${classes?[index].size} '),
            Text(classes?[index].price?? 'price : ${classes?[index].price} '),
            //classes?[index].group.forEach((element) { })
            Text(classes?[index].group?[0].quantity.toString()?? 'price : ${classes?[index].price} '),

          ],
        );
      },
      itemCount: classes?.length,
    );
  }
}
