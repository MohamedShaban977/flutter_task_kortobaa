import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_task_kortobaa/core/utils/colors.dart';
import 'package:lottie/lottie.dart';


const String fontFamily = "Almarai";

/// Theme Material App
ThemeData themeDataLight = ThemeData(
  primaryColor: MyColors.colorBackground,
  brightness: Brightness.light,
  // primaryColorLight: Colors.white,
  // primaryColorDark: Colors.black26,
  // backgroundColor: MyColors.colorWhite,
  focusColor: Colors.black54,
  fontFamily: fontFamily,
  appBarTheme: const AppBarTheme(
    backgroundColor:MyColors.colorPrimary2,
    //     iconTheme:  IconThemeData(
    //       color: Colors.white,
    //     ),
    // actionsIconTheme:  IconThemeData(
    //     color: Colors.white,
    //
    // ),
    )
);

ThemeData themeDataDark = ThemeData(
  primaryColor: Colors.black.withOpacity(0.7),
  brightness: Brightness.dark,
  // backgroundColor: MyColors.colorBlackTheme.withOpacity(0.05),
  // primaryColorLight: Colors.black26,
  // primaryColorDark: Colors.black,
  focusColor: Colors.white,
  fontFamily: fontFamily,
  appBarTheme: const AppBarTheme(
        backgroundColor:MyColors.colorPrimary2,

        iconTheme: IconThemeData(
          color: Colors.white,
        )
    ),
);

loading(context) {
  return Lottie.asset(
    'assets/images/loader.json',
    fit: BoxFit.contain,
    height: 200,
  );
}



// double sizeFromHeight(double fraction, {bool removeAppBarSize = true}) {
//   MediaQueryData mediaQuery = MediaQuery.of(navigatorKey.currentContext);
//   fraction = (removeAppBarSize
//           ? (mediaQuery.size.height -
//               AppBar().preferredSize.height -
//               mediaQuery.padding.top)
//           : mediaQuery.size.height) /
//       (fraction == 0 ? 1 : fraction);
//   return fraction;
// }

Widget bottomSizedInIOS(context) {
  final MediaQueryData data = MediaQuery.of(context);
  EdgeInsets padding = data.padding;
  if (Platform.isIOS) {
    return SizedBox(height: padding.bottom == 0.0 ? 20.0 : padding.bottom);
  }
  return const SizedBox(height: 20.0);
}

