import 'package:flutter/material.dart';

import '../values/my_colors.dart';

class ProgressBar extends StatelessWidget {
  ProgressBar();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: MyColors.white,
        strokeWidth: 4,
      ),
    );
  }
}
