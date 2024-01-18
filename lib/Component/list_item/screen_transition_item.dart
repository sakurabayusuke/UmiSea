import 'package:flutter/material.dart';
import 'package:umi_sea/Component/icon/icon_size.dart';
import 'package:umi_sea/Component/typography/body_typography.dart';
import 'package:umi_sea/Component/icon/icon.dart' as icon_enum;
import 'package:umi_sea/Component/icon/icon_widget.dart' as atom;

class ScreenTransitionItem extends StatelessWidget {
  const ScreenTransitionItem(
      {super.key, required this.nextWidget, required this.title});

  final Widget nextWidget;
  final String title;

  @override
  Widget build(BuildContext context) {
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
              milliseconds: 200,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: BodyTypography.extraLarge,
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
