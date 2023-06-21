import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_dismissible_tile/flutter_dismissible_tile.dart';
import 'package:im_stepper/stepper.dart';
import 'package:lottie/lottie.dart';
import 'package:merchant_app/core/components/default_loading.dart';
import 'package:merchant_app/core/components/toast_notifications.dart';
import 'package:merchant_app/feauters/dispute/domin/response/get_all_dispute_response.dart';

import '../../../core/components/my_text.dart';
import '../../../core/components/pair_widget.dart';
import '../../../core/functions.dart';
import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/constants_manager.dart';
import '../../../core/resources/string_manager.dart';
import '../../../core/resources/values_manager.dart';
import 'dispute_cubit/dispute_cubit.dart';
import 'dispute_details.dart';

class DisputeScreen extends StatefulWidget {
  const DisputeScreen({Key? key}) : super(key: key);

  @override
  State<DisputeScreen> createState() => _DisputeScreenState();
}

class _DisputeScreenState extends State<DisputeScreen> {
  @override
  void initState() {
    print(Constants.email);
    print(Constants.token);
    print(Constants.sId);
    DisputeCubit.get(context)
        .getDisputes(merchant_id: Constants.sId);
    print(DisputeCubit.get(context).disputeList.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = DisputeCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disputes'),
      ),
      body: BlocConsumer<DisputeCubit, DisputeState>(
        listener: (context, state) {
          if (state is DeleteDisputeDoneState) {
            showToast(
                text: state.deleteDisputeResponse.message!,
                state: ToastStates.SUCCESS);
          }
        },
        builder: (context, state) {
          if (state is DisputeLoadingState) {
            return Center(child: DefaultLoading());
          }
          return Conditional.single(
              context: context,
              conditionBuilder: (context) =>
                  (cubit.disputeList.isNotEmpty || state is DisputeDoneState) &&
                  Constants.token.isNotEmpty,
              widgetBuilder: (context) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    print("++++++++++++++++++++++++++++");
                    return buildDisputeItem(
                        disputeData: cubit.disputeList[index]);
                  },
                  itemCount: cubit.disputeList.length,
                );
              },
              fallbackBuilder: (context) {
                if (cubit.disputeList.isEmpty) {
                  print("**********************");
                  return Lottie.asset(JsonAssets.empty);
                } else {
                  print("-------------------------");
                  return MText(
                    text: AppStrings.somethingsErrorPleaseCheckYourInternet,
                  );
                }
              });
        },
      ),
    );
  }

  List<String> status = ["pending", "underProcess", "resolve"];

  Widget buildDisputeItem({required Data disputeData}) {
  var cubit =  DisputeCubit.get(context);
    return Column(
      children: [
        BlocConsumer<DisputeCubit, DisputeState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = DisputeCubit.get(context);
            return IconStepper(
              activeStepBorderWidth: 1.5,
              lineLength: 90.0,
              stepPadding: 0.0,
              activeStepBorderColor: Colors.black54,
              stepColor: Colors.white60,
              activeStepColor: Colors.white,
              lineColor: Colors.amber,
              enableNextPreviousButtons: false,
              icons: const [
                Icon(Icons.pending_outlined),
                Icon(Icons.recycling_outlined),
                Icon(Icons.check_circle),
              ],
              activeStep: status.indexOf(disputeData.status!),
              onStepReached: (index) {
                setState(() {
                  if (index == 0) {
                    showToast(
                        text: 'cant put state dispute in pending',
                        state: ToastStates.WARNING);
                  }
                  if (index == 1) {
                    cubit.convertProcessDispute(dispute_id: disputeData.sId!);
                    disputeData.status = status[index];
                  }
                  if (index == 2) {
                    cubit.convertResolveDispute(dispute_id: disputeData.sId!);
                    disputeData.status = status[index];
                  }
                });

                print(index);
              },
            );
          },
        ),
        DismissibleTile(
          key: UniqueKey(),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          delayBeforeResize: const Duration(milliseconds: 500),
          ltrDismissedColor: Colors.redAccent,
          rtlDismissedColor: Colors.redAccent,
          ltrOverlay: const Text('Delete'),
          ltrOverlayDismissed: const Text('Delete'),
          rtlOverlay: const Text('Delete'),
          rtlOverlayDismissed: const Text('Deleted'),
          onDismissed: (_) async {
            await cubit.deleteDispute(dispute_id: disputeData.sId!);
            await cubit.getDisputes(merchant_id: Constants.sId);
            setState(() {});
          },

          child: GestureDetector(
            onTap: () {
              navigateTo(
                context,
                DisputeDetails(disputeData: disputeData),
              );
            },
            child: Card(
              child: Container(
                margin: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppMargin.m8, vertical: AppMargin.m8),
                decoration:
                    getDeco(color: ColorManager.white, withShadow: true),
                child: Column(
                  children: [
                    PairWidget(
                      label: 'name',
                      value: disputeData.firstName,
                      notTR: true,
                    ),
                    PairWidget(
                      label: 'email',
                      value: disputeData.email,
                      notTR: true,
                    ),
                    PairWidget(
                      label: 'phone',
                      value: disputeData.phone,
                      notTR: true,
                    ),
                    PairWidget(
                      label: 'type_User',
                      value: disputeData.typeUser,
                      notTR: true,
                    ),
                    PairWidget(
                      label: 'type_Dispute',
                      value: disputeData.typeDispute,
                      notTR: true,
                    ),
                    PairWidget(
                      label: 'status',
                      value: disputeData.status,
                      notTR: true,
                    ),
                    PairWidget(
                      label: 'message',
                      value: disputeData.message,
                      notTR: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
