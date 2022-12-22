import 'package:flutter/material.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData(
    primaryColor: kPrimaryColor,
    // buttonColor: kPrimaryColor,
    colorScheme: const ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kPrimaryColor,
    ),
    indicatorColor: Colors.white,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    fontFamily: "Poppins",
    shadowColor: Theme.of(context).disabledColor,
    dividerColor: const Color(0xff707070),
    canvasColor: Colors.white,
    backgroundColor: const Color(0xFFFFFFFF),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    errorColor: kErrorColor,

    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: kPrimaryColor,
    colorScheme: const ColorScheme.dark(),
    indicatorColor: Colors.white,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    fontFamily: "Poppins",
    shadowColor: Theme.of(context).disabledColor,
    dividerColor: const Color(0xff707070),
    canvasColor: Colors.white,
    backgroundColor: Colors.black,
    errorColor: kErrorColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

const kPrimaryColor = Color(0xffF76C6C);
const PrimaryColor = Color(0xffffffff);
const kWarningColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

const kDefaultPadding = 20.0;

const appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);
