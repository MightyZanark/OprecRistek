import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String mainUrl = 'https://api.myanimelist.net/v2';
const Map<String, String> header = {
  'X-MAL-CLIENT-ID': '340c3fd030ff79072f6ca6eaba022f32'
};

Future<AnimeList> fetchAnimeList(String type, int limit, int offset) async {
  final response = await http.get(
      Uri.parse(
          '$mainUrl/anime/ranking?offset=$offset&ranking_type=$type&limit=$limit'),
      headers: header);

  if (response.statusCode == 200) {
    return AnimeList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to fetch $type anime list");
  }
}

Future<AnimeDetail> fetchAnimeDetail(int id) async {
  final response = await http.get(
      Uri.parse(
          '$mainUrl/anime/$id?fields=title,main_picture,alternative_titles,'
          'start_date,end_date,synopsis,mean,rank,genres,related_anime,studios'),
      headers: header);

  if (response.statusCode == 200) {
    return AnimeDetail.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Unable to fetch anime of id $id's detail");
  }
}

class AnimeList {
  final List data;
  final Map paging;

  const AnimeList({
    required this.data,
    required this.paging,
  });

  factory AnimeList.fromJson(Map<String, dynamic> json) {
    return AnimeList(data: json['data'], paging: json['paging']);
  }
}

class AnimeDetail {
  final String title;
  final String picMedium;
  final List<Map> altTitles;
  final String startDate;
  final String endDate;
  final String synopsis;
  final double mean;
  final int rank;
  final List<Map> genres;
  final List<Map> studios;
  final List<Map> relatedAnime;

  const AnimeDetail(
      {required this.title,
      required this.picMedium,
      required this.altTitles,
      required this.startDate,
      required this.endDate,
      required this.synopsis,
      required this.mean,
      required this.rank,
      required this.genres,
      required this.studios,
      required this.relatedAnime});

  factory AnimeDetail.fromJson(Map<String, dynamic> json) {
    return AnimeDetail(
        title: json['title'],
        picMedium: json['main_picture']['medium'],
        altTitles: json['alternative_titles'],
        startDate: json['start_date'],
        endDate: json['end_date'],
        synopsis: json['synopsis'],
        mean: json['mean'],
        rank: json['rank'],
        genres: json['genres'],
        studios: json['studios'],
        relatedAnime: json['related_anime']);
  }
}

class AnimeListUI extends StatefulWidget {
  const AnimeListUI({super.key});

  @override
  State<AnimeListUI> createState() => _AnimeListUIState();
}

class _AnimeListUIState extends State<AnimeListUI> {
  // late Future<AnimeList> futureAnimeList;
  List animes = [];
  int offset = 0;
  int limit = 5;
  bool hasNext = true;

  void _fetchAnime(String type, int limit, int offset) async {
    final response = await http.get(Uri.parse(
        '$mainUrl/anime/ranking?offset=$offset&ranking_type=$type&limit=$limit'));
  }

  void _loadMore() async {
    if (_controller.position.extentAfter < 300) {
      offset++;
      // futureAnimeList = fetchAnimeList("airing", limit, offset);
    }
  }

  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    // futureAnimeList = fetchAnimeList("airing", limit, offset);
    // animes.addAll(futureAnimeList);
    // final value = Future.value(futureAnimeList);
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchAnimeList("airing", limit, offset),
      builder: (context, snapshot) {
        Size mediaSize = MediaQuery.of(context).size;
        // return Text(snapshot.toString());
        if (snapshot.hasData) {
          // print(snapshot.data!.data);
          return ListView.separated(
            itemCount: animes.length,
            itemBuilder: (context, index) {
              return Container(
                  width: mediaSize.width * 0.9,
                  child: ListTile(
                    title:
                        Image.network(animes[index]['main_picture']['medium']),
                    subtitle: Text(animes[index]['name']),
                  ));
            },
            separatorBuilder: (context, index) => const Divider(),
          );
        } else if (snapshot.hasError) {
          return Text('error: ${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
