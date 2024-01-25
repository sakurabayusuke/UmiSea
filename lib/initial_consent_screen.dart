import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umi_sea/Component/typography/body_typography.dart';
import 'package:umi_sea/Component/typography/header_typography.dart';
import 'package:umi_sea/Component/umi_sea_colors.dart';
import 'package:umi_sea/map/main_map/map_screen.dart';
import 'package:umi_sea/setting/initial_consent_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class InitialConsentScreen extends ConsumerWidget {
  const InitialConsentScreen({super.key});

  final termOfServiceUrl =
      "https://github.com/sakurabayusuke/UmiSea/wiki/Sea-Farlen-%E5%88%A9%E7%94%A8%E8%A6%8F%E7%B4%84";
  final privacyPolicyUrl =
      "https://github.com/sakurabayusuke/UmiSea/wiki/Sea-Farlen-%E3%83%97%E3%83%A9%E3%82%A4%E3%83%90%E3%82%B7%E3%83%BC%E3%83%9D%E3%83%AA%E3%82%B7%E3%83%BC";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consentProvider =
        ref.watch(initialConsentRepositoryProvider.notifier);

    final bodyTypo = BodyTypography.large.copyWith(color: UmiSeaColors.gray800);
    final linkTypo = BodyTypography.large.copyWith(color: UmiSeaColors.blue800);
    final headTypo =
        HeaderTypography.middle.copyWith(color: UmiSeaColors.gray800);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 124,
          bottom: 72,
          right: 48,
          left: 48,
        ),
        color: UmiSeaColors.gray000,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sea Farlen の利用規約とプライバシーポリシーへの同意のお願い",
              style: headTypo,
            ),
            const SizedBox(height: 48),
            Text(
                "本アプリを使うには利用規約とプライバシーポリシーへの同意が必要です。下記の Web サイトからご覧いただけますので、内容を理解した上で同意をお願いします。",
                style: bodyTypo),
            const SizedBox(height: 24),
            GestureDetector(
              child: Text("Sea Farlen 利用規約", style: linkTypo),
              onTap: () => launchUrl(
                Uri.parse(termOfServiceUrl),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              child: Text(
                "Sea Farlen プライバシーポリシー",
                style: linkTypo,
              ),
              onTap: () => launchUrl(
                Uri.parse(privacyPolicyUrl),
              ),
            ),
            Expanded(child: Container()),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: UmiSeaColors.blue200,
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                consentProvider.setInitialConsent(true);
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        MapScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                    transitionDuration: const Duration(
                      microseconds: 2500,
                    ),
                  ),
                );
              },
              child: Center(
                child: Text("同意する", style: bodyTypo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
