import 'package:flutter/material.dart';

import '../main.dart';

class TopBar extends StatefulWidget {
  TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 15, left: 15),
      color: const Color.fromRGBO(20, 30, 39, 1.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Image.asset(
          'images/whiteHalfBetter.png',
        ),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RootPage()),
              );
            },
            child: Text('Log out',
                style: TextStyle(
                    fontSize: 18, color: Color.fromRGBO(238, 237, 222, 1.0)))),
      ]),
    );
  }
}
