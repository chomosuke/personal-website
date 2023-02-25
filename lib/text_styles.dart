import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColoredTextStyle {
  ColoredTextStyle({
    required this.textStyle,
    required this.topOffset,
    required this.colorHeight,
  });
  final TextStyle textStyle;
  final double topOffset;
  final double colorHeight;
}

final heading3 = ColoredTextStyle(
  textStyle: GoogleFonts.rubik(fontSize: 32, fontWeight: FontWeight.w500),
  colorHeight: 3,
  topOffset: 3,
);
final label1 = ColoredTextStyle(
  textStyle: GoogleFonts.rubik(fontSize: 20),
  colorHeight: 11,
  topOffset: 8.1,
);
