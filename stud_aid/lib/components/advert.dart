import 'package:flutter/material.dart';
import 'package:stud_aid/advertDetails.dart';
import 'package:stud_aid/profile_page.dart';

class Advert extends StatefulWidget {
  const Advert({super.key});

  @override
  State<Advert> createState() => _AdvertState();
}

class _AdvertState extends State<Advert> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(32, 50, 57, 0.1),
      ),
      height: 220,
      width: 330,
      padding: const EdgeInsets.all(10),
      child: Row(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 110,
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: Image.asset(
                'images/blueFullBetter.png',
                fit: BoxFit.scaleDown,
              ),
            ),
            Container(
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()),
                    );
                  },
                  child: const Text('See profile',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(20, 30, 39, 1.0)))),
            ),
          ],
        ),
        Container(
            width: 170,
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: const Text('Algebra classes',
                      style: TextStyle(
                          fontSize: 23,
                          color: Color.fromRGBO(20, 30, 39, 1.0))),
                ),
                const Text('Price: 15 per hour',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromRGBO(20, 30, 39, 1.0))),
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BookPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        primary: const Color.fromRGBO(20, 30, 39, 1.0),
                        minimumSize: Size(90, 40)),
                    child: const Text(
                      'Book',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            )),
      ]),
    );
  }
}
