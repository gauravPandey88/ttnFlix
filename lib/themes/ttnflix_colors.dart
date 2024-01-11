import 'package:flutter/material.dart';

class TtnflixColors {
  TtnflixColors._();

  static const Color _genuineGreen = Color(0xFF008542);
  static const Color _primaryOnPressedGreen = Color(0xFF006A35);
  static const Color _tabLimeGreen = Color(0xFF25EC6C);
  static const Color _accentPressed = Color(0xFF1EBD56);
  static const Color _positiveGreen = Color(0xFFE6F3EC);
  static const Color _positiveGreenDark = Color(0xFF001B0D);

  static const Color _connectedBlue = Color(0xFF0B78AF);
  static const Color _bulletinBlue = Color(0xFFE7F2F7);
  static const Color _bulletinBlueDark = Color(0xFF021823);
  static const Color _linkBlue = Color(0xFF09608C);

  static const Color _passionateYellow = Color(0xFFFED418);
  static const Color _attentionYellow = Color(0xFFFFF6D1);
  static const Color _attentionYellowDark = Color(0xFF4C4007);
  static const Color _frozenListYellow = Color(0xFFFFE8A5);

  static const Color goldYellow = Color(0xFFFFD931);
  static const Color whiteGlow = Color(0xFFFFFAE4);
  static const Color greenPromo = Color(0xFF10EB5E);
  static const Color greenGlow = Color(0xCCDDFFE9);
  static const Color greenIconColor = Color(0xFF008542);
  static const Color grey10 = Color(0xFFE6E6E6);
  static const Color _lightGreenColor = Color(0xFFE5F3EC);
  static const Color _camDividerColor = Color(0xFF173B3E);

  static const Color _cellGrey = Color(0xFF6D6D6D);
  static const Color _headerCellColor = Color(0XFF00282B);
  static const Color _green20 = Color(0XFFCCE7D9);
  static const Color strokeColor = Color(0XFFF4F4F4);

  static const Color _pureBlack = Color(0xFF000000);
  static const Color _summaryGrey = Color(0xFF676767);
  static const Color _summaryGreen = Color(0xFFF2F9F5);
  static const Color _blockingPurple = Color(0xFFF8F7FF);


  /// Error icons
  /// Text colour of error message
  /// Input field outline on input error
  static const Color _actionRed = Color(0xFFAE0000);
  static const Color _radiusColor = Color(0x42000000);
  static const Color _cautiousRed = Color(0xFFEFCCCC);
  static const Color _cautiousRedDark = Color(0xFF340000);

  static const Color _excitingOrange = Color(0xFFD34600);
  static const Color _excitingOrangeDark = Color(0xFFA93800);
  static const Color _honestOrange = Color(0xFFFBEDE6);

  static const Color _pureWhite = Color(0xFFFFFFFF);
  static const Color _pureDark = Color(0xFF000000);

  static const Color _foundationGrey = Color(0xFFF2F2F2);
  static const Color _foundationGreyDark = Color(0xFF0D0D0D);
  static const Color _boundaryGrey = Color(0xFFE5E5E5);
  static const Color _mellowGrey = Color(0xFFCCCCCC);
  static const Color _guidingGrey = Color(0xFF737373);
  static const Color _guidingGreyDark = Color(0xFF8C8C8C);
  static const Color _groundGrey = Color(0xFF333333);
  static const Color _informGrey = Color(0xFF191919);
  static const Color _textInfoGrey = Color(0xFF6E6E6E);
  static const Color _disclaimerGrey = Color(0xB0333333);

  static const Color _venueModeGreen = Color(0xFF072F16);

  static const Color _skyRacing1 = Color(0xFFEB0141);
  static const Color _skyRacing2 = Color(0xFF01BEFF);
  static const Color _skyRacingThoroughbred = Color(0xFFB63BA6);
  static const Color _standingTableDivider = Color(0xFF3577AA);

  static const Color _lightGreen = Color(0xFF3A982C);
  static const Color _brightWhite = Color(0xF5F5F5DF);
  static const Color _lightGrey = Color(0xFFE0E0E0);
  static const Color _mediumGrey = Color(0xFF9E9E9E);
  static const Color _darkGrey = Color(0xFF757575);
  static const Color _toolTipBgDark = Color(0xFF333333);
  static const Color _toolTipBgLight = Color(0xD9FFFFFF);
  static const Color _transparent = Color(0x00000000);
  static const Color _containerBackground = Color(0xFFFBFBFB);
  static const Color _selectedTabDividerColor = Color(0xFF3A982C);

  static const Color _gridGreen = Color(0xFFF4FEF8);
  static const Color _gridRed = Color(0xFFFDF6F2);
  static const Color _gridBlue = Color(0xFFF3F8FB);
  static const Color _gridYellow = Color(0xFFFFFDF4);
  static const Color _yellowBorderColor = Color(0xFFE5BF16);
  static const Color _redBorderColor = Color(0xFFD68080);
  static const Color _dataTableCellRedColor = Color(0xFFF7E5E5);
  static const Color _borderOutlineColor = Color(0xFFE9E9E9);

  static final Map<Brightness, Color> transparent = _buildColor(
      lightColor: TtnflixColors._transparent, darkColor: TtnflixColors._transparent);

  static final Map<Brightness, Color> informGrey = _buildColor(
      lightColor: TtnflixColors._informGrey, darkColor: TtnflixColors._informGrey);
  static const Color _arrowColor = Color(0XFF444444);

  static final Map<Brightness, Color> mellowGreyColor = _buildColor(
      lightColor: TtnflixColors._mellowGrey, darkColor: TtnflixColors._groundGrey);

  static final Map<Brightness, Color> camDividerColor = _buildColor(
      lightColor: TtnflixColors._camDividerColor,
      darkColor: TtnflixColors._camDividerColor);

  static final Map<Brightness, Color> camDrawerSelectedColor = _buildColor(
      lightColor: TtnflixColors._lightGreenColor,
      darkColor: TtnflixColors._lightGreenColor);

  static final Map<Brightness, Color> bgTransparentGrey = _buildColor(
      lightColor: TtnflixColors._toolTipBgDark,
      darkColor: TtnflixColors._toolTipBgDark);

  static final Map<Brightness, Color> textColorWhite = _buildColor(
      lightColor: TtnflixColors._toolTipBgLight,
      darkColor: TtnflixColors._toolTipBgLight);

  static final Map<Brightness, Color> darkBlackColor = _buildColor(
      lightColor: TtnflixColors._pureBlack, darkColor: TtnflixColors._pureBlack);

  static final Map<Brightness, Color> lightGreenSummaryColor = _buildColor(
      lightColor: TtnflixColors._summaryGreen, darkColor: TtnflixColors._summaryGreen);

  static final Map<Brightness, Color> lightPurpleBlockingColor = _buildColor(
      lightColor: TtnflixColors._blockingPurple,
      darkColor: TtnflixColors._blockingPurple);

  static final Map<Brightness, Color> lightGreyColor = _buildColor(
      lightColor: TtnflixColors._summaryGrey, darkColor: TtnflixColors._summaryGrey);

  static final Map<Brightness, Color> boundaryGrey = _buildColor(
      lightColor: TtnflixColors._boundaryGrey, darkColor: TtnflixColors._groundGrey);

  static final Map<Brightness, Color> honestOrangeColor = _buildColor(
      lightColor: TtnflixColors._honestOrange,
      darkColor: TtnflixColors._excitingOrange);

  static final Map<Brightness, Color> linkColor = _buildColor(
      lightColor: TtnflixColors._connectedBlue,
      darkColor: TtnflixColors._connectedBlue);
  static final Map<Brightness, Color> standingTableDividerColor = _buildColor(
      lightColor: TtnflixColors._standingTableDivider,
      darkColor: TtnflixColors._standingTableDivider);

  static final Map<Brightness, Color> colorTextLink = _buildColor(
      lightColor: TtnflixColors._linkBlue, darkColor: TtnflixColors._linkBlue);

  static final Map<Brightness, Color> accentPressedColor = _buildColor(
      lightColor: TtnflixColors._accentPressed,
      darkColor: TtnflixColors._accentPressed);

  static final Map<Brightness, Color> guidingGreyColor = _buildColor(
      lightColor: TtnflixColors._guidingGrey,
      darkColor: TtnflixColors._guidingGreyDark);

  static final Map<Brightness, Color> passionateYellowColor = _buildColor(
      lightColor: TtnflixColors._passionateYellow,
      darkColor: TtnflixColors._passionateYellow);

  static final Map<Brightness, Color> expiredRedColor = _buildColor(
      lightColor: TtnflixColors._actionRed, darkColor: TtnflixColors._actionRed);

  static final Map<Brightness, Color> excitingOrangeColor = _buildColor(
      lightColor: TtnflixColors._excitingOrange,
      darkColor: TtnflixColors._excitingOrange);

  static final Map<Brightness, Color> excitingOrangeDark = _buildColor(
      lightColor: TtnflixColors._excitingOrangeDark,
      darkColor: TtnflixColors._excitingOrangeDark);

  static final Map<Brightness, Color> informGreyColor = _buildColor(
      lightColor: TtnflixColors._informGrey, darkColor: TtnflixColors._boundaryGrey);

  static final Map<Brightness, Color> foundationGreyColor = _buildColor(
      lightColor: TtnflixColors._foundationGrey,
      darkColor: TtnflixColors._foundationGreyDark);

  static final Map<Brightness, Color> tabLimeGreenColor = _buildColor(
      lightColor: TtnflixColors._tabLimeGreen, darkColor: TtnflixColors._tabLimeGreen);

  static final Map<Brightness, Color> tabSecondaryTextColor = _buildColor(
      lightColor: _groundGrey.withOpacity(0.69),
      darkColor: _groundGrey.withOpacity(0.69));
  static final Map<Brightness, Color> dividerColor = _buildColor(
      lightColor: _groundGrey.withOpacity(0.33),
      darkColor: TtnflixColors._pureWhite);

  static final Map<Brightness, Color> camDrawerTitleColor = _buildColor(
      lightColor: TtnflixColors._pureWhite, darkColor: TtnflixColors._pureWhite);

  static final Map<Brightness, Color> containerColor = _buildColor(
      lightColor: _containerBackground, darkColor: _containerBackground);

  static final Map<Brightness, Color> selectedTabDividerColor = _buildColor(
      lightColor: _selectedTabDividerColor,
      darkColor: _selectedTabDividerColor);

  static final Map<Brightness, Color> groundColor =
  _buildColor(lightColor: _groundGrey, darkColor: _groundGrey);

  static final Map<Brightness, Color> primaryOnPressedColor = _buildColor(
      lightColor: TtnflixColors._primaryOnPressedGreen,
      darkColor: TtnflixColors._primaryOnPressedGreen);

  static final Map<Brightness, Color> primaryColor = _buildColor(
      lightColor: TtnflixColors._genuineGreen, darkColor: TtnflixColors._genuineGreen);

  static final Map<Brightness, Color> secondaryColor = _buildColor(
      lightColor: TtnflixColors._tabLimeGreen, darkColor: TtnflixColors._tabLimeGreen);

  static final Map<Brightness, Color> accentColor = _buildColor(
      lightColor: TtnflixColors._genuineGreen, darkColor: TtnflixColors._genuineGreen);

  static final Map<Brightness, Color> canvasColor = _buildColor(
      lightColor: TtnflixColors._pureWhite, darkColor: TtnflixColors._pureDark);

  static final Map<Brightness, Color> backgroundColor = _buildColor(
      lightColor: TtnflixColors._foundationGrey,
      darkColor: TtnflixColors._foundationGreyDark);

  static final Map<Brightness, Color> surfaceColor = _buildColor(
      lightColor: TtnflixColors._boundaryGrey, darkColor: TtnflixColors._informGrey);

  static final Map<Brightness, Color> onBackgroundColor = _buildColor(
      lightColor: TtnflixColors._informGrey, darkColor: TtnflixColors._boundaryGrey);

  static final Map<Brightness, Color> errorColor = _buildColor(
      lightColor: TtnflixColors._cautiousRed,
      darkColor: TtnflixColors._cautiousRedDark);

  static final Map<Brightness, Color> onErrorColor = _buildColor(
      lightColor: TtnflixColors._actionRed, darkColor: TtnflixColors._actionRed);

  static final Map<Brightness, Color> onDisabledBoundaryColor = _buildColor(
      lightColor: TtnflixColors._boundaryGrey, darkColor: TtnflixColors._informGrey);

  static final Map<Brightness, Color> onPrimary = _buildColor(
      lightColor: TtnflixColors._pureWhite, darkColor: TtnflixColors._pureDark);

  static final Map<Brightness, Color> onSecondary = _buildColor(
      lightColor: TtnflixColors._informGrey, darkColor: TtnflixColors._boundaryGrey);

  static final Map<Brightness, Color> onSurface = _buildColor(
      lightColor: TtnflixColors._informGrey, darkColor: TtnflixColors._boundaryGrey);

  static final Map<Brightness, Color> onSurfaceInvert = _buildColor(
      lightColor: TtnflixColors._pureWhite, darkColor: TtnflixColors._pureDark);

  static final Map<Brightness, Color> passionateColor = _buildColor(
      lightColor: TtnflixColors._passionateYellow,
      darkColor: TtnflixColors._passionateYellow);

  static final Map<Brightness, Color> attentionYellowColor = _buildColor(
      lightColor: TtnflixColors._attentionYellow,
      darkColor: TtnflixColors._attentionYellowDark);

  static final Map<Brightness, Color> infoColor = _buildColor(
      lightColor: TtnflixColors._bulletinBlue,
      darkColor: TtnflixColors._bulletinBlueDark);

  static final Map<Brightness, Color> positiveColor = _buildColor(
      lightColor: TtnflixColors._positiveGreen,
      darkColor: TtnflixColors._positiveGreenDark);

  static final Map<Brightness, Color> venueModeColor = _buildColor(
      lightColor: TtnflixColors._venueModeGreen,
      darkColor: TtnflixColors._venueModeGreen);

  static final Map<Brightness, Color> cautiousRedColor = _buildColor(
      lightColor: TtnflixColors._cautiousRed, darkColor: TtnflixColors._cautiousRed);

  static final Map<Brightness, Color> textInfoGreyColor = _buildColor(
      lightColor: TtnflixColors._textInfoGrey, darkColor: TtnflixColors._textInfoGrey);

  static final Map<Brightness, Color> disclaimerGrey = _buildColor(
      lightColor: TtnflixColors._disclaimerGrey,
      darkColor: TtnflixColors._disclaimerGrey);

  static final Map<Brightness, Color> skyRacing1Color = _buildColor(
      lightColor: TtnflixColors._skyRacing1, darkColor: TtnflixColors._skyRacing1);

  static final Map<Brightness, Color> skyRacing2Color = _buildColor(
      lightColor: TtnflixColors._skyRacing2, darkColor: TtnflixColors._skyRacing2);

  static final Map<Brightness, Color> skyRacingThoroughbredColor = _buildColor(
      lightColor: TtnflixColors._skyRacingThoroughbred,
      darkColor: TtnflixColors._skyRacingThoroughbred);

  static final Map<Brightness, Color> inverseSecondary = _buildColor(
      lightColor: _pureWhite.withOpacity(0.70),
      darkColor: _pureWhite.withOpacity(0.70));

  static final Map<Brightness, Color> cellTextColor = _buildColor(
      lightColor: TtnflixColors._cellGrey, darkColor: TtnflixColors._cellGrey);

  static final Map<Brightness, Color> headerStaticTextColor = _buildColor(
      lightColor: TtnflixColors._headerCellColor,
      darkColor: TtnflixColors._headerCellColor);
  static final Map<Brightness, Color> headerStaticBackground = _buildColor(
      lightColor: TtnflixColors._green20, darkColor: TtnflixColors._green20);

  static final Map<Brightness, Color> inversePrimary =
  _buildColor(lightColor: _pureWhite, darkColor: _pureWhite);

  static final Map<Brightness, Color> darkGrey =
  _buildColor(lightColor: _darkGrey, darkColor: _darkGrey);

  static final Map<Brightness, Color> textBlackColor =
  _buildColor(lightColor: _pureDark, darkColor: _pureWhite);

  static final Map<Brightness, Color> pureWhite =
  _buildColor(lightColor: _pureWhite, darkColor: _pureWhite);

  static final Map<Brightness, Color> lightGreen =
  _buildColor(lightColor: _lightGreen, darkColor: _lightGreen);

  static final Map<Brightness, Color> brightWhite =
  _buildColor(lightColor: _brightWhite, darkColor: _brightWhite);

  static final Map<Brightness, Color> lightGrey =
  _buildColor(lightColor: _lightGrey, darkColor: _lightGrey);

  static final Map<Brightness, Color> mediumGrey =
  _buildColor(lightColor: _mediumGrey, darkColor: _mediumGrey);

  static final Map<Brightness, Color> arrowSortColor =
  _buildColor(lightColor: _arrowColor, darkColor: _arrowColor);

  static final Map<Brightness, Color> frozenListYellow =
  _buildColor(lightColor: _frozenListYellow, darkColor: _frozenListYellow);

  static final Map<Brightness, Color> radiusColor =
  _buildColor(lightColor: _radiusColor, darkColor: _radiusColor);

  static final Map<Brightness, Color> white =
  _buildColor(lightColor: _pureWhite, darkColor: _pureWhite);

  static final Map<Brightness, Color> gridGreen =
  _buildColor(lightColor: _gridGreen, darkColor: _gridGreen);

  static final Map<Brightness, Color> gridRed =
  _buildColor(lightColor: _gridRed, darkColor: _gridRed);

  static final Map<Brightness, Color> gridBlue =
  _buildColor(lightColor: _gridBlue, darkColor: _gridBlue);

  static final Map<Brightness, Color> gridYellow =
  _buildColor(lightColor: _gridYellow, darkColor: _gridYellow);

  static final Map<Brightness, Color> yellowBorderColor = _buildColor(
      lightColor: _yellowBorderColor, darkColor: _yellowBorderColor);

  static final Map<Brightness, Color> redBorderColor =
  _buildColor(lightColor: _redBorderColor, darkColor: _redBorderColor);

  static final Map<Brightness, Color> strokeGreyColor =
  _buildColor(lightColor: strokeColor, darkColor: strokeColor);

  static final Map<Brightness, Color> dataTableCellRedColor = _buildColor(
      lightColor: _dataTableCellRedColor, darkColor: _dataTableCellRedColor);

  static final Map<Brightness, Color> borderOutlineColor = _buildColor(
      lightColor: _borderOutlineColor, darkColor: _borderOutlineColor);

  static Map<Brightness, Color> _buildColor(
      {required Color lightColor, required Color darkColor}) {
    final Map<Brightness, Color> colorMap = {};

    colorMap.putIfAbsent(Brightness.light, () => lightColor);
    colorMap.putIfAbsent(Brightness.dark, () => darkColor);

    return colorMap;
  }
}

extension ColorMap on Map<Brightness, Color> {
  Color? get lightColor => this[Brightness.light];

  Color? get darkColor => this[Brightness.dark];

  Color? platformBrightnessColor(BuildContext context) {
    // We need to check the theme mode to be able disable dark mode completely.
    // Indeed, Platform.brightness will still be `dark` even if we force the ThemeMode to be `light` in the MaterialApp.
    final ThemeMode themeMode =
        context.findAncestorWidgetOfExactType<MaterialApp>()?.themeMode ??
            ThemeMode.system;
    final Brightness brightness;

    switch (themeMode) {
      case ThemeMode.system:
        brightness = MediaQuery.of(context).platformBrightness;
        break;
      case ThemeMode.light:
        brightness = Brightness.light;
        break;
      case ThemeMode.dark:
        brightness = Brightness.dark;
        break;
    }

    return this[brightness];
  }
}