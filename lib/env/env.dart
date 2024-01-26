import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'MAPBOX_PUBLIC_ACCESS_TOKEN', obfuscate: true)
  static String mapboxPublicAccessToken = _Env.mapboxPublicAccessToken;

  @EnviedField(varName: 'CORAL_URL', obfuscate: true)
  static String coralURL = _Env.coralURL;

  @EnviedField(varName: 'CORAL_API_KEY', obfuscate: true)
  static String coralApiKey = _Env.coralApiKey;

  @EnviedField(
      varName: 'ANDROID_DEBUG_AD_MOB_INTERSTITIAL_AD_UNIT_ID', obfuscate: true)
  static String androidDebugAdMobInterstitialAdUnitId =
      _Env.androidDebugAdMobInterstitialAdUnitId;

  @EnviedField(
      varName: 'IOS_DEBUG_AD_MOB_INTERSTITIAL_AD_UNIT_ID', obfuscate: true)
  static String iosDebugAdMobInterstitialAdUnitId =
      _Env.iosDebugAdMobInterstitialAdUnitId;

  @EnviedField(
      varName: 'ANDROID_RELEASE_AD_MOB_INTERSTITIAL_AD_UNIT_ID',
      obfuscate: true)
  static String androidReleaseAdMobInterstitialAdUnitId =
      _Env.androidReleaseAdMobInterstitialAdUnitId;

  @EnviedField(
      varName: 'IOS_RELEASE_AD_MOB_INTERSTITIAL_AD_UNIT_ID', obfuscate: true)
  static String iosReleaseAdMobInterstitialAdUnitId =
      _Env.iosReleaseAdMobInterstitialAdUnitId;
}
