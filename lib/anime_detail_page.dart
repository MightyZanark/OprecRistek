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
  bool isLoading = false;

  Future fetchDetail() async {
    if (isLoading) return;
    isLoading = true;

    const String mainUrl = 'https://api.myanimelist.net/v2';
    const Map<String, String> header = {
      'X-MAL-CLIENT-ID': '340c3fd030ff79072f6ca6eaba022f32'
    };

    final url =
        Uri.parse("$mainUrl/anime/${widget.animeId}?fields=title,main_picture,"
            "alternative_titles,start_date,synopsis,mean,rank,"
            "genres,related_anime,studios");

    final response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        details.addAll(json.decode(response.body));
        altTitles.addAll(details['alternative_titles']);
        mainPic = details['main_picture']['medium'];
        synopsis = details['synopsis'];
        startDate = details['start_date'];
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
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          mainPic,
                          // height: 300,
                          // width: 220,
                          scale: 1.5,
                        ),
                      ),
                      Flexible(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      widget.animeName,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      "Alternative Names:\n\t"
                                      "${altTitles['en']}\n\t"
                                      "${altTitles['ja']}",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ])),
                      ),
                      // Flexible(
                      //   child: Padding(
                      //       padding: EdgeInsets.symmetric(vertical: 10),
                      //       child: Text(
                      //           "Alternative Names:\n  ${details['alternative_titles']['en']}\n  ${details['alternative_titles']['jp']}")),
                      // ),
                    ],
                  )
                ],
              ));
  }
}
