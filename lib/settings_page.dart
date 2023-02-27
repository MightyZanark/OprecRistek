import 'package:flutter/material.dart';

import 'main1.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Container(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Text(
                "Choose your theme:",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: ElevatedButton(
                  onPressed: () =>
                      MyApp.of(context).changeTheme(ThemeMode.light),
                  child: const Text("Light"),
                ),
              ),
              ElevatedButton(
                onPressed: () => MyApp.of(context).changeTheme(ThemeMode.dark),
                child: const Text("Dark"),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
