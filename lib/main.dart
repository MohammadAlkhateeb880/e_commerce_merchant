import 'package:flutter/material.dart';
import 'package:merchant_app/core/bloc_observer.dart';
import 'package:merchant_app/feauters/authintication/presentation/login/login_screen.dart';
import 'package:merchant_app/feauters/authintication/presentation/register/register_screen.dart';
import 'core/data/network/local/cache_helper.dart';
import 'core/data/network/remote/dio_helper.dart';
import 'core/resources/theme_manager.dart';


import 'package:flutter_bloc/flutter_bloc.dart';

import 'feauters/authintication/presentation/register/register_cubit/register_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => RegisterCubit()),
      ],
      child: MaterialApp(
        title: 'Merchant App',
        theme: getApplicationTheme(),
       // showSemanticsDebugger: true,
        home: const LoginScreen(),
      ),
    );
  }
}

/**
    flutter channel stable
    flutter upgrade
    flutter pub upgrade

 */

// FilePicker   [.jpg, .png, .] .................
