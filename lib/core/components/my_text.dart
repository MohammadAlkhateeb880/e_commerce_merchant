// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class MText extends StatelessWidget {
  MText({
    Key? key,
    required this.text,
    this.style,
    this.maxLines = 1,
    this.color,
    this.textAlign = TextAlign.center,
    this.notTR = false,
  }) : super(key: key);

  String text;
  TextStyle? style;
  int? maxLines;
  Color? color;
  TextAlign? textAlign;
  bool notTR;

  @override
  Widget build(BuildContext context) {
    return Text(
      notTR ? text : text,
      style: style ??
          getMediumStyle(
            color: color ?? ColorManager.primary,
          ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
    );
  }
}
