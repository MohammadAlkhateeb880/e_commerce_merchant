import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant_app/core/components/button.dart';
import 'package:merchant_app/core/resources/constants_manager.dart';
import 'package:merchant_app/core/resources/values_manager.dart';
import 'package:merchant_app/feauters/product/domin/add_product/request/add_image_request.dart';
import 'package:merchant_app/feauters/product/presentation/add_image_product/add_image_product_cubit/add_image_product_cubit.dart';
import 'package:merchant_app/feauters/product/presentation/add_image_product/add_image_product_cubit/add_image_product_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/get_photo_from_gallery.dart';
import '../../../../core/components/text_button.dart';
import '../../../../core/components/toast_notifications.dart';
import '../../../../core/functions.dart';
import '../../../home/presentation/home_cubit/home_cubit.dart';
import '../add_delivery_areas/add_delivery_areas_screen.dart';

class AddImageProductScreen extends StatefulWidget {
  const AddImageProductScreen({Key? key, required this.idProduct})
      : super(key: key);
  final String idProduct;

  @override
  _AddImageProductScreenState createState() => _AddImageProductScreenState();
}

class _AddImageProductScreenState extends State<AddImageProductScreen> {
  File? image;
  bool checkFull = true;
  AddImageProductRequest addImageProductRequest = AddImageProductRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add images Product'),
      ),
      body: BlocConsumer<AddImageProductCubit, AddImageProductStates>(
        listener: (context, state) {
          if (state is AddImageProductDoneState) {
            HomeCubit.get(context).getMerchantProducts(merchantId: Constants.sId);
            if (state.addImageProductResponse.status!) {
              showToast(
                  text: 'Add Images Done Success', state: ToastStates.SUCCESS);
            } else {
              showToast(
                  text: state.addImageProductResponse.message!,
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          var cubit = AddImageProductCubit.get(context);
          return SafeArea(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    image = await takePhoto();
                    setState(() {});
                  },
                  child: const Text('Select Main Image'),
                ),
                image != null
                    ? Container(
                        child: Image.file(image!),
                        width: 200.0,
                        height: 200.0,
                      )
                    : Container(
                        width: 200.0,
                        height: 200.0,
                        child: const Center(child: Text('No image selected')),
                      ),
                ElevatedButton(
                  onPressed: () {
                    selectImages();
                    setState(() {});
                  },
                  child: const Text('Select Gallery Images'),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p4),
                    child: GridView.builder(
                        itemCount: imageFileList!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: AppPadding.p4,
                                crossAxisSpacing: AppPadding.p4,
                                crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return Image.file(
                            File(imageFileList![index].path),
                            fit: BoxFit.cover,
                          );
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: DefaultButton(
                      text: 'Confirm',
                      function: () async {
                        if (image != null && imageFileList!.isNotEmpty) {
                          addImageProductRequest.mainImage = image;
                          addImageProductRequest.gallery = imageFileList;

                          Map<String, dynamic> test =
                              await addImageProductRequest.toJson(
                            mainImage: addImageProductRequest.mainImage,
                            gallery: addImageProductRequest.gallery,
                          );
                          print(' _++++++++++++++++++ ___++++++++');
                          print(test);

                          cubit.addImageProduct(
                            addImageProductRequest: addImageProductRequest,
                            id: widget.idProduct,
                          );
                        }
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  final ImagePicker imagePicker = ImagePicker();
  List<File>? imageFileList = [];

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.length > 2) {
      showToast(state: ToastStates.ERROR, text: 'just select two images');
    } else if (selectedImages.isNotEmpty) {
      if (imageFileList!.length >= 3) {
        // replace the first three images with the newly selected ones
        imageFileList!.replaceRange(
            0,
            3,
                selectedImages.map((image) {
              return File(image.path);
            }).toList());
      } else {
        // add the newly selected images to the list
        imageFileList!.addAll(selectedImages.map((image) {
          return File(image.path);
        }).toList());
      }
    }
    setState(() {});
  }
}
