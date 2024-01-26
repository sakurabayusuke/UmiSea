import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:umi_sea/Component/buttons/button_color.dart';
import 'package:umi_sea/Component/icon/icon_size.dart';
import "package:umi_sea/Component/icon/icon.dart" as atoms;
import 'package:umi_sea/Component/umi_sea_colors.dart';

class IconButton extends material.StatelessWidget {
  final atoms.Icon icon;
  final IconSize iconSize;
  final ButtonColor buttonColor;
  final bool onlyIcon;
  final Function() onPressed;

  const IconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconSize = IconSize.middle,
    this.buttonColor = ButtonColor.primary,
    this.onlyIcon = false,
  });

  @override
  material.Widget build(material.BuildContext context) {
    final colorScheme = material.Theme.of(context).colorScheme;

    return material.Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: onlyIcon
            ? null
            : [
                material.BoxShadow(
                  color: UmiSeaColors.blue900.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(4, 4),
                ),
              ],
      ),
      child: material.SizedBox(
        height: 48.0,
        width: 48.0,
        child: material.IconButton(
          icon: SvgPicture.asset(
            icon.path,
            semanticsLabel: icon.toString(),
            width: iconSize.size,
          ),
          onPressed: onPressed,
          style: material.IconButton.styleFrom(
            foregroundColor: colorScheme.onPrimary,
            backgroundColor: onlyIcon ? null : buttonColor.color,
            side: onlyIcon
                ? null
                : BorderSide(
                    color: colorScheme.outline,
                    width: 0.7,
                  ),
          ),
          iconSize: iconSize.size,
        ),
      ),
    );
  }
}
