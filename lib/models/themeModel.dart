import 'package:flutter/material.dart';

enum TYPE { E_COLD, E_HOT, E_PASTE, E_LENGTH }

class themeData {
  static const List<Color> themeColors = [
    Color(0xFFe8816d),
    Color(0xFF437BF5),
    Color(0xFF7E43F5)
  ];
  static const Color textColor = Color(0xFFFFFFFF);
  static Color themeColor = themeColors[0];
  static TYPE type = TYPE.E_COLD;

  static void changeTheme(TYPE t) {
    type = t;
    themeColor = themeColors[t.index];
  }
}