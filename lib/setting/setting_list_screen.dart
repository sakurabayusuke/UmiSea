import 'package:flutter/material.dart';
import 'package:umi_sea/Component/icon/icon_size.dart';
import 'package:umi_sea/Component/typography/body_typography.dart';
import 'package:umi_sea/Component/typography/header_typography.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';
import 'package:umi_sea/Component/buttons/icon_button.dart'
    as umi_sea_component;
import 'package:umi_sea/Component/icon/icon.dart' as umi_sea_icon;
import 'package:umi_sea/Component/icon/icon_widget.dart' as atom;

class SettingListScreen extends StatelessWidget {
  const SettingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titles = [
      "サブスクリプション",
      "利用規約",
      "ライセンス表示",
      "データ出典",
    ];

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
          for (final title in titles) _menuItem(title),
        ],
      ),
    );
  }
}

Widget _menuItem(String title) {
  return GestureDetector(
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
            icon: umi_sea_icon.Icon.go,
            iconSize: IconSize.small,
          )
        ],
      ),
    ),
  );
}
