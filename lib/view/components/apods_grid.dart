import 'package:flutter/material.dart';
import 'package:nasa_apod/models/apod.dart';
import 'package:nasa_apod/view/components/apod_grid_item.dart';

class ApodGrid extends StatelessWidget {
  final ScrollController? scrollController;
  final List<Apod> apods;

  const ApodGrid({
    super.key,
    this.scrollController,
    required this.apods,
  });


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio:
        (MediaQuery
            .of(context)
            .size
            .width / 2) / 200,
      ),
      itemBuilder: (context, index) =>
          ApodGridItem(
            apod: apods[index],
          ),
      itemCount: apods.length,
    );
  }
}
