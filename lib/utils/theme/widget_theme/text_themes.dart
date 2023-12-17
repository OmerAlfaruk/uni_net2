import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class OTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyLarge: GoogleFonts.montserrat(color: Colors.deepPurple),
    headlineSmall: GoogleFonts.poppins(color: Colors.deepPurple, fontSize: 24),
  );
  static TextTheme darkTextTheme = TextTheme(
    bodyLarge: GoogleFonts.montserrat(color: Colors.white),
    headlineSmall: GoogleFonts.poppins(color: Colors.white, fontSize: 24),
  );
}