import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_apod/models/apod.dart';
import 'package:nasa_apod/res/style/app_colors.dart';
import 'package:nasa_apod/res/style/app_text_styles.dart';
import 'package:nasa_apod/utils/cache_manager.dart';
import 'package:nasa_apod/utils/route.dart';
import 'package:nasa_apod/utils/string_ext.dart';
import 'package:nasa_apod/view/apod_full_screen_view.dart';


class ApodGridItem extends StatelessWidget {
  final Apod apod;

  const ApodGridItem({Key? key, required this.apod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.push(context, scaleIn(ApodFullScreenView(apod: apod)));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: AppColors.blue),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            FractionallySizedBox(
              heightFactor: 1.0,
              widthFactor: 1.0,
              child: CachedNetworkImage(
                imageUrl: apod.url,
                fit: BoxFit.cover,
                cacheManager: CustomCacheManager.instance,
                memCacheWidth: 200,
                errorWidget: (context, url, error) => const Icon(Icons.error,color: AppColors.white,),
              ),

            ),
            FractionallySizedBox(
              widthFactor: 1.0,
              child: Container(
                alignment: Alignment.bottomLeft,
                height: 43,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black.withOpacity(0.2),
                    AppColors.black.withOpacity(0.3),
                  ],
                  tileMode: TileMode.repeated,
                )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        apod.title,
                        style: AppTextStyles.kH3Lightx1,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3,),
                      Text(
                        apod.date.getFormatDate,
                        style: AppTextStyles.kB2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
