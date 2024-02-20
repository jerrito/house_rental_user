import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  //primaryColor: shaqBlack100,
 // scaffoldBackgroundColor: shaqBackground,
  //appBarTheme: appBarTheme,
  useMaterial3: true,
  fontFamily: 'Raleway',
  //inputDecorationTheme: inputDecorationTheme,
  textTheme: const TextTheme(
    displaySmall: TextStyle(
      fontSize: 15,
    ),
    displayMedium: TextStyle(
      fontSize: 16,
    ),
    displayLarge: TextStyle(
      fontSize: 17,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
);

// ///INPUT DECORATION THEME
// const InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
//   errorStyle: TextStyle(
//     fontSize: 15,
//     color: shaqRed100,
//   ),
//   hintStyle: TextStyle(
//     fontSize: 14,
//     color: shaqBlack40,
//   ),
// );

// ///APPBAR THEME
// const AppBarTheme appBarTheme = AppBarTheme(
//   backgroundColor: shaqBackground,
//   surfaceTintColor: shaqBackground,
//   foregroundColor: shaqBlack100,
//   centerTitle: true,
//   elevation: 0,
// );