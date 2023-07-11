import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:im_stepper/stepper.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/components/button.dart';
import 'package:merchant_app/core/components/loading.dart';
import '../../../../core/components/my_text.dart';
import '../../../../core/components/pair_widget.dart';
import '../../../../core/functions.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../authintication/presentation/login/login_screen.dart';
import '../../domin/response/get_orders_response.dart';
import 'order_details_screen.dart';
import 'orders_cubit/orders_cubit.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int index = 0;
  @override
  void initState() {
    super.initState();
    if (Constants.token.isNotEmpty) {
      OrdersCubit.get(context).getUserOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MText(text: AppStrings.yourOwnOrders),
        actions: [
          IconButton(
            onPressed: () {
              // navigateTo(context, const OrderSearchScreen());
            },
            icon: const Icon(
              CupertinoIcons.search,
            ),
          ),
        ],
      ),
      body: BlocConsumer<OrdersCubit, OrdersStates>(
        listener: (context, state) {},
        builder: (context, state) {
          OrdersCubit cubit = OrdersCubit.get(context);
          if (state is GetOrdersLoadingState) {
            return DefaultLoading();
          } else {
            return Conditional.single(
              context: context,
              conditionBuilder: (context) =>
                  (cubit.orders.isNotEmpty || state is GetOrdersDoneState) &&
                  Constants.token.isNotEmpty,
              widgetBuilder: (context) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildOrderItem(orderData: cubit.orders[index]);
                  },
                  itemCount: cubit.orders.length,
                );
              },
              fallbackBuilder: (context) {
                if (Constants.token.isEmpty) {
                  return Column(
                    children: [
                      Lottie.asset(JsonAssets.login),
                      DefaultButton(
                        function: () {
                          navigateTo(
                            context,
                            const LoginScreen(),
                          );
                        },
                        text: AppStrings.login,
                      ),
                    ],
                  );
                } else {
                  if (cubit.orders.isEmpty) {
                    return Lottie.asset(JsonAssets.empty);
                  } else {
                    return MText(
                      text: AppStrings.somethingsErrorPleaseCheckYourInternet,
                    );
                  }
                }
              },
            );
          }
        },
      ),
    );
  }

  List<String> status = [
    "pending",
    "processing",
    "shipped",
    "delivered",
    "cancelled"
  ];
  bool checkDone = false;
  bool checkLoading = false;
  bool checkError = false;
  bool boolean = false;
  String? ss;

  Widget buildOrderItem({required OrderData orderData}) {
    var cubit = OrdersCubit.get(context);

    return Column(
      children: [
        Container(
          height: 60.0,
          child: BlocConsumer<OrdersCubit, OrdersStates>(
            listener: (context, state) {},
            builder: (context, state) {
              //her check if merchant cancelled order
              return IconStepper(
                activeStepBorderWidth: 1.5,
                lineLength: 20.0,
                stepPadding: 0.0,
                activeStepBorderColor: Colors.black54,
                stepColor: Colors.white60,
                activeStepColor: Colors.white,
                lineColor: Colors.amber,
                enableNextPreviousButtons: false,
                icons: const [
                  Icon(Icons.pending_outlined),
                  Icon(Icons.flag),
                  Icon(Icons.local_shipping_outlined),
                  Icon(Icons.delivery_dining),
                  Icon(Icons.cancel_outlined),
                ],
                activeStep: status.indexOf(orderData.status!),
                onStepReached: (index) {
                  setState(() {
                    cubit.changeOrderStates(
                        orderId: orderData.sId!, status: status[index]);
                    orderData.status = status[index];
                  });

                  print(index);
                },
              );
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            navigateTo(
              context,
              OrderDetailsScreen(
                orderId: orderData.sId ?? '',
              ),
            );
          },
          child: Card(
            child: Container(
              margin: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppMargin.m8, vertical: AppMargin.m8),
              decoration: getDeco(color: ColorManager.white, withShadow: true),
              child: Column(
                children: [
                  PairWidget(
                    label: AppStrings.orderOwner,
                    value: orderData.userInfo?.firstName,
                    notTR: true,
                  ),
                  PairWidget(
                    label: AppStrings.orderLocation,
                    value:
                        '${orderData.shippingAddress?.country} - ${orderData.shippingAddress?.city} - ${orderData.shippingAddress?.region}',
                    notTR: true,
                  ),
                  PairWidget(
                    label: AppStrings.streetNumber,
                    value: orderData.shippingAddress?.streetNumber.toString(),
                    notTR: true,
                  ),
                  PairWidget(
                    label: AppStrings.houseNumber,
                    value: orderData.shippingAddress?.houseNumber.toString(),
                    notTR: true,
                  ),
                  PairWidget(
                    label: AppStrings.orderStatus,
                    value: orderData.status,
                    notTR: true,
                  ),
                  PairWidget(
                    label: AppStrings.totalPrice,
                    value: orderData.totalPrice.toString(),
                    notTR: true,
                  ),
                  PairWidget(
                    label: AppStrings.description,
                    value: orderData.shippingAddress?.description,
                    notTR: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
