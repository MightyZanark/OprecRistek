import 'package:flutter/material.dart';
import 'api_fetch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // primarySwatch: Colors.blue,
          ),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: const MyHomePage(title: 'Anime List'),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: PopupMenuButton(
              itemBuilder: (context) {
                return const [
                  PopupMenuItem(value: 0, child: Text("Profile")),
                  PopupMenuItem(value: 1, child: Text("Settings"))
                ];
              },
              onSelected: (value) {
                print(value);
              },
              child: const Icon(
                Icons.menu,
                weight: 20,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // const Text('Choose your theme:'),
            // ElevatedButton(
            //   onPressed: () => MyApp.of(context).changeTheme(ThemeMode.light),
            //   child: const Text('Light'),
            // ),
            // ElevatedButton(
            //   onPressed: () => MyApp.of(context).changeTheme(ThemeMode.dark),
            //   child: const Text('Dark'),
            // ),
            ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [AnimeListUI()],
            ),
            // const AnimeListUI(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
