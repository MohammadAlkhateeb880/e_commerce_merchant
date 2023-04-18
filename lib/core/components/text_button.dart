// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class DTextButton extends StatelessWidget {
  DTextButton({
    Key? key,
    required this.text,
    required this.function,
  }) : super(key: key);

  Function function;

  String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => function(),
      child: Text(
        text.toUpperCase(),
        style: getMediumStyle(color: ColorManager.primary),
      ),
    );
  }
}
