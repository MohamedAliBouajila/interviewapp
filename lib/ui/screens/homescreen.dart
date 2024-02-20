import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../widgets/card.dart';
import '../widgets/customnavbar.dart';
import '../widgets/person_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 19),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _welcomeBar(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)..pushNamed("/persons");
                  },
                  child: CardWidget("Persons", "assets/images/user.png"),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)..pushNamed("/projects");
                  },
                  child: CardWidget("Projects", "assets/images/project.png"),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)..pushNamed("/linkedprojects");
                  },
                  child:
                      CardWidget("Linked Projects", "assets/images/link.png"),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  _welcomeBar() => Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const Text(
            "Welcome back, Mohamed Ali",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: Image.network(
"https://media.licdn.com/dms/image/D4D03AQG-pAASrDJQJg/profile-displayphoto-shrink_800_800/0/1668127694481?e=1714003200&v=beta&t=QlQDZwiOPogh40HTAW7DltZkEPWEFAwDadwhHdeFAs8",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          )
        ]),
      );
}
