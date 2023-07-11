import 'package:flutter/material.dart';
import 'package:merchant_app/core/components/text_button.dart';
import 'package:merchant_app/core/functions.dart';
import 'package:merchant_app/core/resources/color_manager.dart';
import 'package:merchant_app/core/resources/string_manager.dart';
import 'package:merchant_app/core/resources/styles_manager.dart';
import 'package:merchant_app/core/resources/values_manager.dart';


import 'my_text.dart';

class DefaultLabel extends StatelessWidget {
  const DefaultLabel({
    Key? key,
    required this.text,
    this.showAllFunction,
  }) : super(key: key);

  final String text;
  final Function? showAllFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 20.0,
              height: 16.0,
              margin: const EdgeInsetsDirectional.only(start: AppMargin.m8),
              decoration: getDeco(withShadow: true),
            ),
            const SizedBox(
              width: AppSize.s8,
            ),
            Transform.translate(
              offset: const Offset(0.0, 2),
              child: MText(
                text: text,
                style: getBoldStyle(color: ColorManager.primary),
              ),
            ),
            const Spacer(),
            showAllFunction != null
                ? Padding(
                    padding:
                        const EdgeInsetsDirectional.only(end: AppPadding.p8),
                    child: Transform.translate(
                      offset: const Offset(0.0, 20),
                      child: DTextButton(
                        text: 'Show All',
                        function: () {
                          if (showAllFunction != null) {
                            showAllFunction!();
                          }
                        },
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
