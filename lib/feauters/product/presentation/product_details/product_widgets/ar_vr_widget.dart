import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import '../../../../../core/components/text_button.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/resources/string_manager.dart';
import '../product_details_cubit/product_cubit.dart';
import '../vr_screen.dart';

class ArVRWidget extends StatelessWidget {
  const ArVRWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final ProductCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          cubit.vrUrl.isNotEmpty
              ? Expanded(
                  child: DTextButton(
                    function: () {
                      // navigateTo(
                      //   context,
                      //   VRScreen(
                      //     name: 'GLP',
                      //     modelUrl: cubit.vrUrl,
                      //   ),
                      // );
                    },
                    text: AppStrings.vrMode,
                  ),
                )
              : Container(),
          cubit.arUrl.isNotEmpty
              ? Expanded(
                  child: DTextButton(
                    function: () {
                      // navigateTo(
                      //   context,
                      //   VRScreen(
                      //     name: 'GLP',
                      //     modelUrl: cubit.arUrl,
                      //   ),
                      // );
                    },
                    text: AppStrings.arMode.tr(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
