import 'package:flutter/material.dart';
import 'package:umi_sea/Component/icon/icon_size.dart';
import 'package:umi_sea/Component/typography/body_typography.dart';
import 'package:umi_sea/Component/typography/header_typography.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';
import 'package:umi_sea/Component/buttons/icon_button.dart'
    as umi_sea_component;
import 'package:umi_sea/Component/icon/icon.dart' as umi_sea_icon;

class DataSourceScreen extends StatelessWidget {
  const DataSourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [("底質データ", "海洋状況表示システム")];

    return Scaffold(
      appBar: AppBar(
        leading: umi_sea_component.IconButton(
          icon: umi_sea_icon.Icon.back,
          onPressed: () => Navigator.of(context).pop(),
          iconSize: IconSize.middle,
          onlyIcon: true,
        ),
        backgroundColor: UmiSeaColors.blue400,
        title: const Text("データ出典"),
        titleTextStyle:
            HeaderTypography.middle.copyWith(color: UmiSeaColors.gray900),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 16),
        children: [
          for (final (String title, String content) in items)
            _menuItem(title, content),
        ],
      ),
    );
  }
}

Widget _menuItem(String title, String content) {
  return Container(
    padding: const EdgeInsets.only(left: 24),
    alignment: Alignment.topLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: HeaderTypography.semiMiddleBold.copyWith(
            color: UmiSeaColors.gray700,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          content,
          style: BodyTypography.large.copyWith(
            color: UmiSeaColors.gray900,
          ),
        )
      ],
    ),
  );
}
