import 'package:expencse_tracker/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme=ColorScheme.fromSeed(
  seedColor:const Color.fromARGB(255, 27, 5, 61));

var kDarkColorScheme=ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor:const Color.fromARGB(255, 5, 99, 125));


void main(){
  runApp(
    MaterialApp(

      //darktheme
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme:const  CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
         // color:const Color.fromARGB(255, 220, 173, 228),
          margin:const EdgeInsets.symmetric(horizontal: 16,vertical: 8)

        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
           //backgroundColor:const  Color.fromARGB(255, 230, 198, 235),

        )),
      ) ,

      //lighttheme
      theme: ThemeData().copyWith(
        //copywith() is used to over ride the default theme
        
        colorScheme: kColorScheme,

        appBarTheme:const  AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),

        cardTheme:const  CardTheme().copyWith(
          //color: kColorScheme.secondaryContainer,
          color:const Color.fromARGB(255, 220, 173, 228),
          margin:const EdgeInsets.symmetric(horizontal: 16,vertical: 8)

        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
           // backgroundColor: kColorScheme.primaryContainer,
           backgroundColor:const  Color.fromARGB(255, 230, 198, 235),

        )),

        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 16,
          ),

        )
      ),

      themeMode: ThemeMode.system,
      home: Expenses(),
    )
  );
}