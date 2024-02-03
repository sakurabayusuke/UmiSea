import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:umi_sea/env/env.dart';
import 'package:http/http.dart' as http;
import 'package:umi_sea/infrastructure/exception/network_exception.dart';
import 'package:umi_sea/infrastructure/exception/server_error_exception.dart';
import 'package:umi_sea/infrastructure/logger/logger_state_enum.dart';
import 'package:umi_sea/main.dart';

part 'coral_repository.g.dart';

@Riverpod(keepAlive: true)
class CoralRepository extends _$CoralRepository {
  @override
  void build() => {
        _http = http.Client(),
        _connectivity = Connectivity(),
      };

  late final http.Client _http;
  late final Connectivity _connectivity;

  static final Uri _uri = Uri.parse(Env.coralURL);
  static final String _apiKey = Env.coralApiKey;
  static Map<String, dynamic>? _jsonCache;

  Future<Map<String, dynamic>?> getCoralGeoJson() async {
    if (_jsonCache != null) {
      return _jsonCache!;
    }
    final networkResult = await _connectivity.checkConnectivity();
    if (networkResult == ConnectivityResult.none) {
      logger.e("${LoggerStateEnum.exception}:ネットワークに接続されていません。");
      throw NetworkException();
    }

    var res = await _http.get(_uri, headers: {"x-api-key": _apiKey});

    if (res.statusCode == 500) {
      logger.e("${LoggerStateEnum.exception}:coral-lambda からの応答がありません。");
      throw TimeoutException("サーバーから応答がありません。");
    }
    if (res.statusCode != 200) {
      logger.e(
          "${LoggerStateEnum.exception}:coral-lambda になんらかの異常がありデータが取得できません。");
      throw ServerErrorException();
    }

    final Map<String, dynamic> geoJson = jsonDecode(res.body);
    _jsonCache = geoJson;
    return geoJson;
  }
}
