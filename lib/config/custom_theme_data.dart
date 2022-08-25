import 'package:dividends_tracker_app/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomThemeData {
  static ThemeData themeLight(BuildContext context) {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Colors.grey[800], // This
        ),
      ),
      textTheme: GoogleFonts.openSansTextTheme(
        base.textTheme.copyWith(
          headline1: base.textTheme.headline1!.copyWith(
            fontSize: 28.0,
            fontWeight: FontWeight.w400,
            color: Colors.black,
            height: 1.3,
          ),
          headline2: base.textTheme.headline2!.copyWith(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            color: Colors.grey[800],
            height: 1.5,
          ),
          headline3: base.textTheme.headline1!.copyWith(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            height: 1.3,
          ),
          headline4: base.textTheme.headline1!.copyWith(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
            fontStyle: FontStyle.italic,
            height: 1.3,
            letterSpacing: .9,
          ),
          headline5: base.textTheme.headline5!.copyWith(
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
            color: Colors.grey[800],
          ),
          headline6: base.textTheme.headline6!.copyWith(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
            height: 1.3,
            letterSpacing: .9,
          ),
          button: base.textTheme.button!.copyWith(
            color: Colors.grey[800],
            fontSize: 16.0,
            letterSpacing: .9,
            shadows: [],
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: kPrimaryColor,
          surfaceTintColor: Colors.white,
          elevation: 1,
        ),
      ),
      cardTheme: const CardTheme(
        color: Colors.white,
        surfaceTintColor: kPrimaryColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey[500],
      ),
      inputDecorationTheme: const InputDecorationTheme(
        prefixIconColor: kPrimaryColor,
        suffixIconColor: kPrimaryColor,
      ),
    );
  }
}
