import 'dart:async';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:umi_sea/ad/ad_helper.dart';
import 'package:umi_sea/infrastructure/logger/logger_state_enum.dart';
import 'package:umi_sea/main.dart';

part 'ad_mob.g.dart';

@riverpod
class AdMob extends _$AdMob {
  @override
  void build() {}

  InterstitialAd? _ad;

  Future<bool> load() async {
    late final String adUnitId;
    if (Platform.isAndroid) {
      adUnitId = AdHelper.androidInterstitialAdUnitId;
    } else if (Platform.isIOS) {
      adUnitId = AdHelper.iosInterstitialAdUnitId;
    } else {
      adUnitId = "";
    }
    if (adUnitId.isEmpty) {
      logger.t("${LoggerStateEnum.info}:スマフォ端末以外での操作のため、広告を読み込めませんでした。");
      return false;
    }

    logger.t("${LoggerStateEnum.trace.title}:インタースティシャル広告読み込み開始");
    await InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          logger.t("${LoggerStateEnum.trace.title}:インタースティシャル広告読み込み成功");
          _ad = ad;
        },
        onAdFailedToLoad: (error) {
          logger.t("${LoggerStateEnum.trace.title}:インタースティシャル広告読み込み失敗");
          _ad = null;
        },
      ),
    );
    return _ad != null;
  }

  Future<void> show() async {
    if (_ad == null) {
      logger.w("${LoggerStateEnum.warning.title}:広告がないのに広告を表示しようとしています。");
      return;
    }
    _ad!.fullScreenContentCallback = FullScreenContentCallback(
      onAdFailedToShowFullScreenContent: (ad, error) {
        logger.w("${LoggerStateEnum.warning.title}:何かかが原因で広告が表示できませんでした");
      },
    );
    try {
      logger.w("${LoggerStateEnum.trace.title}:広告表示開始");
      await _ad!.show();
      logger.w("${LoggerStateEnum.trace.title}:広告表示終了");
    } finally {
      _ad!.dispose();
      _ad = null;
    }
  }
}
