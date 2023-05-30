import 'package:flutter/material.dart';
import 'package:merchant_app/core/components/button.dart';
import 'package:merchant_app/core/resources/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_app/core/resources/values_manager.dart';
import 'package:merchant_app/feauters/home/domin/response/advanced_search_response.dart';
import 'package:merchant_app/feauters/home/presentation/home_cubit/home_cubit.dart';
import 'package:merchant_app/feauters/layouts/home_leyout/result_search.dart';
import '../../../core/components/text_form_field.dart';
import '../../../core/functions.dart';
import '../../home/domin/request/advanced_search_request.dart';
import '../../home/domin/response/get_merchant_response.dart';
import 'home_layout_cubit/home_layout_cubit.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);
        return Scaffold(
          appBar: cubit.currentIndex == 2
              ? getAppBar()
              : cubit.appBarScreens[cubit.currentIndex],
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottom(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }

  //TextEditingController searchController = TextEditingController();

  PreferredSizeWidget getAppBar() {
    var cubit = HomeCubit.get(context);
    return AppBar(
      title: const Text('Products'),
      actions: [
        IconButton(
          onPressed: () {
            showSearch(
              context: context,
                delegate: DataSearch(products: cubit.products));
          },
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        )

        /* PopupMenuButton<String>(
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'option1',
              child: Text('Option 1'),
            ),
            const PopupMenuItem<String>(
              value: 'option2',
              child: Text('Option 2'),
            ),
            const PopupMenuItem<String>(
              value: 'option3',
              child: Text('Option 3'),
            ),
          ],
          onSelected: (String result) {
            // Handle menu item selection here based on the result value
          },
        ),*/
      ],
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  DataSearch({required this.products});

  AdvancedSearchRequest advancedSearchRequest = AdvancedSearchRequest(name: '');
  List<Products> products;
  List<Products> filteredProducts = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ResultSearch(
      query: query,
    );
    // navigateTo(context,ResultSearch);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Handle empty or null products list
    if (products == null || products.isEmpty) {
      return const Center(
        child: Text('No products found.'),
      );
    }

    // Handle null or empty search query
    if (query == null || query.isEmpty) {
      return const Center(
        child: Text('Please enter a search query.'),
      );
    }

    // Filter products based on search query
    filteredProducts = products.where((product) {
      return product.name!.toLowerCase().contains(query.toLowerCase()) ||
          product.mainCategorie!.toLowerCase().contains(query.toLowerCase()) ||
          product.manufacturingMaterial!
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();

    // Sort filtered products by name
    filteredProducts.sort((a, b) => a.name!.compareTo(b.name!));

    // Create suggestion list based on filtered products
    List<Widget> suggestions = filteredProducts.map((product) {
      return ListTile(
        title: Text(product.name!),
        subtitle: Text(product.mainCategorie!),
        onTap: () {
          // Close the search bar and return the selected product name
          close(context, product.name!);
        },
      );
    }).toList();

    // Add a suggestion for creating a new product
    suggestions.add(ListTile(
      leading: const Icon(Icons.add),
      title: const Text('Create new product'),
      onTap: () {
        // TODO: Implement action for creating a new product
      },
    ));

    return ListView(
      children: suggestions,
    );
  }
}
