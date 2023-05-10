import 'package:flutter/material.dart';
import 'package:stud_aid/chat.dart';

class ChatHead extends StatefulWidget {
  const ChatHead({super.key});

  @override
  State<ChatHead> createState() => _ChatHeadState();
}

class _ChatHeadState extends State<ChatHead> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromRGBO(32, 50, 57, 0.4)))),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              child: Image.asset('images/blueFullBetter.png'),
            ),
            Container(
                margin: const EdgeInsets.only(left: 15),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatPage()),
                      );
                    },
                    child: const Text(
                      'John Doe',
                      style: TextStyle(
                          fontSize: 20, color: Color.fromRGBO(20, 30, 39, 1.0)),
                    )))
          ],
        ));
  }
}
