import 'package:flutter/material.dart';
import 'package:stud_aid/components/advert.dart';
import 'package:stud_aid/components/bottom_bar.dart';
import 'package:stud_aid/components/chat_head.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

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
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              margin: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: Color.fromRGBO(32, 50, 57, 0.4)))),
              child: const Text(
                'Chats',
                style: TextStyle(
                    fontSize: 25, color: Color.fromRGBO(20, 30, 39, 1.0)),
                textAlign: TextAlign.center,
              ),
            ),
            const ChatHead(),
            const ChatHead(),
          ]),
        ),
        bottomNavigationBar: const BottomBar());
  }
}
