import 'package:flutter/material.dart';
import 'package:merchant_app/core/bloc_observer.dart';
import 'package:merchant_app/core/resources/constants_manager.dart';
import 'package:merchant_app/feauters/authintication/presentation/login/login_screen.dart';
import 'package:merchant_app/feauters/authintication/presentation/register/register_screen.dart';
import 'package:merchant_app/feauters/product/presentation/add_image_product/add_image_product_cubit/add_image_product_cubit.dart';
import 'core/data/network/local/cache_helper.dart';
import 'core/data/network/remote/dio_helper.dart';
import 'core/resources/theme_manager.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'feauters/authintication/presentation/register/register_cubit/register_cubit.dart';
import 'feauters/home/presentation/home_cubit/home_cubit.dart';
import 'feauters/layouts/home_leyout/home_layout_cubit/home_layout_cubit.dart';
import 'feauters/layouts/home_leyout/home_layout_screen.dart';
import 'feauters/product/presentation/add_category/add_category_screen.dart';
import 'feauters/product/presentation/add_delivery_areas/add_delivery_areas_screen.dart';
import 'feauters/product/presentation/add_offer_to_product/add_offer_to_product_screen.dart';
import 'feauters/product/presentation/add_product/add_product_cubit/add_product_cubit.dart';
import 'feauters/product/presentation/add_product/add_product_screen.dart';
import 'feauters/product/presentation/add_vedio_product/add_video_product_screen.dart';
import 'feauters/product/presentation/add_vr_product/add_vr_product_screen.dart';

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
        BlocProvider(create: (BuildContext context) => AddImageProductCubit()),
        //her is warning replace id with Constant.Id
        BlocProvider(create: (BuildContext context) => AddProductionCubit()..getMerchantCategories(merchantId: '64623af8d50f6f303d1aeefe')),
        BlocProvider(create: (BuildContext context) => HomeLayoutCubit()..getProfile()),
        BlocProvider(create: (BuildContext context) => HomeCubit()..getMerchantProducts(merchantId: '64623af8d50f6f303d1aeefe')),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Merchant App',
        theme: getApplicationTheme(),
        // showSemanticsDebugger: true,
        home:   const AddVideoProductScreen(),
      ),
    );
  }
}

/**
    flutter channel stable
    flutter upgrade
    flutter pub upgrade
    // Questions :


 */

// FilePicker   [.jpg, .png, .] .................
/*
import 'package:flutter/material.dart';

class Person {
  final String name;
  final int age;
  final String address;

  Person({
    required this.name,
    required this.age,
    required this.address,
  });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Person> persons = [
    Person(name: 'John', age: 25, address: '123 Main St'),
    Person(name: 'Jane', age: 30, address: '456 Oak St'),
    Person(name: 'Bob', age: 40, address: '789 Maple St'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person List'),
      ),
      body: ListView.builder(
        itemCount: persons.length,
        itemBuilder: (context, index) {
          final person = persons[index];
          return ListTile(
            title: Text(person.name),
            subtitle: Text('Age ${person.age}, Address: ${person.address}'),
          );
        },
      ),
    );
  }
}

*
* */
