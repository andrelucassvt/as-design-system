import 'package:as_design_system/config/as_config.dart';
import 'package:flutter/material.dart';

class AsColorBase {
  static Color primaryColor(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark
        ? AsConfig.primaryColorDark
        : AsConfig.primaryColor;
  }

  static Color iconColor(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark
        ? AsConfig.iconColorDark
        : AsConfig.iconColor;
  }

  static Color textColor(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark
        ? AsConfig.textColorDark
        : AsConfig.textColor;
  }
}
