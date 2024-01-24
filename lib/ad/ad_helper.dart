import 'package:flutter/foundation.dart';
import 'package:umi_sea/env/env.dart';

class AdHelper {
  static String get iosInterstitialAdUnitId => kReleaseMode
      ? Env.iosReleaseAdMobInterstitialAdUnitId
      : Env.iosDebugAdMobInterstitialAdUnitId;

  static String get androidInterstitialAdUnitId => kReleaseMode
      ? Env.androidReleaseAdMobInterstitialAdUnitId
      : Env.androidDebugAdMobInterstitialAdUnitId;
}
