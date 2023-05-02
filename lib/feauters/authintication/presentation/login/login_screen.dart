import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/core/resources/constants_manager.dart';
import 'package:merchant_app/feauters/authintication/domin/request/login_request.dart';
import 'package:merchant_app/feauters/authintication/domin/response/login_response.dart';
import 'package:merchant_app/feauters/authintication/presentation/login/login_cubit/login_cubit.dart';

import '../../../../core/components/button.dart';
import '../../../../core/components/text_button.dart';
import '../../../../core/components/text_form_field.dart';
import '../../../../core/components/toast_notifications.dart';
import '../../../../core/data/network/local/cache_helper.dart';
import '../../../../core/functions.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/fonts_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../home/home_screen.dart';
import '../register/register_screen.dart';
import 'login_cubit/login_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginRequest loginRequest =
      LoginRequest(nameOrEmail: "empty", password: "empty");
  var formKey = GlobalKey<FormState>();
  TextEditingController fullNameOrEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child:
            BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {
          if (state is LoginDoneState) {
            if (state.loginResponse.status == true) {
              showToast(text: 'Login Success', state: ToastStates.SUCCESS);
              CacheHelper.saveData(key: 'token', value: state.loginResponse.data?.token).then((value) {
                Constants.token=state.loginResponse.data!.token!;
              });
              navigateAndFinish(context, HomeScreen());
            }else{
              showToast(text:state.loginResponse.message!, state: ToastStates.ERROR);
            }

          }
        }, builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p12),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "welcome back",
                        style: TextStyle(
                          color: ColorManager.primary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s40,
                      ),
                      TFF(
                        controller: fullNameOrEmailController,
                        label: 'Name or Email',
                        prefixIcon: Icons.email_outlined,
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
                            return 'Password Must not be empty';
                          }
                        },
                      ),
                      const SizedBox(
                        height: AppSize.s18,
                      ),
                      DefaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            loginRequest.nameOrEmail =
                                fullNameOrEmailController.text.trim();
                            loginRequest.password = passwordController.text;
                            LoginCubit.get(context)
                                .login(loginRequest: loginRequest);
                          }
                        },
                        text: 'Login',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account? ',
                            style: getRegularStyle(
                              fontSize: FontSize.s14,
                              color: ColorManager.primary,
                            ),
                          ),
                          DTextButton(
                            text: 'Register',
                            function: () {
                              print('Register Now===');
                              navigateAndFinish(
                                  context, const RegisterScreen());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
