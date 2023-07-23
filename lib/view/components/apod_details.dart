import 'package:flutter/material.dart';
import 'package:nasa_apod/models/apod.dart';
import 'package:nasa_apod/res/components/read_more_text.dart';
import 'package:nasa_apod/res/style/app_text_styles.dart';
import 'package:nasa_apod/utils/string_ext.dart';


class ApodDetails extends StatelessWidget {
  const ApodDetails({
    super.key,
    required this.apod,
  });

  final Apod apod;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(apod.title,style: AppTextStyles.kH2Light,),
          const SizedBox(
            height: 10,
          ),
          ReadMoreText(text: apod.explanation,),
          const SizedBox(
            height: 10,
          ),
          Text(apod.date.getFormatDate,style: AppTextStyles.kB2,textAlign: TextAlign.left,),
        ],
      ),
    );
  }
}
