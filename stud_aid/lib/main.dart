import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/advert_details_ful.dart';
import 'package:stud_aid/home_page.dart';
import 'package:stud_aid/home_page_ful.dart';
import 'package:stud_aid/providers/advert_provider.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/providers/category_provider.dart';
import 'package:stud_aid/providers/document_provider.dart';
import 'package:stud_aid/providers/location_provider.dart';
import 'package:stud_aid/providers/message_provider.dart';
import 'package:stud_aid/providers/reservation_provider.dart';
import 'package:stud_aid/providers/review_provider.dart';
import 'package:stud_aid/providers/subject_provider.dart';
import 'package:stud_aid/providers/user_provider.dart';
import 'package:stud_aid/utils/util.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AdvertProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => DocumentProvider()),
    ChangeNotifierProvider(create: (_) => ReservationProvider()),
    ChangeNotifierProvider(create: (_) => LocationProvider()),
    ChangeNotifierProvider(create: (_) => CategoryProvider()),
    ChangeNotifierProvider(create: (_) => SubjectProvider()),
    ChangeNotifierProvider(create: (_) => ReviewProvider()),
    ChangeNotifierProvider(create: (_) => MessageProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late UserProvider _userProvider;
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context, listen: false);
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
          SizedBox(
            width: 300.0,
            height: 100.0,
            child: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Email',
                  isDense: true,
                  contentPadding: EdgeInsets.all(8)),
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            width: 300.0,
            height: 50.0,
            child: TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Password',
                  isDense: true,
                  contentPadding: EdgeInsets.all(8)),
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50.0),
            child: ElevatedButton(
              onPressed: () async {
                try {
                  Authorization.username = _usernameController.text;
                  Authorization.password = _passwordController.text;
                  await _userProvider.get();
                  if (_userProvider.get() != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePageNew()),
                    );
                  }
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: Text("Error"),
                            content: Text(e.toString()),
                            actions: [
                              TextButton(
                                child: Text("Ok"),
                                onPressed: () => Navigator.pop(context),
                              )
                            ],
                          ));
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: const Color.fromRGBO(20, 30, 39, 1.0),
                  minimumSize: const Size(150, 50)),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 25),
              ),
            ),
          )
        ],
      ),
    );
  }
}
