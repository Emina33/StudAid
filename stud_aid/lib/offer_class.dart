import 'package:flutter/material.dart';
import 'package:stud_aid/components/advert.dart';
import 'package:stud_aid/components/bottom_bar.dart';
import 'package:stud_aid/components/chat_head.dart';

class OfferClassPage extends StatelessWidget {
  const OfferClassPage({super.key});

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
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: Color.fromRGBO(32, 50, 57, 0.4)))),
              child: const Text(
                'Offer class',
                style: TextStyle(
                    fontSize: 25, color: Color.fromRGBO(20, 30, 39, 1.0)),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              width: 300.0,
              height: 60.0,
              child: TextField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Subject',
                    isDense: true,
                    contentPadding: EdgeInsets.all(8)),
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              width: 300.0,
              height: 60.0,
              child: TextField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'City',
                    isDense: true,
                    contentPadding: EdgeInsets.all(8)),
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              width: 300.0,
              height: 60.0,
              child: TextField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Category',
                    isDense: true,
                    contentPadding: EdgeInsets.all(8)),
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              width: 300.0,
              height: 60.0,
              child: TextField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Set price',
                    isDense: true,
                    contentPadding: EdgeInsets.all(8)),
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 30),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: Color.fromRGBO(32, 50, 57, 0.4)))),
              child: const Text(
                'Additional information',
                style: TextStyle(
                    fontSize: 20, color: Color.fromRGBO(32, 50, 57, 0.4)),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(32, 50, 57, 0.1),
                ),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                )),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Done',
                    style: TextStyle(
                        fontSize: 20, color: Color.fromRGBO(20, 30, 39, 1.0)),
                  )),
            ),
          ]),
        ),
        bottomNavigationBar: const BottomBar());
  }
}
