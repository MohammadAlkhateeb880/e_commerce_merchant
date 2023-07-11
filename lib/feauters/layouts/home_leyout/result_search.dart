import 'package:flutter/material.dart';
import 'package:merchant_app/core/components/default_error.dart';
import 'package:merchant_app/core/components/loading.dart';
import 'package:merchant_app/core/resources/constants_manager.dart';

import '../../../core/components/build_popup_menu_button.dart';
import '../../../core/components/button.dart';
import '../../../core/components/default_image.dart';
import '../../../core/components/text_form_field.dart';
import '../../../core/resources/values_manager.dart';
import '../../home/domin/request/advanced_search_request.dart';
import '../../home/domin/response/advanced_search_response.dart';
import '../../home/presentation/home_cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../product/presentation/add_product/add_product_cubit/add_product_cubit.dart';

class ResultSearch extends StatefulWidget {
  ResultSearch({
    Key? key,
    required this.query,
  }) : super(key: key);
  final String query;

  @override
  State<ResultSearch> createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {
  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).advancedSearch(
        ownerId: Constants.sId,
        advancedSearchRequest: AdvancedSearchRequest(name: widget.query));
  }

  TextEditingController priceOfProductController = TextEditingController();
  TextEditingController manufacturingMaterialOfProductController =
  TextEditingController();
  AdvancedSearchRequest advancedSearchRequest = AdvancedSearchRequest(name: '');
  var categories = [];
  String? dropdownvalue;
  bool isCheckBoxChecked = false;
  List<String> colors = ['Any Color', 'red', 'blue', 'white', 'black'];
  String selectedColor = 'Any Color';

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    var addProductionCubit = AddProductionCubit.get(context);
    //her is warning check if language is english and replace category.arName with category.enName
    categories = addProductionCubit.enCategories;
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AdvancedSearchLoadingState) {
          return Center(child: DefaultLoading());
        }
        if (state is AdvancedSearchErrorState) {
          const Center(child: DefaultError());
        }

        if (HomeCubit
            .get(context)
            .products == null ||
            HomeCubit
                .get(context)
                .products
                .isEmpty) {
          return Center(
            child: Text('No search results for "${widget.query}".'),
          );
        }
        // Handle null or empty search query
        if (widget.query == null || widget.query.isEmpty) {
          return const Center(
            child: Text('Please enter a search query.'),
          );
        }


        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(AppPadding.p4),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: AppSize.s4,
                      ),
                      const Text(
                        'Home Page',
                        style: TextStyle(fontSize: 12.0),
                      ),
                      Checkbox(
                        value: isCheckBoxChecked,
                        // Set the checkbox value to the boolean variable.
                        onChanged: (value) {
                          // Define a function to handle checkbox changes.
                          setState(() {
                            advancedSearchRequest.name = widget.query;
                            advancedSearchRequest.price =
                            priceOfProductController.text.isEmpty
                                ? null
                                : int.parse(priceOfProductController.text);
                            advancedSearchRequest.mainCategorie =
                            (dropdownvalue == categories.first)
                                ? null
                                : dropdownvalue;
                            advancedSearchRequest.manufacturingMaterial =
                            manufacturingMaterialOfProductController
                                .text.isEmpty
                                ? null
                                : manufacturingMaterialOfProductController
                                .text;
                            isCheckBoxChecked = value!;
                            advancedSearchRequest.color =
                            (selectedColor == colors.first)
                                ? null
                                : selectedColor;
                            advancedSearchRequest.homePage = isCheckBoxChecked;
                            cubit.advancedSearch(
                                ownerId: Constants.sId,
                                advancedSearchRequest: advancedSearchRequest);
                          });
                        },
                      ),
                      const SizedBox(
                        width: AppSize.s4,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white60),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.all(AppPadding.p18),
                                  child: Column(
                                    children: [
                                      TFF(
                                        controller: priceOfProductController,
                                        label: 'price',
                                        prefixIcon: Icons.attach_money_outlined,
                                        suffix: Icons.clear,
                                        suffixPressed: () {
                                          priceOfProductController.clear();
                                        },
                                        keyboardType: TextInputType.number,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return 'price Must not be empty';
                                          }
                                        },
                                      ),
                                      Spacer(),
                                      DefaultButton(
                                        function: () {
                                          advancedSearchRequest.name =
                                              widget.query;
                                          advancedSearchRequest.price =
                                          priceOfProductController
                                              .text.isEmpty
                                              ? null
                                              : int.parse(
                                              priceOfProductController
                                                  .text);
                                          advancedSearchRequest.mainCategorie =
                                          (dropdownvalue ==
                                              categories.first)
                                              ? null
                                              : dropdownvalue;
                                          advancedSearchRequest
                                              .manufacturingMaterial =
                                          manufacturingMaterialOfProductController
                                              .text.isEmpty
                                              ? null
                                              : manufacturingMaterialOfProductController
                                              .text;
                                          advancedSearchRequest.color =
                                          (selectedColor == colors.first)
                                              ? null
                                              : selectedColor;
                                          advancedSearchRequest.homePage =
                                              isCheckBoxChecked;
                                          cubit.advancedSearch(
                                              ownerId:
                                              Constants.sId,
                                              advancedSearchRequest:
                                              advancedSearchRequest);
                                          Navigator.pop(context);
                                        },
                                        text: 'search',
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Row(
                            children: const [
                              Text('price'),
                              SizedBox(
                                width: AppSize.s4,
                              ),
                              Icon(Icons.attach_money_outlined),
                            ],
                          )),
                      const SizedBox(
                        width: AppSize.s4,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white60,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.all(AppPadding.p8),
                                  child: Column(
                                    children: [
                                      TFF(
                                        controller:
                                        manufacturingMaterialOfProductController,
                                        label: 'Manufacturing Material',
                                        prefixIcon: Icons
                                            .precision_manufacturing_outlined,
                                        suffix: Icons.clear,
                                        suffixPressed: () {
                                          manufacturingMaterialOfProductController
                                              .clear();
                                        },
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return 'Manufacturing Material Of Product Must not be empty';
                                          }
                                        },
                                      ),
                                      Spacer(),
                                      DefaultButton(
                                        function: () {
                                          advancedSearchRequest.name =
                                              widget.query;
                                          advancedSearchRequest.price =
                                          priceOfProductController
                                              .text.isEmpty
                                              ? null
                                              : int.parse(
                                              priceOfProductController
                                                  .text);
                                          advancedSearchRequest.mainCategorie =
                                          (dropdownvalue ==
                                              categories.first)
                                              ? null
                                              : dropdownvalue;
                                          advancedSearchRequest
                                              .manufacturingMaterial =
                                          manufacturingMaterialOfProductController
                                              .text.isEmpty
                                              ? null
                                              : manufacturingMaterialOfProductController
                                              .text;
                                          advancedSearchRequest.color =
                                          (selectedColor == colors.first)
                                              ? null
                                              : selectedColor;
                                          advancedSearchRequest.homePage =
                                              isCheckBoxChecked;
                                          cubit.advancedSearch(
                                              ownerId:
                                              Constants.sId,
                                              advancedSearchRequest:
                                              advancedSearchRequest);
                                          Navigator.pop(context);
                                        },
                                        text: 'search',
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Row(
                            children: const [
                              Text('material'),
                              SizedBox(
                                width: AppSize.s4,
                              ),
                              Icon(Icons.precision_manufacturing_outlined),
                            ],
                          )),
                      const SizedBox(
                        width: AppSize.s4,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white60),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(

                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Padding(
                                    padding:
                                    const EdgeInsets.all(AppPadding.p14),
                                    child: Column(
                                      children: [
                                        DropdownButtonFormField(
                                          value: dropdownvalue,
                                          items: categories
                                              .map<DropdownMenuItem<String>>(
                                                  (item) {
                                                return DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(item),
                                                );
                                              }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              dropdownvalue = value;
                                            });
                                          },
                                          decoration: const InputDecoration(
                                            labelText: 'Select a Category',
                                            border: OutlineInputBorder(),
                                            prefixIcon:
                                            Icon(Icons.category_outlined),
                                          ),
                                        ),
                                        Spacer(),
                                        DefaultButton(
                                          function: () {
                                            advancedSearchRequest.name =
                                                widget.query;
                                            advancedSearchRequest.price =
                                            priceOfProductController
                                                .text.isEmpty
                                                ? null
                                                : int.parse(
                                                priceOfProductController
                                                    .text);
                                            advancedSearchRequest
                                                .mainCategorie =
                                            (dropdownvalue ==
                                                categories.first)
                                                ? null
                                                : dropdownvalue;
                                            advancedSearchRequest
                                                .manufacturingMaterial =
                                            manufacturingMaterialOfProductController
                                                .text.isEmpty
                                                ? null
                                                : manufacturingMaterialOfProductController
                                                .text;
                                            advancedSearchRequest.color =
                                            (selectedColor == colors.first)
                                                ? null
                                                : selectedColor;
                                            advancedSearchRequest.homePage =
                                                isCheckBoxChecked;
                                            cubit.advancedSearch(
                                                ownerId:
                                                Constants.sId,
                                                advancedSearchRequest:
                                                advancedSearchRequest);
                                            Navigator.pop(context);
                                          },
                                          text: 'search',
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: Row(
                          children: const [
                            Text('category'),
                            SizedBox(
                              width: AppSize.s4,
                            ),
                            Icon(Icons.category_outlined),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: AppSize.s4,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white60),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return StatefulBuilder(builder:
                                      (BuildContext context,
                                      StateSetter setState) {
                                    return Container(
                                      height: 750,
                                      child: Column(
                                        children: [
                                          const Padding(
                                            padding:
                                            EdgeInsets.all(AppPadding.p16),
                                            child: Text(
                                              'Select a color',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount: colors.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                  int index) {
                                                return ListTile(
                                                  title: Text(
                                                    colors[index],
                                                    style: const TextStyle(
                                                        fontSize: AppSize.s14),
                                                  ),
                                                  leading: Radio(
                                                    value: colors[index],
                                                    groupValue: selectedColor,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedColor = value!;
                                                      });
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            height: AppSize.s8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(
                                                AppPadding.p8),
                                            child: DefaultButton(
                                              function: () {
                                                advancedSearchRequest.name =
                                                    widget.query;
                                                advancedSearchRequest.price =
                                                priceOfProductController
                                                    .text.isEmpty
                                                    ? null
                                                    : int.parse(
                                                    priceOfProductController
                                                        .text);
                                                advancedSearchRequest
                                                    .mainCategorie =
                                                (dropdownvalue ==
                                                    categories.first)
                                                    ? null
                                                    : dropdownvalue;
                                                advancedSearchRequest
                                                    .manufacturingMaterial =
                                                manufacturingMaterialOfProductController
                                                    .text.isEmpty
                                                    ? null
                                                    : manufacturingMaterialOfProductController
                                                    .text;
                                                advancedSearchRequest.homePage =
                                                    isCheckBoxChecked;
                                                advancedSearchRequest.color =
                                                (selectedColor ==
                                                    colors.first)
                                                    ? null
                                                    : selectedColor;
                                                cubit.advancedSearch(
                                                    ownerId:
                                                    Constants.sId,
                                                    advancedSearchRequest:
                                                    advancedSearchRequest);
                                                Navigator.pop(context);
                                              },
                                              text: 'search',
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                },
                              );
                            },
                          );
                        },
                        child: Row(
                          children: const [
                            Text('color'),
                            SizedBox(
                              width: AppSize.s4,
                            ),
                            Icon(Icons.color_lens_outlined),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s4,
                ),
                buildSearchList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildSearchList() {
    bool isSelectionMode = false;
    List<int> selectedIndices = [];
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AdvancedSearchDoneState) {
          if(state.advancedSearchResponse.products!.isEmpty){
            return  Center(child: Text('No result for "${widget.query}"'),);
          }
          return Expanded(
            child: ListView.builder(
              itemCount: state.advancedSearchResponse.products?.length,
              itemBuilder: (BuildContext context, int index) {
                SearchResponseProducts product =
                state.advancedSearchResponse.products![index];
                return ListTile(
                  title: Text(product.name!),
                  subtitle: Text(product.mainCategorie!),
                  leading: DefaultImage(
                    width: 50.0,
                    height: 50.0,
                    imageUrl:product.mainImage,
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

                );

              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}