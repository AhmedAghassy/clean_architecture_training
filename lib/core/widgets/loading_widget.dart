import 'package:flutter/material.dart';

import '../theme/theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator(color: primaryClr, strokeWidth: 1.5),
      ),
    );
  }
}
