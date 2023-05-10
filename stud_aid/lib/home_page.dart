import 'package:flutter/material.dart';
import 'package:stud_aid/advertDetails.dart';
import 'package:stud_aid/components/advert.dart';
import 'package:stud_aid/components/bottom_bar.dart';
import 'package:stud_aid/components/document.dart';
import 'package:stud_aid/main.dart';
import 'package:stud_aid/profile_page.dart';
import 'package:stud_aid/register.dart';
import 'package:stud_aid/search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RootPage()),
                  );
                },
                child: const Text('Log in',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(238, 237, 222, 1.0)))),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                  );
                },
                child: const Text('Sign up',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(238, 237, 222, 1.0))))
          ],
        ),
        body: Column(children: [
          Container(
            height: 40,
            width: 420,
            margin: const EdgeInsets.only(right: 30.0, left: 30.0, top: 30),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: Color.fromRGBO(32, 50, 57, 0.4)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchPage()),
                      );
                    },
                    child: const Text('Search',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(32, 50, 57, 0.4)))),
                TextButton(
                    onPressed: () {},
                    child: const Text('Filter',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(32, 50, 57, 0.4))))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: const Advert(),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: const Document(),
          ),
        ]),
        bottomNavigationBar: const BottomBar());
  }
}
