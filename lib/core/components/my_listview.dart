import 'package:flutter/material.dart';
import 'package:merchant_app/core/components/loading.dart';
import 'package:merchant_app/feauters/layouts/home_leyout/home_layout_cubit/home_layout_cubit.dart';

class MyListView<T> extends StatefulWidget {
  const MyListView({
    Key? key,
    required this.fetchData,
    required this.list,
    required this.noMoreData,
    required this.itemBuilder,
    this.physics,
  }) : super(key: key);

  final Function fetchData;
  final List<T> list;
  final bool noMoreData;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final ScrollPhysics? physics;

  @override
  State<MyListView<T>> createState() => _MyListViewState<T>();
}

class _MyListViewState<T> extends State<MyListView<T>> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // Reached the end of the list
        widget.fetchData();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      controller: scrollController,
      physics: widget.physics ?? const BouncingScrollPhysics(),
      children: [
        // Items
        ...List<Widget>.from(
          widget.list.map(
            (item) => Builder(
              builder: (context) => widget.itemBuilder(context, item),
            ),
          ),
        ),
        // Add Loading (circular progress indicator at the end),
        // if there are more items to be loaded
        if (widget.noMoreData) ...[
          const SizedBox(),
        ] else ...[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: DefaultLoading(),
          ),
        ]
      ],
    );
  }
}
