import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_client.g.dart';

@Riverpod(keepAlive: true)
http.Client httpClient(HttpClientRef ref) => http.Client();
