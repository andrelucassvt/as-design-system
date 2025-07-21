import 'package:flutter/material.dart';

class AsConfig {
  static Color primaryColor = Colors.white;
  static Color primaryColorDark = Colors.white;
  static Color iconColor = Colors.black;
  static Color iconColorDark = Colors.black;
  static Color textColor = Colors.black;
  static Color textColorDark = Colors.black;

  void init({
    Color? primaryColor,
    Color? primaryColorDark,
    Color? iconColor,
    Color? textColor,
    Color? iconColorDark,
    Color? textColorDark,
  }) {
    if (primaryColor != null) {
      AsConfig.primaryColor = primaryColor;
      if (primaryColorDark == null) {
        AsConfig.primaryColorDark = primaryColor;
      }
    }
    if (iconColor != null) {
      AsConfig.iconColor = iconColor;
      if (iconColorDark == null) {
        AsConfig.iconColorDark = iconColor;
      }
    }
    if (textColor != null) {
      AsConfig.textColor = textColor;
      if (textColorDark == null) {
        AsConfig.textColorDark = textColor;
      }
    }
    if (primaryColorDark != null) {
      AsConfig.primaryColorDark = primaryColorDark;
    }
    if (iconColorDark != null) {
      AsConfig.iconColorDark = iconColorDark;
    }
    if (textColorDark != null) {
      AsConfig.textColorDark = textColorDark;
    }
  }
}
