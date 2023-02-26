import 'package:flutter/material.dart';
import 'dart:async';

import 'api_fetch.dart';

class AnimeListView extends StatefulWidget {
  const AnimeListView({super.key, required this.type});
  final String type;

  @override
  State<AnimeListView> createState() => _AnimeListViewState();
}

class _AnimeListViewState extends State<AnimeListView> {
  bool _isFirstRun = true;

  void _firstLoad() async {}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
