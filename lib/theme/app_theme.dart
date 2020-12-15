import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData defaultTheme = ThemeData(
      appBarTheme: AppBarTheme(
          color: Colors.grey[50],
          textTheme: TextTheme(),
          iconTheme: IconThemeData(color: Colors.grey[800])));

  static final ThemeData darkTheme = ThemeData(
      appBarTheme: AppBarTheme(),
      scaffoldBackgroundColor: Color(0xff454545),
      canvasColor: Color(0xff454545),
      cardColor: Color(0xff454545),
      textTheme: TextTheme());
}
