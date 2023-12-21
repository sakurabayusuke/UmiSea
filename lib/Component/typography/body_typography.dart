import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// シングルトン
class BodyTypography {
  static const BodyTypography _body = BodyTypography._singleton();
  const BodyTypography._singleton();
  factory BodyTypography() => _body;

  static const _regularWeight = FontWeight.w300;
  static const _bold = FontWeight.w500;

  static final _font = GoogleFonts.kosugi(fontWeight: _regularWeight);

  /// fontSize:18
  static final extraLarge = _font.copyWith(fontSize: 18);

  /// fontSize:18 Bold
  static final extraLargeBold =
      BodyTypography.extraLarge.copyWith(fontWeight: _bold);

  /// fontSize:16
  static final large = _font.copyWith(fontSize: 16);

  /// fontSize:16 Bold
  static final largeBold = BodyTypography.large.copyWith(fontWeight: _bold);

  /// fontSize:14
  static final middle = _font.copyWith(fontSize: 14);

  /// fontSize:14 Bold
  static final middleBold = BodyTypography.middle.copyWith(fontWeight: _bold);

  /// fontSize:12
  static final small = _font.copyWith(fontSize: 12);

  /// fontSize:12 Bold
  static final smallBold = BodyTypography.small.copyWith(fontWeight: _bold);
}
