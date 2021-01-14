import 'package:flutter/material.dart';

ThemeData lightTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1.copyWith(
        fontSize: 30.0,
        fontWeight: FontWeight.normal,
        fontFamily: 'MPLUSRounded1c',
        color: Colors.deepPurple[300],
      ),
      headline2: base.headline2.copyWith(),
      headline3: base.headline3.copyWith(),
      headline4: base.headline4.copyWith(
        fontSize: 18.0,
        fontFamily: 'MPLUSRounded1c',
        color: Colors.deepPurple[600],
      ),
      headline5: base.headline4.copyWith(
        fontSize: 17.0,
        fontFamily: 'MPLUSRounded1c',
        color: Colors.deepPurple[50],
        //buttons
      ),
      headline6: base.headline6.copyWith(
        fontSize: 23.0,
        fontFamily: 'MPLUSRounded1c',
      ),
      bodyText1: base.bodyText1.copyWith(
        color: Colors.deepPurple[300],
        fontSize: 14,
      ),
      bodyText2: base.bodyText2.copyWith(
        fontSize: 16.0,
        fontFamily: 'MPLUSRounded1c',
        color: Colors.deepPurple[300],
      ),
      caption: base.headline5.copyWith(
        fontSize: 12.0,
        fontFamily: 'MPLUSRounded1c',
      ),
    );
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _basicTextTheme(base.textTheme),
    primaryColor: Colors.deepPurple[300],
    accentColor: Colors.deepPurple[100],
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.deepPurple[300],
      size: 20.0,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.deepPurple[300],
      shape: RoundedRectangleBorder(),
      textTheme: ButtonTextTheme.primary,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: Colors.deepPurple[300],
      overlayColor: Colors.deepPurple[300].withAlpha(32),
      thumbColor: Colors.deepPurple[300],
    ),
  );
}
////link url fot this method :https://codeburst.io/managing-multiple-themes-in-flutter-application-37411adeb04c
