// ignore_for_file: non_constant_identifier_names, file_names, unused_import, prefer_const_constructors

import 'package:deliveryboy/global%20class/color.dart';
import 'package:flutter/material.dart';

class MyThemes {
  static final DarkTheme = ThemeData(
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith(
          (states) => Colors.transparent,
        ),
      ),
    ),
    iconTheme: IconThemeData(color: Colors.white),
    //appbar
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(color: Colors.white),
    ),

    // bottom navigationbar

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    ),

    //app theme
    primaryIconTheme: const IconThemeData(
      color: Colors.white,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      surface: Colors.yellow,
      onSurface: Colors.black,
      primary: Colors.white,
      onPrimary: Colors.grey,
      secondary: Colors.grey,
      onSecondary: Colors.grey,
      background: Colors.yellow,
      onBackground: Colors.grey,
      error: Colors.grey,
      onError: Colors.grey,
    ),
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
  );

///////////////////////////////////////////////

  static final LightTheme = ThemeData(
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith(
          (states) => Colors.transparent,
        ),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.black,
    ),
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.black,
      ),
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 0,
    ),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
  );
}
