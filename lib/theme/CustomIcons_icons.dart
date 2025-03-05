// Place fonts/CustomIcons.ttf in your fonts/ directory and
// add the following to your pubspec.yaml
// flutter:
//   fonts:
//    - family: CustomIcons
//      fonts:
//       - asset: fonts/CustomIcons.ttf
import 'package:flutter/widgets.dart';

class CustomIcons {
  CustomIcons._();

  static const String _fontFamily = 'CustomIcons';

  static const IconData calendar = IconData(0xe901, fontFamily: _fontFamily);
  static const IconData engine = IconData(0xe902, fontFamily: _fontFamily);
  static const IconData eye = IconData(0xe903, fontFamily: _fontFamily);
  static const IconData ai = IconData(0xe906, fontFamily: _fontFamily);
  static const IconData fuel = IconData(0xe907, fontFamily: _fontFamily);
  static const IconData copy = IconData(0xe90b, fontFamily: _fontFamily);
  static const IconData home = IconData(0xe90c, fontFamily: _fontFamily);
  static const IconData unlock = IconData(0xe90f, fontFamily: _fontFamily);
  static const IconData vehicle = IconData(0xe910, fontFamily: _fontFamily);
  static const IconData world = IconData(0xe911, fontFamily: _fontFamily);
}
