import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


ThemeData darkTheme = ThemeData(
  // scaffoldBackgroundColor: appColors.backgroundColor,
  fontFamily: GoogleFonts.jost().fontFamily,
  textTheme: GoogleFonts.jostTextTheme(),
  // AppBar Theme
  appBarTheme: AppBarTheme(shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),)),
    toolbarHeight: 80,
    color: const Color(0xFF1D1F2A), // AppBar background color
    elevation: 4,
    titleTextStyle: GoogleFonts.jost(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme:
    IconThemeData(color: Colors.white), // AppBar icon color
  ),

  // TextField Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF736A68),
    prefixIconColor:
    Colors.white, // Background color of the text field
    labelStyle: GoogleFonts.jost(
      color: Colors.white, // Label color
    ),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    floatingLabelStyle: GoogleFonts.jost(
        backgroundColor: const Color(0xFF736A68),
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: const Color(0xFF1D1F2A),
    foregroundColor: Colors.white,
  ),
);

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    path.lineTo(0, rect.height); // Start at the bottom-left
    path.quadraticBezierTo(
      rect.width / 2, // Control point X (center of the screen)
      rect.height + 30, // Control point Y (30px downward curve)
      rect.width, // End X (right edge)
      rect.height, // End Y (bottom-right corner)
    );
    path.lineTo(rect.width, 0); // Top-right corner
    path.lineTo(0, 0); // Top-left corner
    path.close(); // Close the path
    return path;
  }
}