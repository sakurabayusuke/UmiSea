import 'dart:convert';

import 'package:umi_sea/env/env.dart';
import 'package:umi_sea/map/coral/coral.dart';
import 'package:http/http.dart' as http;

class CoralRepository {
  static final _repository = CoralRepository._internal();
  factory CoralRepository() => _repository;
  CoralRepository._internal();

  final Uri _uri = Uri.parse(Env.coralURL);
  final String _apiKey = Env.coralApiKey;

  Future<List<Coral>> getAllCoral() async {
    var res = await http.get(_uri, headers: {"x-api-key": _apiKey});

    if (res.statusCode != 200) {
      return <Coral>[];
    }

    List coralsMap = jsonDecode(res.body);
    List<Coral> corals = [];
    for (var coral in coralsMap) {
      corals.add(Coral.fromJson(coral));
    }

    return corals;
  }
}
