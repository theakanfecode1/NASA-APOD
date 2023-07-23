import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nasa_apod/models/apod.dart';
import 'package:nasa_apod/res/components/loading_indicator.dart';
import 'package:nasa_apod/res/style/app_colors.dart';
import 'package:nasa_apod/res/style/app_text_styles.dart';
import 'package:nasa_apod/view/components/apod_search_form_field.dart';
import 'package:nasa_apod/view/components/apods_grid.dart';
import 'package:nasa_apod/view/components/search_switch.dart';
import 'package:nasa_apod/view_model/apod_view_model.dart';

class ApodsGridView extends ConsumerStatefulWidget {
  const ApodsGridView({Key? key}) : super(key: key);

  @override
  ConsumerState<ApodsGridView> createState() => _ApodsViewState();
}

class _ApodsViewState extends ConsumerState<ApodsGridView> {
  bool _isFirstLoadRunning = true;
  bool _isLoadMoreRunning = false;
  final TextEditingController _searchTextEditingController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Apod> _filteredApods = [];

  void getApods() async {
    if (_isFirstLoadRunning) {
      await ref.read(apodViewModelStateNotifierProvider.notifier).getApods();
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
        await ref
            .read(apodViewModelStateNotifierProvider.notifier)
            .fetchMoreApods();
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
  void dispose() {
    _searchTextEditingController.dispose();
    super.dispose();
  }

  void onSelectDate() async {
    DateTime? selectedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (selectedDateTime != null) {
      _searchTextEditingController.text =
          DateFormat('yyyy-MM-dd').format(selectedDateTime);
      filterApods(_searchTextEditingController.text.trim());
    }
  }

  void filterApods(String query) {
    List<Apod> apods = ref
        .read(apodViewModelStateNotifierProvider.notifier)
        .getSuccessData() as List<Apod>;
    final filteredApods = apods.where((apod) {
      final title = apod.title.toLowerCase();
      final date = apod.date.toLowerCase();
      final searchQuery = query.toLowerCase();
      return title.contains(searchQuery) || date.contains(searchQuery);
    }).toList();

    setState(() {
      _filteredApods = filteredApods;
    });
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
          'Astronomy Picture of the Day',
          style: AppTextStyles.kH2Light,
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
                          .fetchMoreApods(isRefresh: true);
                  },
                  child: Column(
                    children: [
                      ApodSearchFormField(
                        textEditingController: _searchTextEditingController,
                        onChange: filterApods,
                        onSubmit: filterApods,
                        onSelectDate: onSelectDate,
                        onClear: () {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            _searchTextEditingController.clear();
                          });
                        },
                        onFindTypeSelected: (findType) {
                          setState(() {
                            _searchTextEditingController.clear();
                          });
                          if (findType == FindType.date) {
                            onSelectDate();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: _searchTextEditingController.text.isEmpty
                            ? ApodGrid(
                                scrollController: _scrollController,
                                apods: data as List<Apod>,
                              )
                            : ApodGrid(
                                apods: _filteredApods,
                              ),
                      ),
                    ],
                  ),
                ),
            error: (error) => Center(
                  child: InkWell(
                    onTap: () {
                      ref
                          .read(apodViewModelStateNotifierProvider.notifier)
                          .getApods();
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
