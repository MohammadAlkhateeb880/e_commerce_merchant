import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import 'package:merchant_app/core/components/loading.dart';
import '../../../../core/components/my_text.dart';
import '../../../../core/resources/string_manager.dart';
import 'orders_cubit/orders_cubit.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({
    Key? key,
    required this.orderId,
  }) : super(key: key);
  final String orderId;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}


class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    OrdersCubit.get(context).getOrderById(
      orderId: widget.orderId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MText(
          text: AppStrings.orderDetails,
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<OrdersCubit, OrdersStates>(
          listener: (context, state) {},
          builder: (context, state) {
            OrdersCubit cubit = OrdersCubit.get(context);
            if (state is GetSingleOrderByIdLoadingState) {
              return  DefaultLoading();
            } else {
              return Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                cubit.singleOrderResponse.data?.items != null,
                widgetBuilder: (context) {
                  return const SizedBox();
                  //   SingleOrderWidget(
                  //   data: cubit.singleOrderResponse.data,
                  // );
                },
                fallbackBuilder: (context) {
                  return Center(
                    child: MText(
                      text: 'No Details Yet!...',
                      notTR: true,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}