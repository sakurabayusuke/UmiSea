import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'MAPBOX_PUBLIC_ACCESS_TOKEN', obfuscate: true)
  static String key = _Env.key;
}
