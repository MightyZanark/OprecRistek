import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'profile_page.dart';
import 'anime_detail_page.dart';

class AnimeList extends StatefulWidget {
  const AnimeList({super.key});

  @override
  State<AnimeList> createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {
  final controller = ScrollController();

  List animes = [];
  int limit = 10;
  int offset = 0;
  bool hasNext = true;
  bool isLoading = false;

  Future fetchAnime() async {
    if (isLoading) return;
    isLoading = true;

    const String mainUrl = "https://api.myanimelist.net/v2";
    const Map<String, String> header = {
      'X-MAL-CLIENT-ID': '340c3fd030ff79072f6ca6eaba022f32'
    };

    final url = Uri.parse(
        "$mainUrl/anime/ranking?offset=$offset&ranking_type=airing&limit=$limit");

    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final Map newDatas = json.decode(response.body);
      final List newAnimes = newDatas['data'];

      setState(() {
        offset += limit;
        isLoading = false;

        if (newDatas['paging']?['next'] == null) {
          hasNext = false;
        }

        animes.addAll(newAnimes);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAnime();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetchAnime();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Anime List",
            style: TextStyle(fontSize: 24),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: PopupMenuButton(
                  itemBuilder: (context) {
                    return const [
                      PopupMenuItem(value: "profile", child: Text("Profile"))
                    ];
                  },
                  child: const Icon(
                    Icons.menu,
                    weight: 20,
                    size: 30,
                  ),
                  onSelected: (value) {
                    switch (value) {
                      case "profile":
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ProfilePage()));
                        break;

                      default:
                        break;
                    }
                  },
                ))
          ],
        ),
        body: ListView.separated(
          controller: controller,
          itemCount: animes.length + 1,
          itemBuilder: (context, index) {
            if (index < animes.length) {
              Map anime = animes[index]['node'];
              final animePic = anime['main_picture']['medium'];
              final animeName = anime['title'];
              final animeId = anime['id'];

              return ListTile(
                // contentPadding: EdgeInsets.all(70),
                title: Column(
                  children: [
                    const SizedBox(height: 10),
                    Image.network(animePic),
                    const SizedBox(height: 10)
                  ],
                ),
                subtitle: Text(
                  animeName,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        AnimeDetail(animeName: animeName, animeId: animeId))),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Center(
                    child: hasNext
                        ? const CircularProgressIndicator()
                        : const Text("No more data")),
              );
            }
          },
          separatorBuilder: (context, index) => Divider(
            thickness: 5,
            color: Colors.grey[500],
          ),
        ));
  }
}
