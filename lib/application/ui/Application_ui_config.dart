// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApplicationUiConfig {
  ApplicationUiConfig._();
  static String get title => 'Battery Alarm';
  static ThemeData get lightTheme => ThemeData.light().copyWith(
        primaryColor: Colors.blueGrey[300],
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          titleTextStyle: TextStyle(
            fontSize: 25,
            wordSpacing: 0.15,
            color: Colors.black,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.red,
        ),
      );
  static ThemeData get darkTheme => ThemeData.dark().copyWith(
        primaryColor: Colors.blueGrey[300],
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          titleTextStyle: TextStyle(
            fontSize: 25,
            wordSpacing: 0.15,
            color: Colors.white,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.red,
        ),
      );
}
