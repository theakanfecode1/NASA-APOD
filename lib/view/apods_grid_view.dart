import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasa_apod/models/apod.dart';
import 'package:nasa_apod/res/components/loading_indicator.dart';
import 'package:nasa_apod/res/style/app_colors.dart';
import 'package:nasa_apod/res/style/app_text_styles.dart';
import 'package:nasa_apod/view/components/apod_grid_item.dart';
import 'package:nasa_apod/view_model/apod_view_model.dart';


class ApodsGridView extends ConsumerStatefulWidget {
  const ApodsGridView({Key? key}) : super(key: key);

  @override
  ConsumerState<ApodsGridView> createState() => _PhotosViewState();
}

class _PhotosViewState extends ConsumerState<ApodsGridView> {
  int _page = 1;
  bool _isFirstLoadRunning = true;
  bool _isLoadMoreRunning = false;
  ScrollController scrollController = ScrollController();

  void getPhotos() async {
    if (_isFirstLoadRunning) {
      await ref.read(apodViewModelStateNotifierProvider.notifier).getApods(
            pageNum: 1,
          );
      setState(() {
        _isFirstLoadRunning = false;
      });
    } else {
      if (!_isLoadMoreRunning &&
          (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent)) {
        setState(() {
          _isLoadMoreRunning = true;
        });
        _page += 1;
        await ref
            .read(apodViewModelStateNotifierProvider.notifier)
            .getPaginatedApods(
              pageNum: _page,
            );
        _isLoadMoreRunning = false;
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, getPhotos);
    scrollController.addListener(getPhotos);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final apodsVm = ref.watch(apodViewModelStateNotifierProvider);
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: AppColors.black,
        title: const Text(
          'APOD Gallery',
          style: AppTextStyles.kH2Light,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: apodsVm.when(
            idle: () => const Center(child: LoadingIndicator()),
            loading: () => const Center(child: LoadingIndicator()),
            success: (data) => GridView.builder(
                  controller: scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio:
                        (MediaQuery.of(context).size.width / 2) / 200,
                  ),
                  itemBuilder: (context, index) => ApodGridItem(
                    apod: data[index],
                  ),
                  itemCount: (data as List<Apod>).length,
                ),
            error: (error) => Center(
                  child: InkWell(
                    onTap: () {
                      ref
                          .read(apodViewModelStateNotifierProvider.notifier)
                          .getApods(pageNum: 1);
                      _page = 1;
                    },
                    child: const Text(
                      'Unable to load data.\n Tap to reload',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.kH3Lightx2,
                    ),
                  ),
                )),
      ),
    );
  }
}
