import 'package:flutter/material.dart';
import 'package:merchant_app/core/resources/color_manager.dart';
import 'package:merchant_app/core/resources/values_manager.dart';



void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;

getDeco({
  bool withShadow = false,
  Color? color = ColorManager.primary,
  double borderSize = 0.0,
  DecorationImage? image,
}) {
  return BoxDecoration(
    color: color ?? ColorManager.primary,
    borderRadius: BorderRadiusDirectional.only(
      bottomEnd:  const Radius.circular(AppSize.s8),
      topEnd:  const Radius.circular(AppSize.s8),
      bottomStart: Radius.circular(borderSize),
      topStart: Radius.circular(borderSize),
    ),
    boxShadow: withShadow
        ? [
      const BoxShadow(
        color: ColorManager.darkPrimary,
        blurRadius: 1.0,
        spreadRadius: 1.0,
        blurStyle: BlurStyle.outer,
      ),
      const BoxShadow(
        color: ColorManager.darkPrimary,
        blurRadius: 1.0,
        spreadRadius: 1.0,
        blurStyle: BlurStyle.outer,
      ),
      const BoxShadow(
        color: ColorManager.error,
        blurRadius: 1.0,
        spreadRadius: 1.0,
        blurStyle: BlurStyle.outer,
      ),
    ]
        : [],
    image: image,
  );
}
