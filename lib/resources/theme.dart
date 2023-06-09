// настраиваем кастомную тему
import 'package:flutter/material.dart';

final usualTheme = ThemeData(
  // указываем primaryColor и его оттенки
    primaryColor: Colors.purple[600],
    primaryColorLight: Colors.purple[300],
    primaryColorDark: Colors.purple[800],
    // также указываем accentColor
    accentColor: Colors.teal,
    // настройка Theme для AppBar
    appBarTheme: AppBarTheme(
      shadowColor: Colors.grey.withOpacity(0.8),
      elevation: 10,
    ),
    // настройка Theme для Text
    textTheme: TextTheme(
        headlineSmall: TextStyle(fontWeight: FontWeight.bold)
    ),
    // указываем наш шрифт для всего приложения
    fontFamily: "Kalam"
);