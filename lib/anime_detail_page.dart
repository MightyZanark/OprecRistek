import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnimeDetail extends StatefulWidget {
  const AnimeDetail(
      {super.key, required this.animeName, required this.animeId});

  final String animeName;
  final int animeId;

  @override
  State<AnimeDetail> createState() => _AnimeDetailState();
}

class _AnimeDetailState extends State<AnimeDetail> {
  Map details = {};
  Map altTitles = {};
  late String mainPic;
  late String synopsis;
  late String startDate;
  late String endDate;
  late double mean;
  late int rank;
  late List genres;
  late List studios;
  bool isLoading = false;
  String genreString = "Genres: ";
  String studioString = "Studios: ";

  Future fetchDetail() async {
    if (isLoading) return;
    isLoading = true;

    const String mainUrl = 'https://api.myanimelist.net/v2';
    const Map<String, String> header = {
      'X-MAL-CLIENT-ID': '340c3fd030ff79072f6ca6eaba022f32'
    };

    final url =
        Uri.parse("$mainUrl/anime/${widget.animeId}?fields=title,main_picture,"
            "alternative_titles,start_date,end_date,synopsis,mean,rank,"
            "genres,related_anime,studios");

    final response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        details.addAll(json.decode(response.body));
        altTitles.addAll(details['alternative_titles']);
        mainPic = details['main_picture']['medium'];
        synopsis = details['synopsis'].trim();
        startDate = details['start_date'];
        endDate = details['end_date'] ?? "-";
        mean = details['mean'];
        rank = details['rank'];
        genres = details['genres'];
        studios = details['studios'];

        for (int i = 0; i < genres.length; i++) {
          genreString += genres[i]['name'];
          if (i != genres.length - 1) genreString += ", ";
        }

        for (int i = 0; i < studios.length; i++) {
          studioString += studios[i]['name'];
          if (i != studios.length - 1) studioString += ", ";
        }
      });
      // print(details['main_picture']['medium']);
    } else {
      return const Text(
        "Unable to load data",
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.animeName),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          mainPic,
                          scale: 1.5,
                        ),
                      ),
                      Flexible(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Text(
                                      widget.animeName,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      textScaleFactor: 0.75,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      "Alternative Names:\n"
                                      "[EN] ${altTitles['en']}\n"
                                      "[JP] ${altTitles['ja']}",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          // fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      textScaleFactor: 0.75,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      "Score: ${details['mean']}",
                                      textScaleFactor: 0.9,
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        "Overall Rank: ${details['rank']}",
                                        textScaleFactor: 0.9,
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        "Start date: $startDate",
                                        textScaleFactor: 0.9,
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        "End date: $endDate",
                                        textScaleFactor: 0.9,
                                      )),
                                ])),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Synopsis",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Flexible(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                synopsis,
                                textScaleFactor: 0.9,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                genreString,
                                textScaleFactor: 1,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                studioString,
                                textScaleFactor: 1,
                              ),
                            ],
                          ))),
                  // Flexible(
                  //     child: Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8),
                  //   child: Text(genreString),
                  // ))
                ],
              ));
  }
}
