import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:umi_sea/Component/icon/icon.dart' as umi_sea;
import 'package:umi_sea/Component/icon/icon_size.dart';
import 'package:umi_sea/Component/typography/header_typography.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            UmiSeaColors.splashTop,
            UmiSeaColors.splashBottom,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              umi_sea.Icon.coral.path,
              width: IconSize.splash.size,
              height: IconSize.splash.size,
              colorFilter: const ColorFilter.mode(
                UmiSeaColors.gray000,
                BlendMode.srcIn,
              ),
            ),
            Text(
              "SEA FARLEN",
              style: HeaderTypography.splash,
            )
          ],
        ),
      ),
    );
  }
}
