import 'package:flutter/material.dart';
import 'package:stud_aid/components/advert.dart';
import 'package:stud_aid/components/bottom_bar.dart';
import 'package:stud_aid/components/chat_head.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(20, 30, 39, 1.0),
          leading: Container(
            height: 150,
            width: 200,
            margin: EdgeInsets.only(left: 20),
            child: Image.asset(
              'images/whiteHalfBetter.png',
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {},
                child: const Text('Log in',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(238, 237, 222, 1.0)))),
            TextButton(
                onPressed: () {},
                child: const Text('Sign up',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(238, 237, 222, 1.0))))
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(right: 30, left: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              margin: const EdgeInsets.all(30),
              child: const Text(
                'John Doe',
                style: TextStyle(
                    fontSize: 25, color: Color.fromRGBO(20, 30, 39, 1.0)),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 300,
                  padding: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(32, 50, 57, 0.1),
                  ),
                  child: const Text(
                    'Hello, do you teach geometry?',
                    style: TextStyle(
                        fontSize: 20, color: Color.fromRGBO(32, 50, 57, 1.0)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 300,
                  padding: const EdgeInsets.only(top: 8),
                  margin: EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(32, 50, 57, 0.1),
                  ),
                  child: const Text(
                    'Hey, yes, you can book a session',
                    style: TextStyle(
                        fontSize: 20, color: Color.fromRGBO(32, 50, 57, 1.0)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          ]),
        ),
        bottomNavigationBar: const BottomBar());
  }
}
