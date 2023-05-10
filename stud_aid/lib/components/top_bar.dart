import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(20, 30, 39, 1.0),
      leading: Image.asset(
        'images/whiteHalfBetter.png',
      ),
      actions: [
        TextButton(
            onPressed: () {},
            child: const Text('Log in',
                style: TextStyle(
                    fontSize: 18, color: Color.fromRGBO(238, 237, 222, 1.0)))),
        TextButton(
            onPressed: () {},
            child: const Text('Sign up',
                style: TextStyle(
                    fontSize: 18, color: Color.fromRGBO(238, 237, 222, 1.0))))
      ],
    );
  }
}
