import 'package:flutter/material.dart';
import 'package:expenses_tracker/expenseTracker.dart';
var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.yellow);
void main() {
  runApp(MaterialApp(
    theme: ThemeData().copyWith(useMaterial3: true,
    colorScheme: kColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer
      ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16
          )

    ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primaryContainer
        )
      ),
      textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
          fontWeight: FontWeight.normal,
          color: kColorScheme.onSecondaryContainer,
          fontSize: 14
        )
      )
    ),
    home:const ExpenseTracker()
  ));
}
