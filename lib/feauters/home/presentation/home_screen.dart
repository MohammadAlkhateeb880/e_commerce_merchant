import 'package:flutter/material.dart';
import 'package:merchant_app/core/components/loading.dart';
import 'package:merchant_app/core/resources/values_manager.dart';
import 'package:merchant_app/feauters/home/presentation/home_cubit/home_cubit.dart';

import '../../../core/components/build_popup_menu_button.dart';
import '../../../core/components/default_image.dart';
import '../../../core/components/my_divider.dart';
import '../../../core/components/text_form_field.dart';
import '../../../core/config/urls.dart';
import '../../../core/functions.dart';
import '../../../core/resources/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/resources/constants_manager.dart';
import '../../layouts/home_leyout/home_layout_cubit/home_layout_cubit.dart';
import '../../product/presentation/add_ar_product/add_ar_product_screen.dart';
import '../../product/presentation/product_details/details_screen.dart';
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

  Future<void> _fetchProducts() async {
    // Dispatch an event to fetch the profile data
    await BlocProvider.of<HomeCubit>(context)
        .getMerchantProducts(merchantId: Constants.sId);
  }

  @override
  void initState() {

     setState(() {
       HomeLayoutCubit().getProfile();
     });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        // if (state is GetMerchantProLoadingState) {
        //   return Center(
        //     child: DefaultLoading(),
        //   );
        // }
        return RefreshIndicator(
          onRefresh: _fetchProducts,
          child: SingleChildScrollView(
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
                    for (int index = 0; index < cubit.products.length; index++)
                      Column(
                        children: [
                          ListTile(
                            title: Text('${cubit.products[index].name}'),
                            subtitle: Text('${cubit.products[index].manufacturingMaterial}'),
                            leading: DefaultImage(
                              width: 50.0,
                              height: 50.0,
                              imageUrl: cubit.products[index].mainImage ?? ' ',
                              clickable: true,
                            ),
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
                              navigateTo(
                                context,
                                DetailsScreen(
                                  proId: cubit.products[index].sId,
                                  mainImageUrl: cubit.products[index].mainImage,
                                ),
                              );
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
                            selected: isSelectionMode && selectedIndices.contains(index),
                          ),
                          MyDivider(
                            margin: 8.0,
                            width: getScreenWidth(context) / 1.2,
                            alignment: AlignmentDirectional.centerStart,
                            color: ColorManager.lightPrimary,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        );

      },
    );
  }
}
