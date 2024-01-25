import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TtnFlixTextStyle {
  static TextTheme defaultTextTheme = TextTheme(
      displaySmall: TtnFlixTextStyle._getHeading3(),
      headlineLarge: TtnFlixTextStyle._getHeading7(),
      headlineMedium: TtnFlixTextStyle._getHeading4(),
      headlineSmall: TtnFlixTextStyle._getHeading5(),
      titleLarge: TtnFlixTextStyle._getHeading6(),
      titleMedium: TtnFlixTextStyle._getsubtitle1(),
      titleSmall: TtnFlixTextStyle._getSubtitle2(),
      bodyLarge: TtnFlixTextStyle._getBody1Default(),
      bodyMedium: TtnFlixTextStyle._getBody2Default(),
      labelLarge: TtnFlixTextStyle._getButton1(),
      bodySmall: TtnFlixTextStyle._getCaptionDefault(),
      labelSmall: TtnFlixTextStyle._getOverline());

  static TextStyle _getHeading3() => GoogleFonts.inter(
        fontSize: 48,
        fontWeight: FontWeight.w400,
        letterSpacing: -2.88,
      );

  static TextStyle _getHeading7() => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.2,
      );

  static TextStyle _getHeading4() => GoogleFonts.inter(
        fontSize: 34,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.34,
      );

  static TextStyle _getHeading5() => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.24,
      );

  static TextStyle _getHeading6() => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      );

  static TextStyle _getsubtitle1() => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.16,
      );

  static TextStyle _getSubtitle2() => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.14,
      );

  static TextStyle _getBody1Default() => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      );

  static TextStyle _getBody2Default() => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      );

  static TextStyle _getButton1() => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      );

  static TextStyle _getCaptionDefault() => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      );

  static TextStyle _getOverline() => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      );

  static TextStyle getBody1SemiBold() => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.16,
  );
}
