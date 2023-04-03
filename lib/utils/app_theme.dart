import 'package:flimfriend/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const appName = "FilmFriend";

class AppTheme {
  AppTheme._();
  static final ThemeData dTheme = ThemeData(
    primaryColor: primaryColor,
    primaryColorDark: primaryColorDark,
    hoverColor: specialColor,
    dividerColor: Colors.grey,
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: const AppBarTheme(
      color: primaryColorDark,
      iconTheme: IconThemeData(color: textColor),
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    ),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
    colorScheme: const ColorScheme.light(primary: primaryColor),
    cardTheme: const CardTheme(color: Colors.white),
    cardColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.grey),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: primaryColor),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
  );
}