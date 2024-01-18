import 'package:flutter/material.dart';
import 'package:umi_sea/Component/icon/icon_size.dart';
import 'package:umi_sea/Component/list_item/screen_transition_item.dart';
import 'package:umi_sea/Component/typography/header_typography.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';
import 'package:umi_sea/Component/buttons/icon_button.dart'
    as umi_sea_component;
import 'package:umi_sea/Component/icon/icon.dart' as umi_sea_icon;
import 'package:umi_sea/setting/license/license_enum.dart';
import 'package:umi_sea/setting/license/license_screen.dart';

class LicenseListScreen extends StatelessWidget {
  const LicenseListScreen({super.key});

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
        title: const Text("ライセンス"),
        titleTextStyle:
            HeaderTypography.middle.copyWith(color: UmiSeaColors.gray900),
      ),
      body: ListView(
        children: [
          for (final license in LicenseEnum.values)
            ScreenTransitionItem(
              nextWidget: LicenseScreen(
                title: license.title,
                content: license.content,
              ),
              title: license.title,
              shouldDisplayEnglish: true,
            ),
        ],
      ),
    );
  }
}
