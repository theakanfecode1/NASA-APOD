import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_apod/models/apod.dart';
import 'package:nasa_apod/res/components/loading_indicator.dart';
import 'package:nasa_apod/res/style/app_colors.dart';
import 'package:nasa_apod/utils/cache_manager.dart';
import 'package:nasa_apod/view/components/apod_details.dart';
import 'package:photo_view/photo_view.dart';

class ApodFullScreenView extends StatelessWidget {
  final Apod apod;

  const ApodFullScreenView({Key? key, required this.apod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: true,
          backgroundColor: AppColors.black.withOpacity(0.4),
          iconTheme: const IconThemeData(color: AppColors.white),
        ),
        body: Stack(
          children: [
            Container(
                constraints: BoxConstraints.expand(
                  height: MediaQuery.of(context).size.height,
                ),
                child: PhotoView(
                  backgroundDecoration: const BoxDecoration(
                    color: AppColors.black
                  ),
                  imageProvider: CachedNetworkImageProvider(apod.url,
                      cacheManager: CustomCacheManager.instance),
                  basePosition: Alignment.center,
                  errorBuilder: (context, url, error) => const Icon(Icons.error,color: AppColors.white,),
                  loadingBuilder: (context, event) {
                    if (event == null) {
                      return const Center(child: LoadingIndicator());
                    }
                    final value = event.cumulativeBytesLoaded /
                        (event.expectedTotalBytes ??
                            event.cumulativeBytesLoaded);
                    return Center(
                      child: LoadingIndicator(value: value),
                    );
                  },
                  filterQuality: FilterQuality.none,
                )
                ),
            Positioned(
              left: 20,
              bottom: 10,
              right: 10,
              child: ApodDetails(apod: apod),
            )
          ],
        ));
  }
}
