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
  ConsumerState<ApodsGridView> createState() => _ApodsViewState();
}

class _ApodsViewState extends ConsumerState<ApodsGridView> {
  int _pageSize = 10;
  bool _isFirstLoadRunning = true;
  bool _isLoadMoreRunning = false;
  final ScrollController _scrollController = ScrollController();

  void getApods() async {
    if (_isFirstLoadRunning) {
      await ref.read(apodViewModelStateNotifierProvider.notifier).getApods(
            pageSize: 10,
          );
      setState(() {
        _isFirstLoadRunning = false;
      });
    } else {
      if (!_isLoadMoreRunning &&
          (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent)) {
        setState(() {
          _isLoadMoreRunning = true;
        });
        _pageSize += 1;
        await ref
            .read(apodViewModelStateNotifierProvider.notifier)
            .fetchMoreApods(
              pageSize: _pageSize,
            );
        _isLoadMoreRunning = false;
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, getApods);
    _scrollController.addListener(getApods);
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
          style: AppTextStyles.kH1Light,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: apodsVm.when(
            idle: () => const Center(child: LoadingIndicator()),
            loading: () => const Center(child: LoadingIndicator()),
            success: (data) => RefreshIndicator(
                  onRefresh: () async {
                    await ref
                        .read(apodViewModelStateNotifierProvider.notifier)
                        .fetchMoreApods(pageSize: 10, isRefresh: true);
                  },
                  child: GridView.builder(
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width / 2) / 200,
                    ),
                    itemBuilder: (context, index) => ApodGridItem(
                      apod: data[index],
                    ),
                    itemCount: (data as List<Apod>).length,
                  ),
                ),
            error: (error) => Center(
                  child: InkWell(
                    onTap: () {
                      ref
                          .read(apodViewModelStateNotifierProvider.notifier)
                          .getApods(pageSize: 10);
                      _pageSize = 10;
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
