import 'package:flutter/material.dart';
import 'package:merchant_app/core/resources/values_manager.dart';
import 'package:merchant_app/feauters/product/presentation/add_image_product/add_image_product_screen.dart';
import 'package:merchant_app/feauters/product/presentation/add_vedio_product/add_video_product_screen.dart';
import 'package:merchant_app/feauters/product/presentation/add_vr_product/add_vr_product_cubit/add_vr_product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/button.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../../../../core/components/git_xfile.dart';
import '../../../../core/functions.dart';
class AddVRProductScreen extends StatefulWidget {
  const AddVRProductScreen({Key? key, required this.idProduct}) : super(key: key);
  final String idProduct;
  @override
  // ignore: library_private_types_in_public_api
  _AddVRProductScreenState createState() => _AddVRProductScreenState();
}

class _AddVRProductScreenState extends State<AddVRProductScreen> {
  String? fileVRPath;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddVRProductCubit(),

      child: BlocConsumer<AddVRProductCubit,AddVRProductStates>(listener: (context,state){},
      builder: (context,state){
        AddVRProductCubit cubit = AddVRProductCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('ADD VR'),
          ),
          body: SafeArea(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    fileVRPath= await pickXFile();
                    setState(() {});
                  },
                  child: const Text('Select VR'),
                ),
                fileVRPath!=null ? Container(): Container(
                  width: 200.0,
                  height: 200.0,
                  child: const Center(child: Text('No image selected')),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),
                DefaultButton(text: 'Send VR', function: ()  {
                  if(fileVRPath!=null){
                    cubit.addVRProduct(fileVRPath: fileVRPath, id: widget.idProduct);
                  }
                }),
              ],
            ),
          ),
        );
      },)
    );
  }



  // void _onARCoreViewCreated(ArCoreController controller) {
  //
  //   controller.addArCoreNodeWithAnchor(
  //     ArCoreNode(
  //       shape: ArCoreModel(
  //         uri: fileVRPath,
  //         modelType: ArCoreModelType.LGB,
  //         scale: Vector3(0.2, 0.2, 0.2),
  //       ),
  //     ),
  //   );
  // }
  // void _onArCoreViewCreated(ArCoreController controller) {
  //   ArCoreController  arCoreController = controller;
  //
  //   _addSphere(arCoreController);
  //
  // }
  //
  // void _addSphere(ArCoreController controller) {
  //   final material = ArCoreMaterial(
  //       color: Color.fromARGB(120, 66, 134, 244));
  //   final sphere = ArCoreSphere(
  //     materials: [material],
  //     radius: 0.1,
  //   );
  //   final node = ArCoreNode(
  //     shape: sphere,
  //     position: vector.Vector3(0, 0, -1.5),
  //   );
  //   controller.addArCoreNode(node);
  // }

}
