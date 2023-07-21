import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasa_apod/core/network/services/custom_http_overrides.dart';
import 'package:nasa_apod/res/style/app_colors.dart';
import 'package:nasa_apod/view/apods_grid_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = CustomHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'APOD Gallery',
        theme: ThemeData(
            primaryColor: AppColors.black,
            fontFamily: ('Lato' ),
            colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: AppColors.black)),
        home: const ApodsGridView(),
      ),
    );
  }
}

