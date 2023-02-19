import 'package:http/http.dart' as http;

String mainUrl = 'https://api.myanimelist.net/v2';

Future<http.Response> fetchAnimeList() {
  return http.get(Uri.parse(mainUrl),
      headers: {'X-MAL-CLIENT-ID': '340c3fd030ff79072f6ca6eaba022f32'});
}
