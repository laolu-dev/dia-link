import 'package:flutter/material.dart';
import 'package:talker_logger/talker_logger.dart';

class AppConstants {
  AppConstants._();
  static final AppConstants _instance = AppConstants._();
  static AppConstants get instance => _instance;

  final String poppinsFont = "Poppins";
  final String cooperBtFont = "Cooper BT";

  final TalkerLogger logging = TalkerLogger();

  void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

class AppColors {
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFFA8D5E2);
  static const Color error = Color(0xFFFF6F61);
  static const Color success = Color(0xFF9FE6A0);
  static const Color background = Color(0xFFF7F9FB);
  static const Color textColor = Color(0xFF3C4043);
  static const Color white = Colors.white;
}
