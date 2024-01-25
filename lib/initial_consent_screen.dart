import 'package:flutter/material.dart';
import 'package:umi_sea/Component/typography/body_typography.dart';
import 'package:umi_sea/Component/typography/header_typography.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class InitialConsentScreen extends StatelessWidget {
  const InitialConsentScreen({super.key});

  final termOfServiceUrl =
      "https://github.com/sakurabayusuke/UmiSea/wiki/Sea-Farlen-%E5%88%A9%E7%94%A8%E8%A6%8F%E7%B4%84";
  final privacyPolicyUrl =
      "https://github.com/sakurabayusuke/UmiSea/wiki/Sea-Farlen-%E3%83%97%E3%83%A9%E3%82%A4%E3%83%90%E3%82%B7%E3%83%BC%E3%83%9D%E3%83%AA%E3%82%B7%E3%83%BC";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 124,
          bottom: 48,
          right: 24,
          left: 24,
        ),
        color: UmiSeaColors.gray000,
        child: Center(
          child: Column(
            children: [
              Text(
                "Sea Farlen の利用規約とプライバシーポリシーへの同意のお願い",
                style: HeaderTypography.middle.copyWith(
                  color: UmiSeaColors.gray800,
                ),
              ),
              const SizedBox(height: 72),
              Text(
                "本アプリを使うには利用規約とプライバシーポリシーへの同意が必要です。下記の Web サイトからご覧いただけますので、内容を理解した上で同意をお願いします。",
                style: BodyTypography.large.copyWith(
                  color: UmiSeaColors.gray800,
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                child: Text(
                  "Sea Farlen 利用規約",
                  style: BodyTypography.large.copyWith(
                    color: UmiSeaColors.blue800,
                  ),
                ),
                onTap: () => launchUrl(
                  Uri.parse(termOfServiceUrl),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                child: Text(
                  "Sea Farlen プライバシーポリシー",
                  style: BodyTypography.large.copyWith(
                    color: UmiSeaColors.blue800,
                  ),
                ),
                onTap: () => launchUrl(
                  Uri.parse(privacyPolicyUrl),
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(
                    side: BorderSide(color: Colors.transparent),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "同意する",
                  style: BodyTypography.large.copyWith(
                    color: UmiSeaColors.gray800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
