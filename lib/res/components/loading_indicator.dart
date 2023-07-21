import 'package:flutter/material.dart';
import 'package:nasa_apod/res/style/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  final double? value;
  const LoadingIndicator({Key? key,this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: value,
      strokeWidth: 2.0,
      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.white),
    );
  }
}
