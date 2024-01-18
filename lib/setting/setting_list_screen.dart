import 'package:flutter/material.dart';
import 'package:umi_sea/Component/icon/icon_size.dart';
import 'package:umi_sea/Component/list_item/screen_transition_item.dart';
import 'package:umi_sea/Component/typography/header_typography.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';
import 'package:umi_sea/Component/buttons/icon_button.dart'
    as umi_sea_component;
import 'package:umi_sea/Component/icon/icon.dart' as umi_sea_icon;
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
          for (final setting in SettingEnum.values)
            ScreenTransitionItem(
              nextWidget: SettingNavigator().getScreen(setting),
              title: setting.displayName,
              shouldDisplayEnglish: false,
            ),
        ],
      ),
    );
  }
}
