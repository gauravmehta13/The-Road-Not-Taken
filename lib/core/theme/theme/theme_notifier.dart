import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeNotifier extends GetxController {
  late ThemeMode _themeMode;

  getThemeMode() => _themeMode;

  setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    update();
  }
}
