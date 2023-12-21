import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// シングルトン
class LabelTypography {
  static const LabelTypography _label = LabelTypography._singleton();
  const LabelTypography._singleton();
  factory LabelTypography() => _label;

  static final _font = GoogleFonts.kosugi();

  /// fontSize:18
  static final extraLarge = _font.copyWith(fontSize: 18);

  /// fontSize:18 Bold
  static final extraLargeBold =
      LabelTypography.extraLarge.copyWith(fontWeight: FontWeight.bold);

  /// fontSize:16
  static final large = _font.copyWith(fontSize: 16);

  /// fontSize:16 Bold
  static final largeBold =
      LabelTypography.large.copyWith(fontWeight: FontWeight.bold);

  /// fontSize:14
  static final middle = _font.copyWith(fontSize: 14);

  /// fontSize:14 Bold
  static final middleBold =
      LabelTypography.middle.copyWith(fontWeight: FontWeight.bold);

  /// fontSize:12
  static final small = _font.copyWith(fontSize: 12);

  /// fontSize:12 Bold
  static final smallBold =
      LabelTypography.small.copyWith(fontWeight: FontWeight.bold);

  /// fontSize:10
  static final extraSmall = _font.copyWith(fontSize: 10);

  /// fontSize:10 Bold
  static final extraSmallBold =
      LabelTypography.extraSmall.copyWith(fontWeight: FontWeight.bold);

  /// fontSize:10
  static final extraExtraSmall = _font.copyWith(fontSize: 8);

  /// fontSize:10 Bold
  static final extraExtraSmallBold =
      LabelTypography.extraExtraSmall.copyWith(fontWeight: FontWeight.bold);
}
