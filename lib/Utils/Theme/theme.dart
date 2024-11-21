import 'package:flutter/material.dart';

ThemeData lighttheme = ThemeData(
  brightness: Brightness.light,
  colorScheme:const ColorScheme.light(
    surface: Colors.white,
    primary: Colors.orange,
    onPrimary: Colors.black,
    secondary:Colors.white,
  ),
);


ThemeData darktheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme:const ColorScheme.dark(
    surface: Colors.grey,
    primary: Colors.black,
    onPrimary: Colors.white,
    secondary: Colors.white
  )
);
