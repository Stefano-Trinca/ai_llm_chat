import 'package:flutter/material.dart';

extension ThemeExt on BuildContext {
  /// Theme [ThemeData] based on [BuildContext]
  ThemeData get theme => Theme.of(this);

  /// [ColorScheme] from the [ThemeData] of the App
  ColorScheme get colorScheme => theme.colorScheme;
}
