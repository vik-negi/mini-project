// Here we are going to give the colors to the app

import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primaryColor = Color(0xFF1E1E1E);
  static const Color secondaryColor = Color(0xFF2E2E2E);
  static const Color accentColor = Color(0xFFE5E5E5);
  static const Color primaryTextColor = Color(0xFFE5E5E5);
  static const Color secondaryTextColor = Color(0xFF1E1E1E);
  static const Color accentTextColor = Color(0xFF2E2E2E);
  static const Color greenColor = Color.fromRGBO(78, 229, 196, 1);
  static const Color redColor = Color.fromRGBO(255, 0, 0, 1);
  static const Color white = Colors.white;
}

class LightAppColors extends AppColors {
  static const Color primaryColor = Color(0xFF1E1E1E);
  static const Color secondaryColor = Color(0xFF2E2E2E);
  static const Color accentColor = Color(0xFFE5E5E5);
  static const Color primaryTextColor = Color(0xFFE5E5E5);
  static const Color secondaryTextColor = Color(0xFF1E1E1E);
  static const Color accentTextColor = Color(0xFF2E2E2E);
}

class DarkAppColors extends AppColors {
  static const Color primaryColor = Color(0xFF1E1E1E);
  static const Color secondaryColor = Color(0xFF2E2E2E);
  static const Color accentColor = Color(0xFFE5E5E5);
  static const Color primaryTextColor = Color(0xFFE5E5E5);
  static const Color secondaryTextColor = Color(0xFF1E1E1E);
  static const Color accentTextColor = Color(0xFF2E2E2E);
}
