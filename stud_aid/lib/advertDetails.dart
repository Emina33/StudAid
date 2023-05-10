import 'package:flutter/material.dart';
import 'package:stud_aid/components/bottom_bar.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

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
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              'Algebra classes',
              style: TextStyle(
                  fontSize: 25, color: Color.fromRGBO(20, 30, 39, 1.0)),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 500,
            height: 500,
            margin: const EdgeInsets.only(top: 20),
            color: const Color.fromRGBO(32, 50, 57, 0.1),
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: const Text(
                  'Select the time:',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromRGBO(20, 30, 39, 1.0)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: const Text(
                  '9:00',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(20, 30, 39, 1.0)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: const Text(
                  '11:00',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(20, 30, 39, 1.0)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: const Text(
                  '12:00',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(20, 30, 39, 1.0)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: const Text(
                  '16:00',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(20, 30, 39, 1.0)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 80),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BookPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: const Color.fromRGBO(20, 30, 39, 1.0),
                      minimumSize: Size(170, 45)),
                  child: const Text(
                    'Ask for confirmation',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
            ]),
          )
        ]),
        bottomNavigationBar: const BottomBar());
  }
}
