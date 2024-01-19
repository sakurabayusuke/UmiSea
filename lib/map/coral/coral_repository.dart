import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:umi_sea/env/env.dart';
import 'package:http/http.dart' as http;
import 'package:umi_sea/infrastructure/exception/network_exception.dart';
import 'package:umi_sea/infrastructure/exception/server_error_exception.dart';
import 'package:umi_sea/infrastructure/logger/logger_state_enum.dart';
import 'package:umi_sea/main.dart';

class CoralRepository {
  CoralRepository()
      : this.forTesting(
          http: http.Client(),
          connectivity: Connectivity(),
        );
  CoralRepository.forTesting(
      {required http.Client http, required Connectivity connectivity})
      : _http = http,
        _connectivity = connectivity;

  final http.Client _http;
  final Connectivity _connectivity;

  final Uri _uri = Uri.parse(Env.coralURL);
  final String _apiKey = Env.coralApiKey;
  Map<String, dynamic>? _jsonCache;

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
