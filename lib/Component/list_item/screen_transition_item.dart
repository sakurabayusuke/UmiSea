import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umi_sea/Component/icon/icon_size.dart';
import 'package:umi_sea/Component/typography/body_typography.dart';
import 'package:umi_sea/Component/icon/icon.dart' as icon_enum;
import 'package:umi_sea/Component/icon/icon_widget.dart' as atom;
import 'package:umi_sea/Component/umi_sea_colors.dart';

class ScreenTransitionItem extends StatelessWidget {
  const ScreenTransitionItem({
    super.key,
    required this.nextWidget,
    required this.title,
    required this.shouldDisplayEnglish,
  });

  final Widget nextWidget;
  final String title;
  final bool shouldDisplayEnglish;

  @override
  Widget build(BuildContext context) {
    final fontStyle = shouldDisplayEnglish
        ? BodyTypography.extraLarge
            .copyWith(fontFamily: GoogleFonts.istokWeb().fontFamily)
        : BodyTypography.extraLarge;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return nextWidget;
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1, 0);
              const end = Offset.zero;
              final tween = Tween(begin: begin, end: end).chain(
                CurveTween(
                  curve: Curves.easeIn,
                ),
              );
              final animeOffset = animation.drive(tween);
              return SlideTransition(position: animeOffset, child: child);
            },
            transitionDuration: const Duration(
              milliseconds: 180,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: UmiSeaColors.gray000,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: fontStyle,
              ),
            ),
            const atom.Icon(
              icon: icon_enum.Icon.go,
              iconSize: IconSize.small,
            )
          ],
        ),
      ),
    );
  }
}
