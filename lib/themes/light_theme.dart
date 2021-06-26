import 'package:flutter/material.dart';

ThemeData lightTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1.copyWith(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lato',
        color: Color(0xFFBD4242),
      ),
      headline2: base.headline2.copyWith(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Lato',
          color: Colors.black87),
      headline3: base.headline3.copyWith(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lato',
        color: Colors.black,
      ),
      headline4: base.headline4.copyWith(
        fontSize: 17,
        fontFamily: 'Lato',
        color: Colors.black,
      ),
      headline5: base.headline5.copyWith(
        fontSize: 17.0,
        fontFamily: 'Lato',
        color: Colors.grey[700],
        //buttons
      ),
      headline6: base.headline6.copyWith(
        fontSize: 21.0,
        fontFamily: 'Lato',
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyText1: base.bodyText1.copyWith(
        color: Colors.grey[800],
        fontSize: 15,
      ),
      bodyText2: base.bodyText2.copyWith(
        fontSize: 16.0,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w800,
        color: Colors.grey[900],
      ),
      button: base.button.copyWith(
          fontSize: 15.0,
          fontFamily: 'Lato',
          color: Colors.white,
          fontWeight: FontWeight.bold),
      caption: base.headline5.copyWith(
        fontSize: 14.0,
        fontFamily: 'Lato',
      ),
      subtitle1: base.subtitle1.copyWith(
        fontSize: 15.0,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w900,
        color: Color(0xFFBD4242),
      ),
      subtitle2: base.subtitle2.copyWith(
        fontSize: 15.0,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w700,
        color: Color(0xFFBD4242),
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
    hintColor: Colors.grey,
    scaffoldBackgroundColor: Colors.white,
    errorColor: Colors.redAccent[700],
    backgroundColor: Colors.white,
    dialogBackgroundColor: Colors.white,
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
      centerTitle: true,
      color: Colors.white,
      elevation: 0,
      brightness: Brightness.light,
      textTheme: base.textTheme..headline3,
    ),
  );
}

// for register input field
InputDecorationTheme inputDecorationTheme(ThemeData base) {
  OutlineInputBorder EnabledInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.grey[900], width: 1),
    gapPadding: 15,
  );
  OutlineInputBorder FocusedInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.grey[900], width: 1.5),
    gapPadding: 10,
  );

  OutlineInputBorder disableInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.grey[900], width: 0.5),
  );

  OutlineInputBorder ErrorInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Color(0xFFBD4242)));

  return InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(
      horizontal: 25,
      vertical: 20,
    ),
    enabledBorder: EnabledInputBorder,
    disabledBorder: disableInputBorder,
    focusedBorder: FocusedInputBorder,
    errorBorder: ErrorInputBorder,
    border: EnabledInputBorder,
    hintStyle: TextStyle(),
    labelStyle: TextStyle(color: Colors.red),
  );
}
////link url fot this method :https://codeburst.io/managing-multiple-themes-in-flutter-application-37411adeb04c
