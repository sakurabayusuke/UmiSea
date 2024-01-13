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
}
