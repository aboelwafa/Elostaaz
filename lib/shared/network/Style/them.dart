// ignore_for_file: prefer_const_constructors, deprecated_member_use, duplicate_ignore, unused_field, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

class ThemeService {
  final lightTheme =
  ThemeData.light().copyWith(
    primaryColor: blue,
    scaffoldBackgroundColor: Colors.white,
    // ignore: prefer_const_constructors

    appBarTheme: AppBarTheme(
        titleSpacing: 20.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        textTheme: TextTheme(
            bodyText1: TextStyle(
                color: Colors.blue, fontSize: 20, fontFamily: 'Prompt'))),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: blue,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
          color: Colors.black,
          fontFamily: 'Pacifico',
          fontSize: 20
      ),
      bodyText2: TextStyle(
          color: blue,
          fontFamily: 'Prompt-Bold',
          fontSize: 20
      ),
    ),
  );

  final darkTheme = ThemeData.dark().copyWith(
    primaryColorDark: yellow,
    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
        titleSpacing: 20.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: HexColor('333739'),
        iconTheme: IconThemeData(
          color: white,
        ),
        elevation: 0.0,
        titleTextStyle: TextStyle(
            color: white,
            fontFamily: 'Prompt',
            fontSize: 20
        ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.shifting,
      selectedItemColor: white,
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      backgroundColor: HexColor('333739'),
    ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: white,
          fontFamily: 'Pacifico',
          fontSize: 20
        ),
        bodyText2: TextStyle(
            fontFamily: 'Prompt-Bold',
            fontSize: 20
        ),
      ),
  );

  final _getStorge = GetStorage();
  final StorgeKey = "isDarkMode";

  ThemeMode getThemeMode() {
    return isSaveDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  bool isSaveDarkMode() {
    return _getStorge.read(StorgeKey) ?? false;
  }

  void SaveThemeMode(bool isDarkMode) {
    _getStorge.write(StorgeKey, isDarkMode);
  }

  void changeThemeMode() {
    Get.changeThemeMode(isSaveDarkMode() ? ThemeMode.dark : ThemeMode.light);
    SaveThemeMode(!isSaveDarkMode());
  }
}
