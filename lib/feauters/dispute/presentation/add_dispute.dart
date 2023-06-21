import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/core/components/button.dart';
import 'package:merchant_app/core/components/text_form_field.dart';
import 'package:merchant_app/core/functions.dart';
import 'package:merchant_app/core/resources/constants_manager.dart';
import 'package:merchant_app/core/resources/values_manager.dart';
import '../../../core/components/get_photo_from_gallery.dart';
import '../../../core/components/toast_notifications.dart';
import '../domin/request/add_dispute_request.dart';
import 'dispute_cubit/dispute_cubit.dart';

class AddDispute extends StatefulWidget {
  const AddDispute({Key? key}) : super(key: key);

  @override
  State<AddDispute> createState() => _AddDisputeState();
}

class _AddDisputeState extends State<AddDispute> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  AddDisputeRequest addDisputeRequest = AddDisputeRequest(
      email: Constants.email, typeUser: 'customer', phone: Constants.phone);
  int _selectedIndex = 0;
  File? image;

  @override
  void initState() {
    _emailController.text = Constants.email;
    _phoneNumberController.text = Constants.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Dispute'),
      ),
      body: BlocConsumer<DisputeCubit, DisputeState>(
        listener: (context, state) {
          if (state is AddDisputeDoneState) {
            showToast(
                text: state.addDisputeResponse.message!,
                state: ToastStates.SUCCESS);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Column(
                children: [
                  TFF(
                    controller: _emailController,
                    label: 'email',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Your Email is empty';
                      }
                    },
                  ),
                  const SizedBox(
                    height: AppSize.s16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TFF(
                          controller: _firstNameController,
                          label: 'First Name',
                          prefixIcon: Icons.perm_contact_cal_outlined,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Your First Name is empty';
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: AppSize.s12,
                      ),
                      Expanded(
                        child: TFF(
                          controller: _lastNameController,
                          label: 'Last Name',
                          prefixIcon: Icons.perm_contact_cal_outlined,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Your Last Name is empty';
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s16,
                  ),
                  TFF(
                    controller: _phoneNumberController,
                    label: 'phone',
                    keyboardType: TextInputType.phone,
                    prefixIcon: Icons.phone_android_outlined,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Your phone is empty';
                      }
                    },
                  ),
                  const SizedBox(
                    height: AppSize.s16,
                  ),
                  TFF(
                    controller: _messageController,
                    label: 'your message dispute',
                    prefixIcon: Icons.pageview_outlined,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Your dispute is empty';
                      }
                    },
                  ),
                  const SizedBox(
                    height: AppSize.s16,
                  ),
                  Container(
                    width: getScreenWidth(context),
                    height: getScreenHeight(context) / 3,
                    child: image == null
                        ? Center(
                            child: IconButton(
                              iconSize: 45.0,
                              onPressed: () async {
                                image = await takePhoto();
                                setState(() {});
                              },
                              icon: const Icon(Icons.add_a_photo_outlined),
                            ),
                          )
                        : Stack(children: [
                            IconButton(
                              iconSize: 15.0,
                              onPressed: () async {
                                image = await takePhoto();
                                setState(() {});
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            Center(child: Image.file(image!))
                          ]),
                  ),
                  DefaultButton(
                      function: () {
                        addDisputeRequest.email = _emailController.text;
                        addDisputeRequest.phone = _phoneNumberController.text;
                        addDisputeRequest.disputeImage = image;
                        addDisputeRequest.message = _messageController.text;
                        addDisputeRequest.firstName = _firstNameController.text;
                        addDisputeRequest.lastName = _lastNameController.text;
                        addDisputeRequest.typeDispute = 'global';
                        addDisputeRequest.typeUser = 'customer';
                        DisputeCubit.get(context)
                            .addDispute(addDisputeRequest: addDisputeRequest);
                      },
                      text: 'send dispute'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
