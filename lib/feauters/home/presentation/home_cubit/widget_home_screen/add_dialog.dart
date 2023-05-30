import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/core/components/toast_notifications.dart';
import '../../../../../core/components/text_button.dart';
import '../../../../../core/components/text_form_field.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../layouts/home_leyout/home_layout_cubit/home_layout_cubit.dart';

class AddDialogHotSelling extends StatefulWidget {
  const AddDialogHotSelling({Key? key, required this.productId})
      : super(key: key);
  final String productId;

  @override
  State<AddDialogHotSelling> createState() => _AddDialogHotSellingState();
}

class _AddDialogHotSellingState extends State<AddDialogHotSelling> {
  TextEditingController endDateOfHotSellingControllers =
      TextEditingController();

  var formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
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
      create: (context) => HomeLayoutCubit(),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {
          if(state is AddToHotSellingDoneState){
            Navigator.of(context).pop();
            print("************************");
            print(state.message.toString());
            showToast(text: state.message, state: ToastStates.SUCCESS);
          }else if(state is AddToHotSellingErrorState){
            Navigator.of(context).pop();
            showToast(text: state.message, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = HomeLayoutCubit.get(context);
          return AlertDialog(
            title: const Text('End Date'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: AppSize.s28,
                  ),
                  TFF(
                    controller: endDateOfHotSellingControllers,
                    readOnly: true,
                    label: 'End Date Of Offer',
                    prefixIcon: Icons.date_range_outlined,
                    suffix: Icons.arrow_drop_down_rounded,
                    suffixPressed: () {
                      _selectDate(context, endDateOfHotSellingControllers);
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'End Date Must not be empty';
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              DTextButton(
                text: 'add',
                function: () {
                  if (formKey.currentState!.validate()) {
                    cubit.addToHotSelling(
                      endDateOfHotSelling: endDateOfHotSellingControllers.text,
                      productId: widget.productId,
                    );
                  }
                },
              ),
              DTextButton(
                text: 'close',
                function: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
