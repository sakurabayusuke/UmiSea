import 'dart:convert';

import 'package:umi_sea/env/env.dart';
import 'package:http/http.dart' as http;
import 'package:umi_sea/map/coral2/geo_root.dart';

class CoralRepository {
  static final _repository = CoralRepository._internal();
  factory CoralRepository() => _repository;
  CoralRepository._internal();

  final Uri _uri = Uri.parse(Env.coralURL);
  final String _apiKey = Env.coralApiKey;
  late GeoRoot? _cache;
  late String? _jsonCache;

  Future<GeoRoot?> getCoral() async {
    if (_cache != null) {
      return _cache!;
    }
    var res = await http.get(_uri, headers: {"x-api-key": _apiKey});

    if (res.statusCode != 200) {
      return null;
    }

    final Map<String, dynamic> coralsJson = jsonDecode(res.body);
    final corals = GeoRoot.fromJson(coralsJson);
    _cache = corals;
    return corals;
  }

  Future<String?> getCoralGeoJson() async {
    if (_jsonCache != null) {
      return _jsonCache!;
    }
    var res = await http.get(_uri, headers: {"x-api-key": _apiKey});

    if (res.statusCode != 200) {
      return null;
    }

    _jsonCache = res.body;
    return res.body;
  }
}
