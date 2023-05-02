import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/core/resources/fonts_manager.dart';
import 'package:merchant_app/feauters/authintication/domin/request/regester_request.dart';
import 'package:merchant_app/feauters/authintication/presentation/register/mail_verify_screen.dart';
import 'package:merchant_app/feauters/authintication/presentation/register/register_cubit/register_cubit.dart';
import 'package:merchant_app/feauters/authintication/presentation/register/register_cubit/register_states.dart';

import 'package:country_code_picker/country_code_picker.dart';
import '../../../../core/components/button.dart';
import '../../../../core/components/get_photo_from_gallery.dart';
import '../../../../core/components/text_button.dart';
import '../../../../core/components/text_form_field.dart';
import '../../../../core/functions.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController marketNameController = TextEditingController();
  TextEditingController logoOfMarketController = TextEditingController();
  TextEditingController ibanContraller = TextEditingController();
  TextEditingController nameOFBankController = TextEditingController();
  TextEditingController nameOfBrandController = TextEditingController();
  TextEditingController taxNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController businessLicenseController = TextEditingController();
  TextEditingController addressOfBankController = TextEditingController();

  RegisterRequest registerRequest = RegisterRequest(
    fullName: "Muhammad",
    email: "mohammadalkhateb880@gmail.com",
    phone: "22222222",
    password: "M123456@m1",
    pin: "915527",
    marketName: "llla",
    iban: "3235455",
    nameOFBank: "dfdffd",
    addressOfBank: "dfdffd",
    nameOfBrand: "dhhdhd",
    taxNumber: "12ahs45sg",
    address: "tdsftv545454533333333",
  );

  File? imageOfBusinessLicense;
  File? imageOfLogoOfMarket;
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
          create: (BuildContext context) => RegisterCubit(),
          child: BlocConsumer<RegisterCubit, RegisterStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: AppSize.s180,
                          width: AppSize.s180,
                          child: Image(
                            image: AssetImage(
                              ImageAssets.splashLogo,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s18,
                        ),
                        TFF(
                          controller: fullNameController,
                          label: 'Full Name',
                          prefixIcon: Icons.person,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Name Must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s18,
                        ),
                        TFF(
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          label: 'Phone',
                          prefixIcon: Icons.phone_enabled_sharp,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Phone Must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s18,
                        ),
                        TFF(
                          controller: emailController,
                          label: 'Email',
                          prefixIcon: Icons.email_outlined,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Email Must not be empty';
                            }
                            // else if (!isEmailValid(value)) {
                            //   return 'Email Is not Correct';
                            // }
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s18,
                        ),
                        TFF(
                          controller: passwordController,
                          isPassword: isPassword,
                          label: 'Password',
                          prefixIcon: Icons.lock_open_outlined,
                          suffix: isPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          suffixPressed: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'password Must not be empty';
                            } else if (!isPasswordValid(value)) {
                              return 'password Must Contain 8 Characters as : P@ssw0rd!';
                            }
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s18,
                        ),
                        TFF(
                          controller: marketNameController,
                          label: 'Market Name',
                          prefixIcon: Icons.email_outlined,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Market Name Must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s18,
                        ),
                        TFF(
                          controller: logoOfMarketController,
                          label: 'Logo of market',
                          prefixIcon: Icons.photo_size_select_actual_outlined,
                          readOnly: true,
                          suffix: Icons.add_photo_alternate_outlined,
                          suffixPressed: () async {
                            imageOfLogoOfMarket = await takePhoto();
                            logoOfMarketController.text = "$imageOfLogoOfMarket"
                                .toString()
                                .split("/")
                                .last;
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Logo of market Must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s18,
                        ),
                        TFF(
                          controller: ibanContraller,
                          label: 'Personal Card Number',
                          prefixIcon: Icons.credit_card_outlined,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Personal Card Number Must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s18,
                        ),
                        TFF(
                          controller: nameOFBankController,
                          label: 'Bank Name',
                          prefixIcon: Icons.filter_b_and_w,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Bank Name Must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s18,
                        ),
                        TFF(
                          controller: addressOfBankController,
                          label: 'Bank Address',
                          prefixIcon: Icons.filter_b_and_w,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Bank Address Must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s18,
                        ),
                        TFF(
                          controller: nameOfBrandController,
                          label: 'Brand Name',
                          prefixIcon: Icons.branding_watermark_outlined,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Brand Name Must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s18,
                        ),
                        TFF(
                          controller: taxNumberController,
                          label: 'Text Number',
                          prefixIcon: Icons.numbers,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Text Number Must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s18,
                        ),
                        TFF(
                          controller: businessLicenseController,
                          label: 'Photo Of business License',
                          readOnly: true,
                          prefixIcon: Icons.photo_size_select_large,
                          suffix: Icons.add_photo_alternate_outlined,
                          suffixPressed: () async {
                            imageOfBusinessLicense = await takePhoto();
                            businessLicenseController.text =
                                "$imageOfBusinessLicense"
                                    .toString()
                                    .split("/")
                                    .last;
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Photo Of business License Must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s18,
                        ),
                        TFF(
                          controller: addressController,
                          label: 'Address',
                          prefixIcon: Icons.wallet_giftcard,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Address Must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s18,
                        ),
                        BlocConsumer<RegisterCubit, RegisterStates>(
                          listener: (context, state) {
                            if (state is MailVerificationErrorState) {
                              print(
                                  "****************************** ${state.error} *******************************");
                            }
                            if (state is MailVerificationDoneState) {
                              registerRequest.pin =
                                  state.mailVerificationResponse!.pin;
                              navigateTo(
                                context,
                                MailVerificationScreen(
                                  registerRequest: registerRequest,
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DefaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      registerRequest.fullName =
                                          fullNameController.text;
                                      registerRequest.phone =
                                          phoneController.text;
                                      registerRequest.email =
                                          emailController.text;
                                      registerRequest.password =
                                          passwordController.text;
                                      registerRequest.marketName =
                                          marketNameController.text;
                                      registerRequest.marketLogo =
                                          imageOfLogoOfMarket;
                                      registerRequest.iban =
                                          ibanContraller.text;
                                      registerRequest.nameOFBank =
                                          nameOFBankController.text;
                                      registerRequest.addressOfBank =
                                          addressOfBankController.text;
                                      registerRequest.nameOfBrand =
                                          nameOfBrandController.text;
                                      registerRequest.taxNumber =
                                          taxNumberController.text;
                                      registerRequest.businesslicense =
                                          imageOfBusinessLicense;
                                      registerRequest.address =
                                          addressController.text;

                                      RegisterCubit.get(context).sendCode2email(
                                          email: emailController.text.trim());
                                    }
                                  },
                                  text: 'Register',
                                  isLoading:
                                      state is MailVerificationLoadingState,
                                  isUpperCase: true,
                                ),
                                const SizedBox(
                                  height: AppSize.s4,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Have Account? ',
                                      style: getRegularStyle(
                                        fontSize: FontSize.s14,
                                        color: ColorManager.primary,
                                      ),
                                    ),
                                    DTextButton(
                                      text: 'login',
                                      function: () {
                                        print('Login Now===');
                                        navigateAndFinish(
                                            context, LoginScreen());
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }


}
