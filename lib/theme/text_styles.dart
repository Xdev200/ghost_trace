import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  static TextStyle get heading => GoogleFonts.orbitron(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.coolSky,
        letterSpacing: 8,
      );

  static TextStyle get subHeading => GoogleFonts.orbitron(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.pearlAqua,
      );

  static TextStyle get body => GoogleFonts.shareTechMono(
        fontSize: 14,
        color: AppColors.white,
      );

  static TextStyle get stats => GoogleFonts.shareTechMono(
        fontSize: 12,
        color: AppColors.powderBlue,
      );

  static TextStyle get buttonText => GoogleFonts.orbitron(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      );
}
