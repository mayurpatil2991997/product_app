import 'package:flutter/material.dart';

class ApplicationSizes {
  //general border and blure radius for elements in the app
  static const double borderRadius = 10.0;
  //general element padding
  static const double padding = 8.0;
  //general element padding
  static const double horizontalPadding = 16.0;
  //general element padding
  static const double verticalPadding = 12.0;
  //icon side padding
  static const double iconSidePadding = 3.0;
  //page side padding
  static const double pageSidePadding = 24.0;
  //page top padding
  static const double pageTopPadding = 40.0;
  //page bottom padding
  static const double pageBottomPadding = 40.0;
  //round buttons radius
  static const double roundButtonRadius = 15.0;
}

class ApplicationColors {
  static final Color primaryColorLight = Color(0xFF0489C2);
  static final Color primaryColorDark = Color(0xFF0489C2);

  static final Color accentColorLight = Color(0xFF0489C2);
  static final Color accentColorDark = Color(0xFF0489C2);

  static final Color backgroundLight = Color(0xFFF4F4F4);
  static final Color backgroundDark = Color(0xFFF4F4F4);
  static final Color gray = Color(0xFF999999);

  static final Color primaryTextColorLight = Color(0xFF282828);
  static final Color primaryTextColorDark = Color(0xFF282828);

  static final Color transparentColor = Color(0xFFFFFFFFFF);

  static final Color yellowColor = Color(0xFFE99A4A);
  static final Color errorColor = Color(0xFFff006e);
}

class MedicationTrackerTheme {
  static get lightTheme {
    final themeData = ThemeData.light();
    final originalTextTheme = themeData.textTheme.copyWith(
        headline4: TextStyle(fontSize: 20.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w400, color: ApplicationColors.primaryTextColorLight, letterSpacing: 1.0, height: 1.5),
    );
    return themeData.copyWith(
      primaryColor: ApplicationColors.primaryColorLight,
      scaffoldBackgroundColor: ApplicationColors.transparentColor,
      accentColor: ApplicationColors.accentColorLight,
      backgroundColor: ApplicationColors.backgroundLight,
      textTheme: originalTextTheme.copyWith(
        headline1: TextStyle(
          fontSize: 40.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w900,
          color: ApplicationColors.primaryTextColorLight,
          height: 2
        ),
        headline2: TextStyle(
          fontSize: 32.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700,
          color: ApplicationColors.primaryTextColorLight,
          height: 1.8
        ),
        headline3: TextStyle(
          fontSize: 24.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          color: ApplicationColors.primaryTextColorLight,
          height: 1.5
        ),
        headline4: TextStyle(
          fontSize: 20.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          color: ApplicationColors.primaryTextColorLight,
          letterSpacing: 1.0,
          height: 1.5
        ),
        headline5: TextStyle(
          fontSize: 16.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w300,
          color: ApplicationColors.primaryTextColorLight,
          letterSpacing: 1.0,
          height: 1.5
        ),
        headline6: TextStyle(
          fontSize: 14.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w300,
          color: ApplicationColors.primaryTextColorLight,
          height: 1.2
        ),
        bodyText1: TextStyle(
          fontSize: 12.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          color: ApplicationColors.primaryTextColorLight,
          letterSpacing: 1.2,
          height: 1.5
        ),
        bodyText2: TextStyle(
          fontSize: 14.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          color: ApplicationColors.primaryTextColorLight,
          letterSpacing: 1.0,
          height: 1.5
        ),
        subtitle1: TextStyle(
          fontSize: 12.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          color: ApplicationColors.primaryTextColorLight,
          letterSpacing: 1.2,
          height: 1.5
        ),
        subtitle2: TextStyle(
          fontSize: 14.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          color: ApplicationColors.primaryTextColorLight,
          letterSpacing: 1.0,
          height: 1.5
        ),
        caption: TextStyle(
          fontSize: 16.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          color: ApplicationColors.primaryTextColorLight,
          letterSpacing: 1.0,
          height: 2.0
        ),
        button: TextStyle(
          fontSize: 20.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          color: ApplicationColors.primaryTextColorLight,
          letterSpacing: 1.0,
          height: 2.0
        ),
        overline: TextStyle(
          fontSize: 14.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w300,
          color: ApplicationColors.primaryTextColorLight,
          letterSpacing: 1.0,
          height: 1.5
        ),
      )
    );
  }
}