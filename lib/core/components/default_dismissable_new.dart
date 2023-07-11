import 'package:flutter/material.dart';
import 'package:flutter_dismissible_tile/flutter_dismissible_tile.dart';
import 'package:merchant_app/core/components/my_text.dart';
import 'package:merchant_app/core/resources/color_manager.dart';
import 'package:merchant_app/core/resources/styles_manager.dart';
import 'package:merchant_app/core/resources/values_manager.dart';

class DefaultDismissibleNew extends StatelessWidget {
  const DefaultDismissibleNew({
    Key? key,
    required this.widget,
    required this.function,
  }) : super(key: key);

  final Widget widget;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return DismissibleTile(
      key: UniqueKey(),
      borderRadius: BorderRadius.all(Radius.circular(AppSize.s14)),
      delayBeforeResize: const Duration(milliseconds: 500),
      ltrDismissedColor: ColorManager.error,
      rtlDismissedColor: ColorManager.error,
      onDismissed: (DismissibleTileDirection direction) => function(),
      ltrOverlay: MText(
        text: 'Delete',
        style: getBoldStyle(
          color: ColorManager.white,
          fontSize: AppSize.s25,
        ),
      ),
      ltrOverlayDismissed: MText(
        text: 'Deleted Successfully',
        style: getBoldStyle(
          color: ColorManager.white,
          fontSize: AppSize.s25,
        ),
      ),
      rtlOverlay: MText(
        text: 'Delete',
        style: getBoldStyle(
          color: ColorManager.white,
          fontSize: AppSize.s25,
        ),
      ),
      rtlOverlayDismissed: MText(
        text: 'Deleted Successfully',
        style: getBoldStyle(
          color: ColorManager.white,
          fontSize: AppSize.s25,
        ),
      ),
      child: widget,
    );
  }
}
