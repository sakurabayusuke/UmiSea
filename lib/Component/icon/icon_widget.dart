import 'package:flutter/material.dart' as material;
import 'package:flutter_svg/svg.dart';
import 'package:umi_sea/Component/icon/icon_size.dart';
import "package:umi_sea/Component/icon/icon.dart" as atoms;

class Icon extends material.StatelessWidget {
  final atoms.Icon icon;
  final IconSize iconSize;

  const Icon({
    super.key,
    required this.icon,
    this.iconSize = IconSize.middle,
  });

  @override
  material.Widget build(material.BuildContext context) {
    return SvgPicture.asset(
      icon.path,
      semanticsLabel: icon.toString(),
      width: iconSize.size,
    );
  }
}
