import 'package:flutter/material.dart';
import 'package:umi_sea/Component/icon/icon_size.dart';
import 'package:umi_sea/Component/typography/body_typography.dart';
import 'package:umi_sea/Component/typography/header_typography.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';
import 'package:umi_sea/Component/buttons/icon_button.dart'
    as umi_sea_component;
import 'package:umi_sea/Component/icon/icon.dart' as umi_sea_icon;
import 'package:umi_sea/Component/icon/icon_widget.dart' as atom;
import 'package:umi_sea/setting/setting_enum.dart';
import 'package:umi_sea/setting/setting_navigator.dart';

class SettingListScreen extends StatelessWidget {
  const SettingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: umi_sea_component.IconButton(
          icon: umi_sea_icon.Icon.back,
          onPressed: () => Navigator.of(context).pop(),
          iconSize: IconSize.middle,
          onlyIcon: true,
        ),
        backgroundColor: UmiSeaColors.blue400,
        title: const Text("設定"),
        titleTextStyle:
            HeaderTypography.middle.copyWith(color: UmiSeaColors.gray900),
      ),
      body: ListView(
        children: [
          for (final setting in SettingEnum.values) _menuItem(setting, context),
        ],
      ),
    );
  }
}

Widget _menuItem(SettingEnum setting, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SettingNavigator().getScreen(setting);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
              setting.displayName,
              style: BodyTypography.extraLarge,
            ),
          ),
          const atom.Icon(
            icon: umi_sea_icon.Icon.go,
            iconSize: IconSize.small,
          )
        ],
      ),
    ),
  );
}
