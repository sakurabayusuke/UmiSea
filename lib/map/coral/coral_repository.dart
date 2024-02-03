import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:umi_sea/env/env.dart';
import 'package:umi_sea/infrastructure/exception/network_exception.dart';
import 'package:umi_sea/infrastructure/exception/server_error_exception.dart';
import 'package:umi_sea/infrastructure/logger/logger.dart';
import 'package:umi_sea/infrastructure/logger/logger_state_enum.dart';
import 'package:umi_sea/infrastructure/repository/connectivity.dart';
import 'package:umi_sea/infrastructure/repository/http_client.dart';

part 'coral_repository.g.dart';

@Riverpod(keepAlive: true)
class CoralRepository extends _$CoralRepository {
  @override
  void build() => {};

  static final Uri _uri = Uri.parse(Env.coralURL);
  static final String _apiKey = Env.coralApiKey;
  static Map<String, dynamic>? _jsonCache;

  Future<Map<String, dynamic>?> getCoralGeoJson() async {
    if (_jsonCache != null) {
      return _jsonCache!;
    }
    final networkResult =
        await ref.read(connectivityProvider).checkConnectivity();
    if (networkResult == ConnectivityResult.none) {
      logger.e("${LoggerStateEnum.exception}:ネットワークに接続されていません。");
      throw NetworkException();
    }

    try {
      var res = await ref
          .read(httpClientProvider)
          .get(_uri, headers: {"x-api-key": _apiKey});

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
    } finally {
      ref.read(httpClientProvider).close();
    }
  }
}
