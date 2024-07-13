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
);
