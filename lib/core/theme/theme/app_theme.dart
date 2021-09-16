import 'package:flutter/material.dart';
import 'package:the_road_not_taken/meta/utility/Constants.dart';

import 'app_color.dart';

//?https://medium.com/globant/flutter-dynamic-theme-dark-mode-custom-themes-bded572c8cdf

class AppTheme {
  get darkTheme => ThemeData(
        primarySwatch: Colors.grey,
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: AppColors.textGrey),
          labelStyle: TextStyle(color: AppColors.white),
        ),
        brightness: Brightness.dark,
        canvasColor: AppColors.lightGreyDarkMode,
        primaryColor: primaryColor,
      );

  get lightTheme => ThemeData(
        primarySwatch: Colors.grey,
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: AppColors.textGrey),
          labelStyle: TextStyle(color: AppColors.white),
        ),
        canvasColor: AppColors.white,
        brightness: Brightness.light,
      );
}
