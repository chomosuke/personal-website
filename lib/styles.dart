import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/colored_text.dart';

final display1 = GoogleFonts.yatraOne(fontSize: 128, height: 1);
final heading1 = GoogleFonts.comfortaa(fontSize: 48);
final heading2 = ColoredTextStyle(
  textStyle: GoogleFonts.comfortaa(fontSize: 40),
  colorHeight: 22,
  topOffset: 13,
);
final heading3 = ColoredTextStyle(
  textStyle: GoogleFonts.rubik(fontSize: 32, fontWeight: FontWeight.w500),
  colorHeight: 17,
  topOffset: 13,
);
final heading4 = ColoredTextStyle(
  textStyle: GoogleFonts.comfortaa(fontSize: 24),
  colorHeight: 13,
  topOffset: 8.1,
);
final heading5 = ColoredTextStyle(
  textStyle: GoogleFonts.comfortaa(fontSize: 12),
  colorHeight: 6.2,
  topOffset: 4.8,
);
final label1 = ColoredTextStyle(
  textStyle: GoogleFonts.rubik(fontSize: 20),
  colorHeight: 10,
  topOffset: 8.6,
);

final paragraph1Code = GoogleFonts.rubik(fontSize: 14);
const paragraphHeight = 1.6;
final paragraph1 = GoogleFonts.rubik(fontSize: 14, height: paragraphHeight);
final paragraph1Bold = GoogleFonts.rubik(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  height: paragraphHeight,
);
final link = GoogleFonts.rubik(
  fontSize: 14,
  height: paragraphHeight,
  color: const Color(0xFF0000EE),
  decoration: TextDecoration.underline,
);

const primary01 = Color(0xCCBEDAAA);
const primary02 = Color(0xCCEBA7A7);
const primary03 = Color(0xCCFFB388);
