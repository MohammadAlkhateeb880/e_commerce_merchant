import 'package:flutter/material.dart';
import 'package:merchant_app/core/resources/values_manager.dart';
import 'package:merchant_app/feauters/product/presentation/add_vr_product/add_vr_product_cubit/add_vr_product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/button.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
class AddVRProductScreen extends StatefulWidget {
  const AddVRProductScreen({Key? key}) : super(key: key);

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
                    fileVRPath= await pickVR();
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
                    cubit.addVRProduct(fileVRPath: fileVRPath, id: '6456666fb99083c1d94e8c4e');
                  }
                }),
              ],
            ),
          ),
        );
      },)
    );
  }

  Future<String?> pickVR() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // The user picked a file.
      final file = result.files.first;
      print(file.name);
      print(file.bytes);
      print(file.extension);
      print(file.path);
      print(file.size);
      return file.path;
      // Do something with the file, e.g. read its contents.
    } else {
      // The user canceled the picker.
      return null;
    }
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
