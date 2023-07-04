import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/components/alertDialog.dart';
import 'package:stud_aid/home_page_ful.dart';
import 'package:stud_aid/providers/advert_provider.dart';
import 'package:stud_aid/providers/category_provider.dart';
import 'package:stud_aid/providers/document_provider.dart';
import 'package:stud_aid/providers/location_provider.dart';
import 'package:stud_aid/providers/message_provider.dart';
import 'package:stud_aid/providers/reservation_provider.dart';
import 'package:stud_aid/providers/review_provider.dart';
import 'package:stud_aid/providers/subject_provider.dart';
import 'package:stud_aid/providers/user_provider.dart';
import 'package:stud_aid/register.dart';
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
    return MaterialApp(
      theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
              cursorColor: Color.fromRGBO(20, 30, 39, 1.0),
              selectionHandleColor: Color.fromRGBO(20, 30, 39, 1.0),
              selectionColor: Color.fromRGBO(20, 30, 39, 0.1))),
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
    bool Validate() {
      if (_usernameController.text == "") {
        showAlertDialog(context, "Fill the username field", "Warning");
        return false;
      }
      if (_passwordController.text == "") {
        showAlertDialog(context, "Write the password", "Warning");
        return false;
      }
      return true;
    }

    _userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromRGBO(238, 237, 222, 1),
      body: SingleChildScrollView(
        child: Column(
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
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(20, 30, 39, 1.0)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(20, 30, 39, 1.0)),
                    ),
                    border: UnderlineInputBorder(),
                    labelText: 'Username',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(20, 30, 39, 1.0)),
                    isDense: true,
                    contentPadding: EdgeInsets.all(8)),
                textAlign: TextAlign.left,
                cursorColor: Color.fromRGBO(20, 30, 39, 1.0),
                style: const TextStyle(
                    fontSize: 20, color: Color.fromRGBO(20, 30, 39, 1.0)),
              ),
            ),
            SizedBox(
              width: 300.0,
              height: 50.0,
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(20, 30, 39, 1.0)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(20, 30, 39, 1.0)),
                    ),
                    border: UnderlineInputBorder(),
                    labelText: 'Password',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(20, 30, 39, 1.0)),
                    isDense: true,
                    contentPadding: EdgeInsets.all(8)),
                textAlign: TextAlign.left,
                cursorColor: Color.fromRGBO(20, 30, 39, 1.0),
                style: const TextStyle(
                    fontSize: 20, color: Color.fromRGBO(20, 30, 39, 1.0)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50.0),
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    Authorization.username = "";
                    Authorization.password = "";
                    if (Validate()) {
                      Authorization.username = _usernameController.text;
                      Authorization.password = _passwordController.text;
                      await _userProvider.get();

                      Navigator.of(context).pop();
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
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: TextButton(
                  onPressed: () {
                    Authorization.username = "admin";
                    Authorization.password = "test";
                    _usernameController.clear();
                    _passwordController.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text(
                    'Don\'t have an account? Sign up.',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Color.fromRGBO(20, 30, 39, 1.0)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
