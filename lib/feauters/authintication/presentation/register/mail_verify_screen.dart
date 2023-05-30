import 'package:flutter/material.dart';
import 'package:merchant_app/core/components/button.dart';
import 'package:merchant_app/core/components/toast_notifications.dart';
import 'package:merchant_app/core/resources/constants_manager.dart';
import 'package:merchant_app/feauters/authintication/presentation/register/register_cubit/register_cubit.dart';
import 'package:merchant_app/feauters/authintication/presentation/register/register_cubit/register_states.dart';

import '../../../../core/components/text_form_field.dart';
import '../../../../core/data/network/local/cache_helper.dart';
import '../../../../core/functions.dart';
import '../../../../core/network/local/keys.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../home/presentation/home_screen.dart';
import '../../domin/request/regester_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MailVerificationScreen extends StatefulWidget {
  MailVerificationScreen({Key? key, required this.registerRequest})
      : super(key: key);
  RegisterRequest registerRequest;

  @override
  _MailVerificationScreenState createState() => _MailVerificationScreenState();
}

class _MailVerificationScreenState extends State<MailVerificationScreen> {
  TextEditingController codeController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mile Verification Code"),
      ),
      body: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
        if (state is RegisterDoneState) {
          if (state.registerResponse.status!) {
            showToast(text: state.registerResponse.message!, state: ToastStates.SUCCESS);
            CacheHelper.saveData(
              key: CacheHelperKeys.token,
              value: state.registerResponse.data?.token,
            ).then(
              (value) {
                Constants.token = state.registerResponse.data!.token!;

              },
            );
            CacheHelper.saveData(
              key: CacheHelperKeys.email,
              value: state.registerResponse.data?.user?.email,
            ).then(
                  (value) {
                Constants.email = state.registerResponse.data!.user!.email!;

              },
            );
            CacheHelper.saveData(
              key: CacheHelperKeys.fullName,
              value: state.registerResponse.data?.user?.fullName,
            ).then(
                  (value) {
                Constants.email = state.registerResponse.data!.user!.fullName!;

              },
            );
            CacheHelper.saveData(
              key: CacheHelperKeys.sId,
              value: state.registerResponse.data?.user?.sId,
            ).then(
                  (value) {
                Constants.email = state.registerResponse.data!.user!.sId!;

              },
            );
            navigateAndFinish(context, HomeScreen());
          } else {
            showToast(
                text: state.registerResponse.message!,
                state: ToastStates.ERROR);
          }
        }
      }, builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'We Are Send Email Code Verification To:',
                        style: getBoldStyle(
                          color: ColorManager.primary,
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s4,
                      ),
                      Text(
                        widget.registerRequest.email!,
                        style: getExtraLightStyle(
                          color: ColorManager.primary,
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s4,
                      ),
                      Text(
                        'Please Check your Mail Box',
                        style: getExtraLightStyle(
                          color: ColorManager.primary,
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s12,
                      ),
                      TFF(
                        controller: codeController,
                        label: 'Email Code Verification Here',
                        prefixIcon: Icons.verified_user_sharp,
                        keyboardType: TextInputType.number,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'This Code wrong Please Enter Correct Code.';
                          }
                        },
                      ),
                      const SizedBox(
                        height: AppSize.s12,
                      ),
                      DefaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              if (widget.registerRequest.pin ==
                                  codeController.text) {
                                cubit.register(
                                  registerRequest: widget.registerRequest,
                                );
                              } else {
                                showToast(
                                    text: 'Not Valid',
                                    state: ToastStates.ERROR);
                              }
                            }
                          },
                          text: 'Register Now',
                          isLoading: false //state is RegisterLoadingState,
                          ),
                    ],
                  )),
            ),
          ),
        );
      }),
    );
  }
}
