// default theme

import 'package:flutter/material.dart';

final ThemeData defaultTheme = ThemeData(
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 251, 251, 251),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    surfaceTintColor: Colors.white,
    foregroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  chipTheme: const ChipThemeData(
    backgroundColor: Colors.white,
    selectedColor: Colors.black,
    labelPadding: EdgeInsets.symmetric(horizontal: 8),
    padding: EdgeInsets.symmetric(horizontal: 8),
    labelStyle: TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
    checkmarkColor: Colors.white,
    secondaryLabelStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
);
