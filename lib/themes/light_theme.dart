import 'package:flutter/material.dart';

ThemeData lightTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1.copyWith(
        fontSize: 30.0,
        fontWeight: FontWeight.normal,
        fontFamily: 'Lato',
        color: Color(0xFFBD4242),
      ),
      headline2: base.headline2.copyWith(),
      headline3: base.headline3.copyWith(),
      headline4: base.headline4.copyWith(
        fontSize: 18.0,
        fontFamily: 'Lato',
        color: Color(0xFF42BDBD),
      ),
      headline5: base.headline4.copyWith(
        fontSize: 17.0,
        fontFamily: 'Lato',
        color: Colors.grey[700],
        //buttons
      ),
      headline6: base.headline6.copyWith(
        fontSize: 23.0,
        fontFamily: 'Lato',
      ),
      bodyText1: base.bodyText1.copyWith(
        color: Colors.grey[800],
        fontSize: 14,
      ),
      bodyText2: base.bodyText2.copyWith(
        fontSize: 16.0,
        fontFamily: 'Lato',
        color: Colors.grey[900],
      ),
      caption: base.headline5.copyWith(
        fontSize: 12.0,
        fontFamily: 'Lato',
      ),
    );
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _basicTextTheme(base.textTheme),
    primaryColor: Color(0xFFBD4242),
    primaryColorLight: Color(0xFFC45555),
    primaryColorDark: Color(0xFF470000),
    accentColor: Colors.white,
    hintColor: Color(0xFF42BDBD),
    scaffoldBackgroundColor: Colors.white,
    errorColor: Colors.redAccent[700],
    backgroundColor: Colors.white,
    primaryTextTheme: TextTheme(
      headline2: TextStyle(
        color: Colors.white,
        fontFamily: "Lato",
        fontSize: 16.0,
      ),
    ),
    accentTextTheme: TextTheme(
      headline3: TextStyle(
        color: Colors.black54,
        fontFamily: "Lato",
        fontSize: 16.0,
      ),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFFBD4242),
      size: 20.0,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFFBD4242),
      shape: RoundedRectangleBorder(),
      textTheme: ButtonTextTheme.primary,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: Color(0xFFBD4242),
      overlayColor: Color(0xFFBD4242).withAlpha(32),
      thumbColor: Color(0xFFBD4242),
    ),
    inputDecorationTheme: inputDecorationTheme(base),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 2,
      brightness: Brightness.light,
    ),
  );
}

// for register input field
InputDecorationTheme inputDecorationTheme(ThemeData base) {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: Color(0xFFBD4242)),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20,
    ),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
    hintStyle: TextStyle(),
    labelStyle: TextStyle(color: Colors.red),
  );
}
////link url fot this method :https://codeburst.io/managing-multiple-themes-in-flutter-application-37411adeb04c
