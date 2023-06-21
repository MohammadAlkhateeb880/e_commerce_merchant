import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:merchant_app/core/components/default_image.dart';
import 'package:merchant_app/core/components/default_loading.dart';
import 'package:merchant_app/core/components/text_form_field.dart';
import 'package:merchant_app/core/components/toast_notifications.dart';
import 'package:merchant_app/core/resources/values_manager.dart';
import 'package:merchant_app/feauters/dispute/domin/response/get_all_dispute_response.dart';
import 'package:intl/intl.dart';
import '../../../core/components/my_text.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/styles_manager.dart';
import 'dispute_cubit/dispute_cubit.dart';

class DisputeDetails extends StatefulWidget {
  DisputeDetails({Key? key, required this.disputeData}) : super(key: key);
  Data disputeData;

  @override
  State<DisputeDetails> createState() => _DisputeDetailsState();
}

class _DisputeDetailsState extends State<DisputeDetails> {
  final TextEditingController _messageController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = DisputeCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispute Details'),
      ),
      body: BlocConsumer<DisputeCubit, DisputeState>(
        listener: (context, state) {
          if (state is SendCommentDisputeDoneState) {
            showToast(
                text: state.sendCommentDisputeResponse.message!,
                state: ToastStates.SUCCESS);
          }
          if (state is GetDisputeByIdDoneState) {
            setState(() {
              widget.disputeData = state.getDisputeByIdResponse;
            });
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: DefaultImage(
                    imageUrl: widget.disputeData.disputeImage,
                    clickable: true,
                    width: AppSize.s200,
                    height: AppSize.s260,
                  ),
                ),
                const SizedBox(
                  height: AppSize.s16,
                ),
                MText(
                  text: widget.disputeData.message ?? '',
                  style: getBoldStyle(
                    fontSize: 16.0,
                    color: ColorManager.primary,
                  ),
                ),
                const SizedBox(
                  height: AppSize.s16,
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Container(
                          color: Colors.grey.withOpacity(0.1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.disputeData.firstName ?? ""),
                              Text(
                                widget.disputeData.notes?[index].message ?? '',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Text(
                          formatDateTime(
                              widget.disputeData.notes?[index].createdAt ?? ''),
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                    itemCount: widget.disputeData.notes?.length,
                  ),
                ),
                SizedBox(
                  height: AppSize.s16,
                  child: (state is GetDisputeByIdLoadState)
                      ? DefaultLoading()
                      : Container(),
                ),
                const SizedBox(height: AppSize.s16),
                TFF(
                  controller: _messageController,
                  label: 'Type a message',
                  prefixIcon: Icons.message,
                  suffix: Icons.send_outlined,
                  suffixPressed: () async {
                    cubit.sendComment(
                        dispute_id: widget.disputeData.sId!,
                        comment: _messageController.text);
                    cubit.getDisputesById(dispute_id: widget.disputeData.sId!);
                    _messageController.clear();
                    FocusScope.of(context).unfocus();
                    setState(() {});
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Your Message is empty';
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    return '$formattedDate $formattedTime';
  }
}
