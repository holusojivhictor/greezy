import 'package:flutter/material.dart';
import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/theme.dart';

extension AppThemeTypeExtensions on AppThemeType {
  ThemeData getThemeData(AppThemeType theme) {
    switch (theme) {
      case AppThemeType.light:
        return GreezyTheme.light();
      case AppThemeType.dark:
        return GreezyTheme.dark();
      default:
        throw Exception('Invalid theme type = $theme');
    }
  }
}