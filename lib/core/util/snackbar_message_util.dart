import 'package:flutter/material.dart';

import '../theme/theme.dart';

class SnackBarMessageUtil {
  static void show(
    BuildContext context, {
    required String message,
    required bool isSuccessMessage,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(_snackBarWidget(message, isSuccessMessage));
  }

  static SnackBar _snackBarWidget(String message, bool isSuccessMessage) {
    return SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14, color: darkGreyClr),
      ),
      backgroundColor: isSuccessMessage ? successColor : errorColor,
    );
  }
}
