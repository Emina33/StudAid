import 'package:flutter/material.dart';
import 'package:stud_aid/components/advert.dart';
import 'package:stud_aid/components/bottom_bar.dart';
import 'package:stud_aid/main.dart';
import 'package:stud_aid/offer_class.dart';
import 'package:stud_aid/upload_file.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

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
              margin: const EdgeInsets.only(top: 15),
              child: TextButton(
                  onPressed: () {},
                  child: const Text('Edit profile',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(32, 50, 57, 0.4)))),
            ),
            Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.only(top: 10),
              child: Image.asset('images/blueFullBetter.png'),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                'John Doe',
                style: TextStyle(
                    fontSize: 25, color: Color.fromRGBO(20, 30, 39, 1.0)),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              child: const Text('About',
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
              child: const Text('Offered classes',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(32, 50, 57, 0.4))),
            ),
            Container(
              margin: const EdgeInsets.only(right: 30, left: 30, bottom: 20),
              child: const Advert(),
            ),
            Container(
              margin: const EdgeInsets.only(right: 30, left: 30, bottom: 10),
              child: const Advert(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30, bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OfferClassPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        primary: const Color.fromRGBO(20, 30, 39, 1.0),
                        minimumSize: Size(130, 40)),
                    child: const Text(
                      'Offer class',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 30, bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UploadFilePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        primary: const Color.fromRGBO(20, 30, 39, 1.0),
                        minimumSize: Size(130, 40)),
                    child: const Text(
                      'Upload file',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
        bottomNavigationBar: const BottomBar());
  }
}
