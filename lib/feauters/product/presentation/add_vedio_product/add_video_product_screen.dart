import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:merchant_app/core/components/default_error.dart';
import 'package:merchant_app/core/components/default_loading.dart';
import 'package:merchant_app/core/components/git_xfile.dart';
import 'package:merchant_app/core/components/toast_notifications.dart';
import 'package:merchant_app/feauters/product/presentation/add_vedio_product/add_video_product_cubit/add_video_product_cubit.dart';

import '../../../../core/components/button.dart';
import '../../../../core/functions.dart';
import '../../../../core/resources/values_manager.dart';
import '../add_image_product/add_image_product_screen.dart';

class AddVideoProductScreen extends StatefulWidget {
  const AddVideoProductScreen({Key? key, required this.idProduct}) : super(key: key);
  final String idProduct;
  @override
  State<AddVideoProductScreen> createState() => _AddVideoProductScreenState();
}

class _AddVideoProductScreenState extends State<AddVideoProductScreen> {
  String? fileVideoPath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddVideoProductCubit(),
      child: BlocConsumer<AddVideoProductCubit, AddVideoProductStates>(
        listener: (context, state) {
          if (state is AddVideoProductDoneState) {
            // navigateTo(context, AddImageProductScreen());
          }
        },
        builder: (context, state) {
          var cubit = AddVideoProductCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text('ADD Video'),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      fileVideoPath = await pickXFile();
                      setState(() {});
                    },
                    child: const Text('Select Video'),
                  ),
                  fileVideoPath != null
                      ? Container(
                    child: Center(
                        child: state is AddVideoProductLoadingState
                            ? DefaultLoading()
                            : const Text('THis is video')),
                  )
                      : state is AddVideoProductErrorState
                      ? const DefaultError()
                      : const SizedBox(
                    width: 200.0,
                    height: 200.0,
                    child: Center(child: Text('No Video selected')),
                  ),
                  const SizedBox(
                    height: AppSize.s18,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: DefaultButton(
                      text: 'Send Video',
                      function: () {
                        if (fileVideoPath != null) {
                          cubit.addVideoProduct(
                              fileVideoPath: fileVideoPath,
                              id: widget.idProduct);
                        }else{
                          showToast(text: 'select video', state: ToastStates.WARNING);
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
