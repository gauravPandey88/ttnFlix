import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_radius.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';

class TtnflixTheme{

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: TtnflixColors.primaryColor.lightColor,
    canvasColor: TtnflixColors.canvasColor.lightColor,
    dividerColor: TtnflixColors.dividerColor.lightColor,
    disabledColor: TtnflixColors.groundColor.lightColor?.withOpacity(0.345),
    shadowColor: TtnflixColors.groundColor.lightColor?.withOpacity(0.33),
    dividerTheme: _getDividerThemeData(Brightness.light),
    chipTheme: _getChipThemeData(Brightness.light),
    inputDecorationTheme: _getInputDecorationTheme(Brightness.light),
    fontFamily: 'Inter',
    splashColor:
    defaultTargetPlatform == TargetPlatform.iOS ? Colors.transparent : null,
    appBarTheme: _appBarThemeData(Brightness.light),
    textTheme: TtnFlixTextStyle.defaultTextTheme.apply(
        bodyColor: TtnflixColors.informGreyColor.lightColor,
        displayColor: TtnflixColors.informGreyColor.lightColor),
    bottomSheetTheme: _bottomSheetThemeData(Brightness.light),
    tabBarTheme: _getDefaultTabBarTheme(Brightness.light),
    tooltipTheme: _getTooltipThemeData(Brightness.light),
    colorScheme: _getAppColorScheme(Brightness.light)
        .copyWith(background: TtnflixColors.backgroundColor.lightColor),
  );

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: TtnflixColors.primaryColor.darkColor,
      canvasColor: TtnflixColors.canvasColor.darkColor,
      dividerColor: TtnflixColors.dividerColor.darkColor,
      disabledColor: TtnflixColors.groundColor.darkColor?.withOpacity(0.345),
      shadowColor: TtnflixColors.groundColor.darkColor?.withOpacity(0.33),
      dividerTheme: _getDividerThemeData(Brightness.dark),
      chipTheme: _getChipThemeData(Brightness.dark),
      inputDecorationTheme: _getInputDecorationTheme(Brightness.dark),
      appBarTheme: _appBarThemeData(Brightness.dark),
      fontFamily: 'Inter',
      textTheme: TtnFlixTextStyle.defaultTextTheme.apply(
          bodyColor: TtnflixColors.informGreyColor.darkColor,
          displayColor: TtnflixColors.informGreyColor.darkColor),
      bottomSheetTheme: _bottomSheetThemeData(Brightness.dark),
      tabBarTheme: _getDefaultTabBarTheme(Brightness.dark),
      tooltipTheme: _getTooltipThemeData(Brightness.dark),
      colorScheme: _getAppColorScheme(Brightness.dark)
          .copyWith(background: TtnflixColors.backgroundColor.darkColor));

  static TextStyle _getTextTheme(Brightness brightness) {
    return TtnFlixTextStyle.defaultTextTheme.bodyLarge!
        .copyWith(color: TtnflixColors.primaryColor[brightness]);
  }

  static ChipThemeData _getChipThemeData(Brightness brightness) {
    const double verticalPadding = 6;
    const double horizontalPadding = 12;

    return ChipThemeData(
        backgroundColor: TtnflixColors.foundationGreyColor[brightness]!,
        disabledColor: TtnflixColors.foundationGreyColor[brightness]!,
        selectedColor: TtnflixColors.tabLimeGreenColor[brightness]!,
        secondarySelectedColor: TtnflixColors.tabLimeGreenColor[brightness]!,
        padding: const EdgeInsets.symmetric(
            vertical: verticalPadding, horizontal: horizontalPadding),
        labelStyle: _getTextTheme(brightness).copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontStyle: FontStyle.normal,
            color: TtnflixColors.informGreyColor[brightness]),
        secondaryLabelStyle: _getTextTheme(brightness).copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          fontStyle: FontStyle.normal,
          color: TtnflixColors.informGreyColor[brightness],
        ),
        brightness: brightness);
  }

  static InputDecorationTheme _getInputDecorationTheme(Brightness brightness) {
    final secondaryTextColor = TtnflixColors.tabSecondaryTextColor[brightness];

    final floatingLabelStyle =
    TtnFlixTextStyle.getBody1SemiBold().copyWith(color: secondaryTextColor);
    final helperStyle = TtnFlixTextStyle.defaultTextTheme.bodySmall!
        .copyWith(color: secondaryTextColor, height: 0.8);
    final errorColor = TtnflixColors.onErrorColor[brightness];
    final errorStyle = TtnFlixTextStyle.defaultTextTheme.bodySmall!
        .copyWith(color: errorColor, height: 0.8);

    final enabledBorderColor = TtnflixColors.dividerColor[brightness];
    final focusedBorderColor = TtnflixColors.primaryColor[brightness];
    final disabledBorderColor = TtnflixColors.onDisabledBoundaryColor[brightness];

    InputBorder border({Color? color}) {
      return OutlineInputBorder(
        borderSide: BorderSide(color: color ?? Colors.white),
        borderRadius: const BorderRadius.all(
            Radius.circular(TtnfixCornerRadius.cornerRadius8)),
      );
    }

    return InputDecorationTheme(
      border: border(),
      enabledBorder: border(color: enabledBorderColor),
      focusedBorder: border(color: focusedBorderColor),
      disabledBorder: border(color: disabledBorderColor),
      errorBorder: border(color: errorColor),
      helperStyle: helperStyle,
      errorStyle: errorStyle,
      floatingLabelStyle: floatingLabelStyle,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.all(TtnflixSpacing.spacing16),
    );
  }

  static DividerThemeData _getDividerThemeData(Brightness brightness) {
    return DividerThemeData(
      color: TtnflixColors.dividerColor[brightness],
      thickness: 0.5,
      space: 0.5,
      indent: 0,
      endIndent: 0,
    );
  }

  static AppBarTheme _appBarThemeData(Brightness brightness) {
    return AppBarTheme(
        backgroundColor: TtnflixColors.canvasColor[brightness],
        iconTheme: IconThemeData(color: TtnflixColors.primaryColor[brightness]),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: brightness,
            statusBarIconBrightness: brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
            statusBarColor: Colors.transparent));
  }

  static ColorScheme _getAppColorScheme(Brightness brightness) {
    return ColorScheme(
        primary: TtnflixColors.primaryColor[brightness]!,
        secondary: TtnflixColors.secondaryColor[brightness]!,
        surface: TtnflixColors.canvasColor[brightness]!,
        background: TtnflixColors.backgroundColor[brightness]!,
        error: TtnflixColors.errorColor[brightness]!,
        onPrimary: TtnflixColors.onPrimary[brightness]!,
        onSecondary: TtnflixColors.onSecondary[brightness]!,
        onSurface: TtnflixColors.onSurface[brightness]!,
        onBackground: TtnflixColors.onBackgroundColor[brightness]!,
        onError: TtnflixColors.onErrorColor[brightness]!,
        brightness: brightness);
  }

  static BottomSheetThemeData _bottomSheetThemeData(Brightness brightness) =>
      BottomSheetThemeData(
          modalBackgroundColor:
          TtnflixColors.groundColor[brightness]!.withOpacity(0.2),
          modalBarrierColor:
          TtnflixColors.groundColor[brightness]?.withOpacity(0.2));

  static TabBarTheme _getDefaultTabBarTheme(Brightness brightness) {
    return TabBarTheme(
        labelColor: TtnflixColors.informGreyColor[brightness],
        unselectedLabelColor: TtnflixColors.tabSecondaryTextColor[brightness],
        unselectedLabelStyle: TtnFlixTextStyle.defaultTextTheme.titleSmall,
        labelStyle: TtnFlixTextStyle.defaultTextTheme.titleSmall);
  }

  static TooltipThemeData _getTooltipThemeData(Brightness brightness) {
    return const TooltipThemeData(showDuration: Duration(minutes: 10));
  }
}