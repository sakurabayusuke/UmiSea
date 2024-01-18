import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:umi_sea/Component/icon/icon_size.dart';
import 'package:umi_sea/Component/typography/body_typography.dart';
import 'package:umi_sea/Component/typography/header_typography.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';
import 'package:umi_sea/Component/buttons/icon_button.dart'
    as umi_sea_component;
import 'package:umi_sea/Component/icon/icon.dart' as umi_sea_icon;

class LicenseScreen extends StatelessWidget {
  const LicenseScreen({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

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
        title: Text(title),
        titleTextStyle: HeaderTypography.middle
            .copyWith(color: UmiSeaColors.gray900)
            .copyWith(fontFamily: GoogleFonts.istokWeb().fontFamily),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Text(
            content,
            style: BodyTypography.middle
                .copyWith(fontFamily: GoogleFonts.istokWeb().fontFamily),
          ),
        ),
      ),
    );
  }
}
