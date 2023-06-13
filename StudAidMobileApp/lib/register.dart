import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/components/alertDialog.dart';
import 'package:stud_aid/home_page_ful.dart';
import 'package:stud_aid/providers/user_provider.dart';
import 'package:stud_aid/utils/util.dart';

import 'models/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController aboutController = new TextEditingController();
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController confirmPassController =
      new TextEditingController();
  UserProvider? _userProvider = null;
  List<User> data = [];
  List<String> dataStrings = [];
  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    loadData2();
  }

  Future loadData2() async {
    var tmpData = await _userProvider?.get(null);
    if (mounted) {
      setState(() {
        if (tmpData != null) {
          data = tmpData;
        }
      });
      for (var i = 0; i < data.length; i++) {
        dataStrings.add(data[i].username!);
      }
    }
  }

  bool Validate() {
    if (firstNameController.text == "") {
      showAlertDialog(context, "Fill first name field", "Warning");
      return false;
    }
    if (lastNameController.text == "") {
      showAlertDialog(context, "Fill last name field", "Warning");
      return false;
    }
    if (usernameController.text == "") {
      showAlertDialog(context, "Fill username field", "Warning");
      return false;
    }
    if (dataStrings.contains(usernameController.text)) {
      showAlertDialog(context, "Username already exists", "Warning");
      return false;
    }
    if (passwordController.text == "") {
      showAlertDialog(context, "Write your chosen password", "Warning");
      return false;
    }
    if (passwordController.text != confirmPassController.text) {
      showAlertDialog(
          context, "Confirmation password doesn't match", "Warning");
      return false;
    }
    if (aboutController.text == "") {
      showAlertDialog(context, "Fill out the description field", "Warning");
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
        body: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: 180,
                  padding:
                      const EdgeInsets.only(bottom: 100, right: 40, left: 40),
                  margin: const EdgeInsets.only(top: 30),
                  child: Image.asset(
                    'images/blueFullBetter.png',
                  ),
                ),
                SizedBox(
                  width: 300.0,
                  height: 60.0,
                  child: TextField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(20, 30, 39, 1.0)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(20, 30, 39, 1.0)),
                        ),
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(20, 30, 39, 1.0)),
                        labelText: 'First name',
                        isDense: true,
                        contentPadding: EdgeInsets.all(8)),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 300.0,
                  height: 60.0,
                  child: TextField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(20, 30, 39, 1.0)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(20, 30, 39, 1.0)),
                        ),
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(20, 30, 39, 1.0)),
                        labelText: 'Last name',
                        isDense: true,
                        contentPadding: EdgeInsets.all(8)),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 300.0,
                  height: 60.0,
                  child: TextField(
                    controller: aboutController,
                    decoration: const InputDecoration(
                        hintText: ("e.g A 32 year old math graduate"),
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(20, 30, 39, 1.0)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(20, 30, 39, 1.0)),
                        ),
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(20, 30, 39, 1.0)),
                        labelText: 'Description',
                        isDense: true,
                        contentPadding: EdgeInsets.all(8)),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
                SizedBox(
                  width: 300.0,
                  height: 60.0,
                  child: TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(20, 30, 39, 1.0)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(20, 30, 39, 1.0)),
                        ),
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(20, 30, 39, 1.0)),
                        labelText: 'Username',
                        isDense: true,
                        contentPadding: EdgeInsets.all(8)),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 300.0,
                  height: 60.0,
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(20, 30, 39, 1.0)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(20, 30, 39, 1.0)),
                        ),
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(20, 30, 39, 1.0)),
                        labelText: 'Password',
                        isDense: true,
                        contentPadding: EdgeInsets.all(8)),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 300.0,
                  height: 60.0,
                  child: TextField(
                    obscureText: true,
                    controller: confirmPassController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(20, 30, 39, 1.0)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(20, 30, 39, 1.0)),
                        ),
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(20, 30, 39, 1.0)),
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
                    onPressed: () async {
                      if (Validate()) {
                        Object newUser = {
                          "firstName": firstNameController.text,
                          "lastName": lastNameController.text,
                          "username": usernameController.text,
                          "password": passwordController.text,
                          "role": "basic user",
                          "description": aboutController.text,
                          "locationId": 1
                        };
                        await _userProvider?.insert(newUser);
                        Authorization.username = usernameController.text;
                        Authorization.password = passwordController.text;
                        await _userProvider?.get();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePageNew()),
                        );
                      }
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
          ),
        ),
      ),
    );
  }
}
