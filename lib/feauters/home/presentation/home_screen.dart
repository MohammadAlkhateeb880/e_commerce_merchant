import 'package:flutter/material.dart';
import 'package:merchant_app/core/components/default_loading.dart';
import 'package:merchant_app/core/resources/values_manager.dart';
import 'package:merchant_app/feauters/home/presentation/home_cubit/home_cubit.dart';
import 'package:merchant_app/feauters/home/presentation/home_cubit/widget_home_screen/add_dialog.dart';
import 'package:merchant_app/feauters/product/presentation/add_offer_to_product/add_offer_to_product_screen.dart';

import '../../../core/components/my_divider.dart';
import '../../../core/components/text_form_field.dart';
import '../../../core/config/urls.dart';
import '../../../core/functions.dart';
import '../../../core/resources/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domin/response/get_merchant_response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> selectedIndices = [];
  bool isSelectionMode = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        if (state is GetMerchantProLoadingState) {
          return Center(
            child: DefaultLoading(),
          );
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p4),
            child: GestureDetector(
              onLongPress: () {
                setState(() {
                  isSelectionMode = true;
                });
              },
              child: Column(
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cubit.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      var product = cubit.products[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text('${product.name}'),
                            subtitle: Text('${product.manufacturingMaterial}'),
                            leading: const Icon(Icons.photo),
                            trailing: isSelectionMode
                                ? Checkbox(
                                    value: selectedIndices.contains(index),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == false) {
                                          selectedIndices.remove(index);
                                          if (selectedIndices.isEmpty) {
                                            isSelectionMode = false;
                                          }
                                        }
                                      });
                                    },
                                  )
                                : buildPopupMenuButton(context, index),
                            onTap: () {
                              if (isSelectionMode) {
                                setState(() {
                                  if (selectedIndices.contains(index)) {
                                    selectedIndices.remove(index);
                                  } else {
                                    selectedIndices.add(index);
                                  }
                                  if (selectedIndices.isEmpty) {
                                    isSelectionMode = false;
                                  }
                                });
                              }
                            },
                            onLongPress: () {
                              setState(() {
                                isSelectionMode = true;
                                selectedIndices.add(index);
                              });
                            },
                            selected: isSelectionMode &&
                                selectedIndices.contains(index),
                          ),
                          MyDivider(
                            margin: 8.0,
                            width: getScreenWidth(context) / 1.2,
                            alignment: AlignmentDirectional.centerStart,
                            color: ColorManager.lightPrimary,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future addToHotSelling(String productId) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AddDialogHotSelling(
          productId: productId,
        );
      },
    );
  }

  Widget buildPopupMenuButton(BuildContext context, int index) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'option1',
          child: Text('edit'),
        ),
        const PopupMenuItem<String>(
          value: 'option2',
          child: Text('add offer'),
        ),
        const PopupMenuItem<String>(
          value: 'option3',
          child: Text('add to hot Selling'),
        ),
      ],
      onSelected: (String result) {
        switch (result) {
          case 'option2':
            navigateTo(
                context,
                AddOfferToProductScreen(
                  productsIds: [HomeCubit.get(context).products[index].sId!],
                ));
            break;
          case 'option3':
            addToHotSelling(HomeCubit.get(context).products[index].sId!);
            break;
          default:
            // Do something when an option is selected
            break;
        }
      },
    );
  }
}
