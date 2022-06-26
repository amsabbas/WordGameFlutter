import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:word_game/base/utils/asset_resource.dart';

import 'colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.defaultColor,
      appBarTheme:  const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColors.defaultColor,
            // Status bar brightness
            statusBarIconBrightness: Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          backgroundColor: AppColors.defaultColor,
          foregroundColor: AppColors.whiteColor,
          centerTitle: true),
      textTheme: const TextTheme(
        bodyText1: TextStyle(fontFamily: AssetResource.appFontName),
        bodyText2: TextStyle(fontFamily: AssetResource.appFontName),
        subtitle1: TextStyle(fontFamily: AssetResource.appFontName),
        subtitle2: TextStyle(fontFamily: AssetResource.appFontName),
        headline4: TextStyle(
            fontFamily: AssetResource.appFontName,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        headline5: TextStyle(fontFamily: AssetResource.appFontName),
        headline6: TextStyle(fontFamily: AssetResource.appFontName),
        button: TextStyle(fontFamily: AssetResource.appFontName, fontSize: 16),
      ),
    );
  }
}
