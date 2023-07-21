import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nasa_apod/core/network/services/custom_http_overrides.dart';
import 'package:nasa_apod/res/style/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = CustomHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APOD Gallery',
      theme: ThemeData(
          primaryColor: AppColors.black,
          fontFamily: ('Lato' ),
          colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: AppColors.black)),
      home: Container(),
    );
  }
}

