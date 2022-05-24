import 'package:flutter/material.dart';
import 'package:flutter_task_kortobaa/core/utils/colors.dart';
import 'package:lottie/lottie.dart';

const String fontFamily = "Almarai";

/// Theme Material App
ThemeData themeDataLight = ThemeData(
    primaryColor: MyColors.colorBackground,
    brightness: Brightness.light,
    focusColor: Colors.black54,
    fontFamily: fontFamily,
    appBarTheme: const AppBarTheme(
      backgroundColor: MyColors.colorPrimary2,
    ));

ThemeData themeDataDark = ThemeData(
  primaryColor: Colors.black.withOpacity(0.7),
  brightness: Brightness.dark,
  focusColor: Colors.white,
  fontFamily: fontFamily,
  appBarTheme: const AppBarTheme(
      backgroundColor: MyColors.colorPrimary2,
      iconTheme: IconThemeData(
        color: Colors.white,
      )),
);

loading(context) {
  return Lottie.asset(
    'assets/images/loader.json',
    fit: BoxFit.contain,
    height: 200,
  );
}
