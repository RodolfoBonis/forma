import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography tokens for the Forma Design System.
///
/// All styles use the Inter typeface via [GoogleFonts] and follow a
/// consistent naming convention: category + size (+ weight variant).
abstract class FormaTypography {
  /// 52px / bold — hero display text for splash / marketing screens.
  static TextStyle get displayHero =>
      GoogleFonts.inter(fontSize: 52, fontWeight: FontWeight.w700);

  /// 34px / bold — primary page heading.
  static TextStyle get h1 =>
      GoogleFonts.inter(fontSize: 34, fontWeight: FontWeight.w700);

  /// 26px / bold — secondary heading.
  static TextStyle get h2 =>
      GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w700);

  /// 22px / bold — tertiary heading.
  static TextStyle get h3 =>
      GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700);

  /// 20px / bold — quaternary heading.
  static TextStyle get h4 =>
      GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700);

  /// 18px / bold — large title.
  static TextStyle get title18 =>
      GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700);

  /// 16px / bold — medium title.
  static TextStyle get title16 =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700);

  /// 15px / semi-bold — compact title.
  static TextStyle get title15 =>
      GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600);

  /// 16px / regular — default body text.
  static TextStyle get body16 =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400);

  /// 14px / regular — secondary body text.
  static TextStyle get body14 =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400);

  /// 14px / medium — emphasized body text.
  static TextStyle get body14Medium =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500);

  /// 13px / regular — small body text.
  static TextStyle get body13 =>
      GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w400);

  /// 13px / semi-bold — emphasized small body text.
  static TextStyle get body13Bold =>
      GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600);

  /// 12px / regular — caption / helper text.
  static TextStyle get caption12 =>
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400);

  /// 12px / medium — emphasized caption text.
  static TextStyle get caption12Med =>
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500);

  /// 10px / medium — uppercase overline label.
  static TextStyle get overline10 => GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.8,
  );

  /// 10px / regular — navigation label.
  static TextStyle get nav10 =>
      GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w400);

  /// 10px / semi-bold — emphasized navigation label.
  static TextStyle get nav10Bold =>
      GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600);
}
