import 'package:flutter/material.dart';
import 'package:stud_aid/advertDetails.dart';

import 'package:stud_aid/profile_page.dart';

class Document extends StatefulWidget {
  const Document({super.key});

  @override
  State<Document> createState() => _DocumentState();
}

class _DocumentState extends State<Document> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(32, 50, 57, 0.1),
      ),
      height: 162,
      width: 330,
      padding: const EdgeInsets.all(10),
      child: Row(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
        Container(
            width: 310,
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: const Text('Theory of relativity',
                      style: TextStyle(
                          fontSize: 23,
                          color: Color.fromRGBO(20, 30, 39, 1.0))),
                ),
                const Text('By: John Doe',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromRGBO(20, 30, 39, 1.0))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 11),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            primary: const Color.fromRGBO(20, 30, 39, 1.0),
                            minimumSize: Size(90, 40)),
                        child: const Text(
                          'See details',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ]),
    );
  }
}
