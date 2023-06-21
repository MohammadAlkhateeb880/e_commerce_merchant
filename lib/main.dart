import 'package:flutter/material.dart';
import 'package:merchant_app/core/bloc_observer.dart';
import 'package:merchant_app/core/components/button.dart';
import 'package:merchant_app/core/network/local/keys.dart';
import 'package:merchant_app/core/resources/constants_manager.dart';
import 'package:merchant_app/feauters/authintication/presentation/login/login_screen.dart';
import 'package:merchant_app/feauters/authintication/presentation/register/register_screen.dart';
import 'package:merchant_app/feauters/product/presentation/add_image_product/add_image_product_cubit/add_image_product_cubit.dart';
import 'package:merchant_app/feauters/product/presentation/add_vedio_product/add_video_product_cubit/add_video_product_cubit.dart';
import 'core/data/network/local/cache_helper.dart';
import 'core/data/network/remote/dio_helper.dart';
import 'core/resources/theme_manager.dart';
import 'package:wiredash/wiredash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feauters/authintication/presentation/register/register_cubit/register_cubit.dart';
import 'feauters/dispute/presentation/dispute_cubit/dispute_cubit.dart';
import 'feauters/home/presentation/home_cubit/home_cubit.dart';
import 'feauters/layouts/home_leyout/home_layout_cubit/home_layout_cubit.dart';
import 'feauters/layouts/home_leyout/home_layout_screen.dart';
import 'feauters/order/presentation/orders/orders_cubit/orders_cubit.dart';
import 'feauters/product/presentation/add_product/add_product_cubit/add_product_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Constants.token = CacheHelper.getData(key: CacheHelperKeys.token);
  Constants.sId = CacheHelper.getData(key: CacheHelperKeys.sId);
  Constants.email = CacheHelper.getData(key: CacheHelperKeys.email);
  Constants.fullName = CacheHelper.getData(key: CacheHelperKeys.fullName);
  //Constants.phone = CacheHelper.getData(key: CacheHelperKeys.phone);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _navigateKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => RegisterCubit()),
        BlocProvider(create: (BuildContext context) => AddImageProductCubit()),
        BlocProvider(create: (BuildContext context) => OrdersCubit()),
        //her is warning replace id with Constant.Id
        BlocProvider(
            create: (BuildContext context) => AddProductionCubit()
              ..getMerchantCategories(
                  merchantId: CacheHelper.getData(key: CacheHelperKeys.sId))),
        BlocProvider(
            create: (BuildContext context) => HomeLayoutCubit()..getProfile()),
        BlocProvider(
          create: (BuildContext context) =>
              HomeCubit()..getMerchantProducts(merchantId: Constants.sId),
        ),
        BlocProvider(
            create: (context) => DisputeCubit()
              ..getDisputes(merchant_id: Constants.sId)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigateKey,
        title: 'Merchant App',
        theme: getApplicationTheme(),
        home: Constants.token.isNotEmpty
            ? const HomeLayoutScreen()
            : const LoginScreen(),
      ),
    );
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Center(
            child: DefaultButton(
                function: () {
                  HomeCubit.get(context).getMerchantProducts(
                    merchantId: Constants.token,
                  );
                },
                text: 'Test'),
          );
        },
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
