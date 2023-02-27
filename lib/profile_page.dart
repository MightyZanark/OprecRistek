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
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
            ),
            height: MediaQuery.of(context).size.height * 0.4,
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
                const Text("Juan Maxwell Tanaya")
              ],
            ),
          )
        ],
      ),
    );
  }
}
