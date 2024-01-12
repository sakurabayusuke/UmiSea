import 'dart:ui';

import 'package:umi_sea/Component/umi_sea_colors.dart';

enum ButtonColor {
  primary(color: UmiSeaColors.blue400),
  secondary(color: UmiSeaColors.gray000);

  final Color color;
  const ButtonColor({required this.color});
}
