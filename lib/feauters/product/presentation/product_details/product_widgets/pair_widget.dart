import 'package:flutter/material.dart';

import '../../../../../core/components/my_text.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';


class PairWidget extends StatelessWidget {
  const PairWidget({
    Key? key,
    required this.label,
    required this.value,
    this.withDivider = true,
    this.notTR = false,
  }) : super(key: key);
  final String? label;
  final String? value;
  final bool withDivider;
  final bool notTR;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsetsDirectional.symmetric(
          horizontal: AppPadding.p8, vertical: AppPadding.p4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: MText(
              text: label ?? '',
              maxLines: 2,
              textAlign: TextAlign.start,
              style: getMediumStyle(
                color: ColorManager.black,
              ),
            ),
          ),
          (withDivider)
              ? Container(
                  margin: const EdgeInsetsDirectional.only(
                    start: AppMargin.m4,
                    end: AppMargin.m8,
                  ),
                  width: 2.0,
                  height: 14.0,
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadiusDirectional.circular(AppSize.s4),
                  ),
                )
              : const SizedBox(),
          Expanded(
            flex: 3,
            child: MText(
              text: value ?? '',
              maxLines: 5,
              textAlign: TextAlign.justify,
              style: getRegularStyle(color: ColorManager.black),
              notTR: notTR,
            ),
          ),
        ],
      ),
    );
  }
}
