import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/colored_text.dart';

final display1 = GoogleFonts.yatraOne(fontSize: 128, height: 1);
final heading1 = GoogleFonts.comfortaa(fontSize: 48);
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
final heading5Underline = GoogleFonts.comfortaa(
  fontSize: 12,
  decoration: TextDecoration.underline,
);
final label1 = ColoredTextStyle(
  textStyle: GoogleFonts.rubik(fontSize: 20),
  colorHeight: 10,
  topOffset: 8.6,
);

const primary01 = Color(0xCCBEDAAA);
const primary02 = Color(0xCCEBA7A7);
const primary03 = Color(0xCCFFB388);
