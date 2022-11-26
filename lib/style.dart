import 'package:flutter/material.dart';

var theme = ThemeData(
  appBarTheme: AppBarTheme(
      color: Colors.white,
      centerTitle: false,
      elevation: 1,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
      actionsIconTheme: IconThemeData(color: Colors.black, size: 30)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.black, elevation: 2),
);
