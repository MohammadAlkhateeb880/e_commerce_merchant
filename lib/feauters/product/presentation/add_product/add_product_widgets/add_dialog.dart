import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../../../../core/components/text_button.dart';
import '../../../../../core/components/text_form_field.dart';
import '../../../../../core/components/toast_notifications.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../domin/add_product/request/add_production_request.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({Key? key, required this.addProductionRequest})
      : super(key: key);
  final AddProductionRequest addProductionRequest;

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  var formKey1 = GlobalKey<FormState>();
  TextEditingController colorOfProductController = TextEditingController();
  TextEditingController quantityOfProductController = TextEditingController();
  Color _currentColor = Colors.blue;
  List<Group>? group = [];
  List<Class> classes = [];

  @override
  Widget build(BuildContext context) {
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
              height: AppSize.s12,
            ),
            TFF(
              controller: colorOfProductController,
              label: 'color',
              readOnly: true,
              prefixIcon: Icons.color_lens_outlined,
              suffix: Icons.arrow_drop_down_outlined,
              suffixPressed: () {
                _openColorPicker(context);

                print(colorOfProductController.text);
              },
              validator: (String value) {
                if (value.isEmpty) {
                  return 'color Must not be empty';
                }
              },
            ),
            const SizedBox(
              height: AppSize.s8,
            ),
            Container(width: 50, height: 50, color: _currentColor
                // Color(int.parse(colorOfProductController.text, radix: 16)),
                //Color(int.parse(colorOfProductController.text, radix: 16) + 0xFF000000),
                )
          ],
        ),
      ),
      actions: [
        DTextButton(
          text: 'Add More?',
          function: () {
            if (formKey1.currentState!.validate()) {
              print('valeeeeeeeeeeeeed');
              group?.add(
                Group(
                  quantity: int.parse(quantityOfProductController.text),
                  color: colorOfProductController.text,
                ),
              );
              widget.addProductionRequest.classes?.add(Class(group: group));
            }
            print('++++++++++++++++++++++++++  : ${group?.length}');
            group?.forEach((g) {
              print('quantity : ');
              print(g.quantity);
              print('   color : ');
              print(g.color);
            });
            quantityOfProductController.clear();
            colorOfProductController.clear();
          },
        ),
        DTextButton(
          text: 'Finish',
          function: () {
            if (formKey1.currentState!.validate()) {
              print('valeeeeeeeeeeeeed');
              group?.add(
                Group(
                  quantity: int.parse(quantityOfProductController.text),
                  color: colorOfProductController.text,
                ),
              );
              widget.addProductionRequest.classes?.add(Class(group: group));
            }
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

  void _openColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // استخدام StatefulBuilder لتحديث AlertDialog
        return AlertDialog(
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _currentColor,
              onColorChanged: (Color color) {
                setState(() {
                  // استخدام setState() لتحديث _currentColor وإعادة بناء AlertDialog
                  _currentColor = color;
                  //Color(int.parse(colorOfProductController.text, radix: 16) + 0xFF000000);
                  colorOfProductController.text =
                      color.value.toRadixString(16).toUpperCase();
                  print(colorOfProductController.text);
                });
              },
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
}
