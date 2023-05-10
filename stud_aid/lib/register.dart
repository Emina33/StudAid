import 'package:flutter/material.dart';
import 'package:stud_aid/home_page.dart';
import 'package:stud_aid/main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
      body: Column(
        children: [
          Container(
            height: 300,
            margin: const EdgeInsets.all(30.0),
            padding: const EdgeInsets.all(50.0),
            child: Image.asset(
              'images/blueFullBetter.png',
            ),
          ),
          const SizedBox(
            width: 300.0,
            height: 60.0,
            child: TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'First name',
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
                  labelText: 'Last name',
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
                  labelText: 'Email',
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
                  labelText: 'Password',
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
                  labelText: 'Confirm password',
                  isDense: true,
                  contentPadding: EdgeInsets.all(8)),
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RootPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: const Color.fromRGBO(20, 30, 39, 1.0),
                  minimumSize: Size(150, 50)),
              child: const Text(
                'Register',
                style: TextStyle(fontSize: 25),
              ),
            ),
          )
        ],
      ),
    );
  }
}
