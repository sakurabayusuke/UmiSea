import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';

/// シングルトン
class HeaderTypography {
  static const HeaderTypography _header = HeaderTypography._singleton();
  const HeaderTypography._singleton();
  factory HeaderTypography() => _header;

  static final _font = GoogleFonts.kosugi();
  static final _splashFont = GoogleFonts.gidugu();

  /// fontSize: 96
  static final splash =
      _splashFont.copyWith(fontSize: 96, color: UmiSeaColors.gray000);

  /// fontSize:40
  static final extraLarge = _font.copyWith(fontSize: 40);

  /// fontSize:40 bold
  static final extraLargeBold =
      HeaderTypography.extraLarge.copyWith(fontWeight: FontWeight.bold);

  /// fontSize:32
  static final large = _font.copyWith(fontSize: 32);

  /// fontSize:32 bold
  static final largeBold =
      HeaderTypography.large.copyWith(fontWeight: FontWeight.bold);

  /// fontSize:24
  static final middle = _font.copyWith(fontSize: 24);

  /// fontSize:24 bold
  static final middleBold =
      HeaderTypography.middle.copyWith(fontWeight: FontWeight.bold);

  /// fontSize:20
  static final semiMiddle = _font.copyWith(fontSize: 20);

  /// fontSize:20 bold
  static final semiMiddleBold =
      HeaderTypography.semiMiddle.copyWith(fontWeight: FontWeight.bold);

  /// fontSize:18
  static final small = _font.copyWith(fontSize: 18);

  /// fontSize:18 bold
  static final smallBold =
      HeaderTypography.small.copyWith(fontWeight: FontWeight.bold);
}
