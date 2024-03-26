
import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext {
  /// Return true if the this route can be popped,
  ///


  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

  bool get isSmallScreen => width < 700;
  bool get isLargeScreen => width > 1200;
  bool get isMediumScreen => width >= 700 && width <= 1200;

  bool isCustomLargeScreen(int customWidth) {
    return width > customWidth;
  }

  bool isCustomMediumScreen(int minCustomWidth, int maxCustomWidth) {
    return width >= minCustomWidth && width < maxCustomWidth;
  }

  bool isCustomSmallScreen(int maxCustomWidth) {
    return width < maxCustomWidth;
  }

  bool get isSmallScreenDrawer => width < 1100;
}
