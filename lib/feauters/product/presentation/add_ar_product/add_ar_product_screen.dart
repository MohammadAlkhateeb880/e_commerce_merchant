import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/feauters/product/presentation/add_ar_product/ad_ar_product_cubit/add_ar_product_cubit.dart';

import '../../../../core/components/button.dart';
import '../../../../core/components/default_error.dart';
import 'package:merchant_app/core/components/loading.dart';
import '../../../../core/components/git_xfile.dart';
import '../../../../core/components/toast_notifications.dart';
import '../../../../core/functions.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../home/presentation/home_cubit/home_cubit.dart';
import '../add_vedio_product/add_video_product_screen.dart';

class AddARProductScreen extends StatefulWidget {
  const AddARProductScreen({Key? key, required this.idProduct})
      : super(key: key);
  final String idProduct;

  @override
  State<AddARProductScreen> createState() => _AddARProductScreenState();
}

class _AddARProductScreenState extends State<AddARProductScreen> {
  String? fileARPath;



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddARProductCubit(),
      child: BlocConsumer<AddARProductCubit, AddARProductStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          AddARProductCubit cubit = AddARProductCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text('ADD AR'),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      fileARPath = await pickXFile();
                      setState(() {});
                    },
                    child: const Text('Select AR'),
                  ),
                  fileARPath != null
                      ? Container(
                          child: Center(
                            child: state is AddARProductLoadingState
                                ? DefaultLoading()
                                : const SizedBox(
                                    width: 200.0,
                                    height: 200.0,
                                    child: Text('THis is AR'),
                                  ),
                          ),
                        )
                      : state is AddARProductErrorState
                          ? const DefaultError()
                          : const SizedBox(
                              width: 200.0,
                              height: 200.0,
                              child: Center(child: Text('No AR selected')),
                            ),
                  const SizedBox(
                    height: AppSize.s18,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: DefaultButton(
                      text: 'Send AR',
                      function: () {
                        if (fileARPath != null) {
                          cubit.addARProduct(
                              fileARPath: fileARPath, id: widget.idProduct);
                        } else {
                          showToast(
                              text: 'select AR', state: ToastStates.WARNING);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
