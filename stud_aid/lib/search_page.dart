import 'package:flutter/material.dart';
import 'package:stud_aid/components/bottom_bar.dart';
import 'package:stud_aid/components/slider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromRGBO(32, 50, 57, 0.4)),
                    textAlign: TextAlign.start,
                  ),
                  CheckboxListTile(
                    title: const Text("Category 1",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(32, 50, 57, 0.4))),
                    value: false,
                    onChanged: (newValue) {},
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  CheckboxListTile(
                    title: const Text("Category 2",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(32, 50, 57, 0.4))),
                    value: false,
                    onChanged: (newValue) {},
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  CheckboxListTile(
                    title: const Text("Category 3",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(32, 50, 57, 0.4))),
                    value: false,
                    onChanged: (newValue) {},
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  const Text(
                    'Cities',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromRGBO(32, 50, 57, 0.4)),
                    textAlign: TextAlign.start,
                  ),
                  CheckboxListTile(
                    title: const Text("City 1",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(32, 50, 57, 0.4))),
                    value: false,
                    onChanged: (newValue) {},
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  CheckboxListTile(
                    title: const Text("City 2",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(32, 50, 57, 0.4))),
                    value: false,
                    onChanged: (newValue) {},
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  CheckboxListTile(
                    title: const Text("City 3",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(32, 50, 57, 0.4))),
                    value: false,
                    onChanged: (newValue) {},
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  const Text(
                    'Price',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromRGBO(32, 50, 57, 0.4)),
                    textAlign: TextAlign.start,
                  ),
                  const MyStatefulWidget(),
                ],
              ))
        ]),
        bottomNavigationBar: const BottomBar());
  }
}
