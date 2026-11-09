import 'package:flutter/material.dart';

import '../../../../../core/theme/theme.dart';

class DividerPostDetailWidget extends StatelessWidget {
  const DividerPostDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1,
      color: primaryClr,
      indent: 10,
      endIndent: 10,
      height: 50,
    );
  }
}
