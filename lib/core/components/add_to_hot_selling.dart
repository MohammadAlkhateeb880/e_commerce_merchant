

import 'package:flutter/material.dart';

import '../../feauters/home/presentation/home_cubit/widget_home_screen/add_dialog.dart';

Future addToHotSelling(BuildContext context,String productId) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AddDialogHotSelling(
        productId: productId,
      );
    },
  );
}