import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final String profilePicUrl =
      "https://scele.cs.ui.ac.id/pluginfile.php/153176/user/icon/lambda/f1?rev=12222133";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey[700],
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
            ),
            height: MediaQuery.of(context).size.height * 0.33,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // const Text("Profile",
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //         fontSize: 30,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.black)),
                // const SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  child: ClipOval(child: Image.network(profilePicUrl)),
                ),
                const SizedBox(height: 20),
                const Text("Juan Maxwell Tanaya"),
                const SizedBox(height: 5),
                const Text("Maxwell",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                const Text("Ilmu Komputer - Apollo (2022)")
              ],
            ),
          ),
          const Flexible(
            child: Padding(
              padding:
                  EdgeInsets.only(top: 10, bottom: 20, left: 15, right: 15),
              child: Text(
                "Hobi:\nBelajar hal-hal baru, datamine game yang lagi dimainin",
                style: TextStyle(fontSize: 15),
                textScaleFactor: 1,
              ),
            ),
          ),
          const Flexible(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20, left: 15),
              child: Text(
                "Social Media:\n"
                "IG: zanarkalt\n"
                "LinkedIn: Juan Maxwell Tanaya\n"
                "Line: juantanaya\n"
                "Discord: Zanark#0138\n"
                "GitHub: MightyZanark",
                style: TextStyle(fontSize: 15),
                textScaleFactor: 1,
              ),
            ),
          ),
          const Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Description:\n"
                "Perkenalkan saya Juan Maxwell Tanaya biasa dipanggil Maxwell. "
                "Saya orangnya terkadang rajin terkadang males juga, tapi kalo "
                "ada tugas selalu diusahain kelar secepatnya biar gak buru-buru "
                "kerjain sebelum deadline. Sayangnya, saya ngerjain tugas ini "
                "hanya beberapa hari sebelum deadline, terkait banyaknya tugas "
                "akademis lain yang menumpuk :(.",
                style: TextStyle(fontSize: 15),
                textScaleFactor: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
