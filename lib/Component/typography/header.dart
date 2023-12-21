import 'package:google_fonts/google_fonts.dart';

/// Header Typography
class Header {
  static const Header _header = Header._singleton();
  const Header._singleton();
  factory Header() => _header;

  static final _font = GoogleFonts.kosugi();

  /// fontSize:40
  static final extraLarge = _font.copyWith(fontSize: 40);

  /// fontSize:32
  static final large = _font.copyWith(fontSize: 32);

  /// fontSize:24
  static final middle = _font.copyWith(fontSize: 24);

  /// fontSize:18
  static final small = _font.copyWith(fontSize: 18);

  /// fontSize:14
  static final extraSmall = _font.copyWith(fontSize: 14);
}
