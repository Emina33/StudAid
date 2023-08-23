import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/components/alertDialog.dart';
import 'package:stud_aid/providers/location_provider.dart';
import 'package:stud_aid/providers/user_provider.dart';
import 'package:stud_aid/utils/util.dart';

import 'components/bottom_bar.dart';
import 'components/loadingScreen.dart';
import 'components/top_bar.dart';
import 'models/location.dart';
import 'models/user.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPassController =
      new TextEditingController();
  final TextEditingController aboutController = new TextEditingController();
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();

  File? image;
  String? imageString = "";
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      final imageTemp2 = File(image.path).readAsBytesSync();
      String imgBytes = base64Encode(imageTemp2);
      setState(() {
        imageString = imgBytes;
      });
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  static const List<String> cities = [
    "Živinice",
    "Mostar",
    "Visoko",
    "Sarajevo",
    "Zenica",
    "Travnik",
    "Tuzla",
    "Ilijaš",
    "Konjic",
    "Jablanica",
    "Banja Luka",
    "Unselected",
    "Livno"
  ];
  UserProvider? _userProvider = null;
  User? user = null;
  LocationProvider? _locationProvider = null;
  String? locationSelected = cities[11];
  List<Location> data = [];
  List<String> dataStrings = [];
  final ScrollController _controllerScroll = ScrollController();
  void _scrollDown() {
    _controllerScroll.jumpTo(_controllerScroll.position.maxScrollExtent);
  }

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    _locationProvider = context.read<LocationProvider>();
    loadData2();
  }

  bool loading = true;
  Future loadData2() async {
    var tmpData = await _locationProvider?.get(null);
    setState(() {
      if (tmpData != null) {
        data = tmpData;
      }
    });

    for (var i = 0; i < data.length; i++) {
      dataStrings.add(data[i].city!);
    }
    loadData();
  }

  Future loadData() async {
    var tmpData = await _userProvider?.get(null);
    setState(() {
      user = tmpData?.firstWhere(
          (element) => element.userId == Authorization.id,
          orElse: () => new User());
      aboutController.text = user!.description!;
      passwordController.text = Authorization.password!;
      confirmPassController.text = Authorization.password!;
      firstNameController.text = user!.firstName!;
      lastNameController.text = user!.lastName!;
      imageString = user!.profilePicture!;
      locationSelected = data
          .firstWhere((element) => element.locationId == user!.locationId)
          .city;
    });
    setState(() {
      loading = false;
    });
  }

  bool Validate() {
    if (aboutController.text == "") {
      showAlertDialog(context, "Description can't be empty", "Warning");
      return false;
    }
    if (firstNameController.text == "") {
      showAlertDialog(context, "First name field can't be empty", "Warning");
      return false;
    }
    if (lastNameController.text == "") {
      showAlertDialog(context, "Last name field can't be empty", "Warning");
      return false;
    }
    if (passwordController.text == "") {
      showAlertDialog(context, "Password can't be empty", "Warning");
      return false;
    }
    if (passwordController.text != confirmPassController.text) {
      showAlertDialog(context, "Passwords don't match", "Warning");
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
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50), child: TopBar()),
          body: loading
              ? const LoadingScreen()
              : SingleChildScrollView(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InkWell(
                            onTap: () {
                              pickImage();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: 130,
                                width: 100,
                                margin: const EdgeInsets.only(top: 10),
                                child: user != null &&
                                        user!.profilePicture != "" &&
                                        image == null
                                    ? Container(
                                        height: 100,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Click image to change",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromRGBO(
                                                      32, 50, 57, 1)),
                                              textAlign: TextAlign.center,
                                            ),
                                            Container(
                                              height: 100,
                                              width: 70,
                                              child: imageFromBase64String(
                                                  user!.profilePicture!),
                                            )
                                          ],
                                        ),
                                      )
                                    : (image != null
                                        ? Image.file(image!)
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.person_pin_outlined,
                                                color: Color.fromRGBO(
                                                    32, 50, 57, 1),
                                              ),
                                              Text(
                                                "  No image selected, click to select",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Color.fromRGBO(
                                                        32, 50, 57, 1)),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          )))),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 90,
                                  height: 60,
                                  margin: EdgeInsets.only(right: 10, left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color.fromRGBO(32, 50, 57, 0.1),
                                  ),
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: TextField(
                                      cursorColor:
                                          Color.fromRGBO(20, 30, 39, 1.0),
                                      controller: firstNameController,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                      ),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  )),
                              Container(
                                  width: 90,
                                  height: 60,
                                  margin: EdgeInsets.only(right: 10, left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color.fromRGBO(32, 50, 57, 0.1),
                                  ),
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: TextField(
                                      cursorColor:
                                          Color.fromRGBO(20, 30, 39, 1.0),
                                      controller: lastNameController,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                      ),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              right: 30, left: 30, bottom: 10, top: 20),
                          child: const Text('About',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(32, 50, 57, 0.8))),
                        ),
                        Container(
                            height: 200,
                            width: 300,
                            margin: EdgeInsets.only(right: 30, left: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(32, 50, 57, 0.1),
                            ),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: TextField(
                                textAlign: TextAlign.justify,
                                cursorColor: Color.fromRGBO(20, 30, 39, 1.0),
                                controller: aboutController,
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
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, top: 20),
                          child: const Text('Location',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(32, 50, 57, 0.8))),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(right: 30, left: 30, top: 10),
                          child: SizedBox(
                              width: 250.0,
                              height: 50.0,
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: const Text("Location",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color:
                                            Color.fromRGBO(32, 50, 57, 0.8))),
                                value: locationSelected != null
                                    ? locationSelected
                                    : "",
                                icon: const Icon(Icons.arrow_drop_down),
                                elevation: 16,
                                style: const TextStyle(
                                    color: Color.fromRGBO(20, 30, 39, 1.0),
                                    fontSize: 20),
                                underline: Container(
                                  height: 1,
                                  color: Color.fromRGBO(20, 30, 39, 1.0),
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    locationSelected = value!;
                                  });
                                },
                                items: cities.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              right: 30, left: 30, bottom: 10, top: 20),
                          child: const Text('Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(32, 50, 57, 0.8))),
                        ),
                        Container(
                            width: 300,
                            height: 60,
                            margin: EdgeInsets.only(right: 30, left: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(32, 50, 57, 0.1),
                            ),
                            child: InkWell(
                              onTap: () {
                                _scrollDown();
                              },
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: TextField(
                                  cursorColor: Color.fromRGBO(20, 30, 39, 1.0),
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                  obscureText: true,
                                ),
                              ),
                            )),
                        Container(
                          margin: const EdgeInsets.only(
                              right: 30, left: 30, bottom: 10, top: 20),
                          child: const Text('Confirm password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(32, 50, 57, 0.8))),
                        ),
                        Container(
                            width: 300,
                            height: 60,
                            margin: EdgeInsets.only(right: 30, left: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(32, 50, 57, 0.1),
                            ),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: TextField(
                                cursorColor: Color.fromRGBO(20, 30, 39, 1.0),
                                controller: confirmPassController,
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
                                obscureText: true,
                              ),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 30),
                              child: TextButton(
                                  onPressed: () async {
                                    if (Validate()) {
                                      if (data.isNotEmpty) {
                                        var locationId = data
                                            .firstWhere((element) =>
                                                element.city ==
                                                locationSelected)
                                            .locationId;
                                        Object appUserUpdate = {
                                          "firstName": firstNameController.text,
                                          "lastName": lastNameController.text,
                                          "role": "basic user",
                                          "password": passwordController.text,
                                          "description": aboutController.text,
                                          "profilePicture": imageString,
                                          "locationId": locationId,
                                        };
                                        if (_userProvider != null &&
                                            user != null)
                                          await _userProvider?.update(
                                              user!.userId!, appUserUpdate);
                                        showAlertDialog(
                                            context,
                                            "You have successfully updated your profile.",
                                            "Success");
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'Save',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromRGBO(20, 30, 39, 1.0)),
                                  )),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 30),
                              child: TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromRGBO(20, 30, 39, 1.0)),
                                  )),
                            ),
                          ],
                        ),
                      ]),
                ),
          bottomNavigationBar: const BottomBar()),
    );
  }
}
