import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kDark = Colors.black;
Color kWhite = Colors.white;
Color kForestGreen = const Color(0xFF224220);
Color kTeaGreen = const Color(0xFFC0EFCA);

class Styles {
  static const edgeInsetAll16 = EdgeInsets.all(16);
  static const edgeInsetAll10 = EdgeInsets.all(10);
  static const edgeInsetAll7 = EdgeInsets.all(7);
  static const edgeInsetAll5 = EdgeInsets.all(5);
  static const edgeInsetAll3 = EdgeInsets.all(3);
  static const edgeInsetAll0 = EdgeInsets.zero;
  static const edgeInsetHorizontal16 = EdgeInsets.symmetric(horizontal: 16);
  static const edgeInsetVertical5 = EdgeInsets.symmetric(vertical: 5);
  static const edgeInsetHorizontal5 = EdgeInsets.symmetric(horizontal: 5);
  static const edgeInsetVertical16 = EdgeInsets.symmetric(vertical: 16);
  static const edgeInsetVertical10 = EdgeInsets.symmetric(vertical: 10);
  static const edgeInsetHorizontal10 = EdgeInsets.symmetric(horizontal: 10);
  static const edgeInsetHorizontal10Vertical5 = EdgeInsets.symmetric(horizontal: 10, vertical: 5);
  static const edgeInsetSymmetric10 = EdgeInsets.symmetric(horizontal: 10, vertical: 10);
  static const edgeInsetSymmetric8 = EdgeInsets.symmetric(horizontal: 8, vertical: 8);
  static const edgeInsetSymmetric5 = EdgeInsets.symmetric(horizontal: 5, vertical: 5);

  static const homeContentPadding = EdgeInsets.only(left: 15, top: 5, bottom: 5);
  static const altHomeContentPadding = EdgeInsets.symmetric(horizontal: 15, vertical: 5);

  static const edgeInsetHorizontal16Top10 = EdgeInsets.only(left: 16, right: 16, top: 10);

  static const alertContentPadding = EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 5);

  static const altAlertContentPadding = EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12);

  static const pickerAlertContentPadding = EdgeInsets.only(left: 24, right: 24, top: 14, bottom: 6);

  static const signAlertContentPadding = EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 12);

  static const double smallButtonSplashRadius = 18;

  static const formFieldMargin = EdgeInsets.all(16);

  static const modalBottomSheetShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(25),
      topLeft: Radius.circular(25),
    ),
  );

  static const modalBottomSheetContainerMargin = EdgeInsets.only(left: 10, right: 10, bottom: 10);
  static const modalBottomSheetContainerPadding = EdgeInsets.only(left: 10, right: 10, top: 10);

  static double getIconSizeForItemPopupMenuFilter(bool forDefaultIcons) {
    return forDefaultIcons ? 24 : 18;
  }

  static OutlineInputBorder outlineInputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      gapPadding: 5,
    );
  }

  static BorderRadius homeCardItemBorderRadius = BorderRadius.circular(15);

  static const double mediumButtonSplashRadius = 25;

  static const expandedBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(15),
    topRight: Radius.circular(15),
  );

  static const cardItemDetailShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(20),
      topLeft: Radius.circular(20),
    ),
  );

  static const formFieldBorder = OutlineInputBorder(
    borderSide: BorderSide(),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static const editFormFieldBorder = UnderlineInputBorder(
    borderSide: BorderSide(width: 1.5, color: Colors.grey),
  );

  static const onboardingFieldBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );

  static const formFieldPadding = EdgeInsets.symmetric(horizontal: 14, vertical: 18);

  static const editFormFieldPadding = EdgeInsets.symmetric(horizontal: 0, vertical: 7);

  static const double materialCardHeight = 270;
  static const double materialCardWidth = 220;
  static const double homeCardHeight = 170;
  static const double homeCardWidth = 280;

  static const double cardThreeElevation = 3;
  static const double cardTenElevation = 10;

  static const circularBorderRadius5 = BorderRadius.all(Radius.circular(5));

  static const circularBorderRadius7 = BorderRadius.all(Radius.circular(7));

  static const mainCardBorderRadius = BorderRadius.all(Radius.circular(10));

  static const settingsCardBorderRadius = BorderRadius.all(Radius.circular(5));

  static const alertDialogBorderRadius = BorderRadius.all(Radius.circular(5));

  static const circleTapBorderRadius = BorderRadius.all(Radius.circular(20));

  static const RoundedRectangleBorder mainCardShape = RoundedRectangleBorder(borderRadius: mainCardBorderRadius);

  static const RoundedRectangleBorder settingsCardShape = RoundedRectangleBorder(borderRadius: settingsCardBorderRadius);

  static const RoundedRectangleBorder alertDialogShape = RoundedRectangleBorder(borderRadius: alertDialogBorderRadius);
}

class GreezyTheme {
  static Typography textTypography = Typography.material2021();

  static TextTheme darkText = ThemeData.light().textTheme.apply(bodyColor: Colors.black, displayColor: Colors.black);

  static TextTheme lightText = ThemeData.dark().textTheme.apply(bodyColor: Colors.black, displayColor: Colors.black);

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.sora(textStyle: darkText.displayLarge),
    displayMedium: GoogleFonts.sora(textStyle: darkText.displayMedium),
    displaySmall: GoogleFonts.sora(textStyle: darkText.displaySmall),
    headlineLarge: GoogleFonts.sora(textStyle: darkText.headlineLarge),
    headlineMedium: GoogleFonts.sora(textStyle: darkText.headlineMedium),
    headlineSmall: GoogleFonts.sora(textStyle: darkText.headlineSmall),
    titleLarge: GoogleFonts.sora(textStyle: darkText.titleLarge),
    titleMedium: GoogleFonts.sora(textStyle: darkText.titleMedium),
    titleSmall: GoogleFonts.sora(textStyle: darkText.titleSmall),
    bodyLarge: GoogleFonts.sora(textStyle: darkText.bodyLarge),
    bodyMedium: GoogleFonts.sora(textStyle: darkText.bodyMedium),
    bodySmall: GoogleFonts.sora(textStyle: darkText.bodySmall),
    labelLarge: GoogleFonts.sora(textStyle: darkText.labelLarge),
    labelMedium: GoogleFonts.sora(textStyle: darkText.labelMedium),
    labelSmall: GoogleFonts.sora(textStyle: darkText.labelSmall),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.sora(textStyle: lightText.displayLarge),
    displayMedium: GoogleFonts.sora(textStyle: lightText.displayMedium),
    displaySmall: GoogleFonts.sora(textStyle: lightText.displaySmall),
    headlineLarge: GoogleFonts.sora(textStyle: lightText.headlineLarge),
    headlineMedium: GoogleFonts.sora(textStyle: lightText.headlineMedium),
    headlineSmall: GoogleFonts.sora(textStyle: lightText.headlineSmall),
    titleLarge: GoogleFonts.sora(textStyle: lightText.titleLarge),
    titleMedium: GoogleFonts.sora(textStyle: lightText.titleMedium),
    titleSmall: GoogleFonts.sora(textStyle: lightText.titleSmall),
    bodyLarge: GoogleFonts.sora(textStyle: lightText.bodyLarge),
    bodyMedium: GoogleFonts.sora(textStyle: lightText.bodyMedium),
    bodySmall: GoogleFonts.sora(textStyle: lightText.bodySmall),
    labelLarge: GoogleFonts.sora(textStyle: lightText.labelLarge),
    labelMedium: GoogleFonts.sora(textStyle: lightText.labelMedium),
    labelSmall: GoogleFonts.sora(textStyle: lightText.labelSmall),
  );

  static ThemeData light() {
    return ThemeData(
      dividerColor: const Color(0xFFF9F9F9),
      bottomAppBarColor: const Color(0xFFF1F1F1),
      canvasColor: Colors.grey[50],
      cardColor: Colors.white,
      shadowColor: Colors.black,
      indicatorColor: Colors.black,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF1F1F1),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      typography: textTypography,
      textTheme: lightTextTheme,
      primaryColor: const Color(0xFFFE645C),
      colorScheme: const ColorScheme.light(primary: Color(0xFFFE645C)).copyWith(secondary: const Color(0xFFFBE8DF)),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      dividerColor: Colors.black,
      bottomAppBarColor: const Color(0xFF272C2F),
      canvasColor: Colors.black54,
      cardColor: Colors.grey.shade900,
      shadowColor: Colors.white,
      indicatorColor: Colors.white,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF000000),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      typography: textTypography,
      textTheme: darkTextTheme,
      primaryColor: const Color(0xFFFE645C),
      colorScheme: const ColorScheme.dark(primary: Color(0xFFFE645C)).copyWith(secondary: const Color(0xFFFBE8DF)),
    );
  }
}