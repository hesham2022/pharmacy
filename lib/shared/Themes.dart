import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


ThemeData lightTheme=  ThemeData(
    primarySwatch:Colors.teal ,
    scaffoldBackgroundColor:Colors.white ,
    appBarTheme: AppBarTheme(
      // backwardsCompatibility: false,
      systemOverlayStyle:SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
      ) ,
      color: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Madina',
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold
      ),
      iconTheme: IconThemeData(
          color: Colors.black
      ),
    ),
    bottomNavigationBarTheme:BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        elevation:40
    ),
    textTheme:TextTheme(
        bodyText1: TextStyle(
          fontFamily:'Madina' ,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black
        ),
        subtitle1:TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
         height: 1.3
    )
    ),
    fontFamily: 'Madina'
);

ThemeData darkTheme=  ThemeData(
    primarySwatch:Colors.teal ,
    scaffoldBackgroundColor: Color(0xff303030),
    appBarTheme: AppBarTheme(
        // backwardsCompatibility: false,
        systemOverlayStyle:SystemUiOverlayStyle(
            statusBarColor: Color(0xff303030),
            statusBarIconBrightness: Brightness.light
        ) ,
        color:Color(0xff303030),
        elevation: 0,
        titleTextStyle: TextStyle(
            fontFamily: 'Madina',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
        iconTheme: IconThemeData(
            color: Colors.white
        )
    ),
    bottomNavigationBarTheme:BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xff303030),
      selectedItemColor: Color(0xff089bab),
      unselectedItemColor: Colors.grey,
      elevation:40,
    ),
    textTheme:TextTheme(
        bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: 'Madina',
        ),
        subtitle1:TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        height: 1.3
    )
    ),
    fontFamily: 'Madina'
);
