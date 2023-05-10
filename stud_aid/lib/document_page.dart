import 'package:flutter/material.dart';
import 'package:stud_aid/components/advert.dart';
import 'package:stud_aid/components/bottom_bar.dart';

class DocumentPage extends StatelessWidget {
  const DocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(20, 30, 39, 1.0),
          leading: Image.asset(
            'images/whiteHalfBetter.png',
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
              margin: const EdgeInsets.only(top: 30),
              child: const Text(
                'Theory of relativity',
                style: TextStyle(
                    fontSize: 25, color: Color.fromRGBO(20, 30, 39, 1.0)),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              child: const Text('Description',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(32, 50, 57, 0.4))),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30),
              child: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(32, 50, 57, 0.4))),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: Color.fromRGBO(32, 50, 57, 0.4)))),
              child: const Text('By: John Doe',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(32, 50, 57, 0.4))),
            ),
            Container(
              width: 100,
              height: 50,
              margin: const EdgeInsets.only(top: 50.0, right: 100, left: 100),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: const Color.fromRGBO(20, 30, 39, 1.0),
                    minimumSize: Size(50, 40)),
                child: const Text(
                  'Download',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            )
          ]),
        ),
        bottomNavigationBar: const BottomBar());
  }
}
