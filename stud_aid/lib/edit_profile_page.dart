import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/providers/user_provider.dart';
import 'package:stud_aid/utils/util.dart';

import 'components/bottom_bar.dart';
import 'components/top_bar.dart';
import 'models/user.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController aboutController = new TextEditingController();
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();

  File? image;
  String? imageString = "";
  Future pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      final imageTemp2 = File(image.path).readAsBytesSync();
      String imgBytes = base64Encode(imageTemp2);
      setState(() {
        imageString = imgBytes;
      });
      setState(() => {this.image = imageTemp});
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  UserProvider? _userProvider = null;
  User? user = null;
  late AnimationController _controller;
  late Animation _animation;
  final ScrollController _controllerScroll = ScrollController();
  void _scrollDown() {
    _controllerScroll.jumpTo(_controllerScroll.position.maxScrollExtent);
  }

  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();

    loadData();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this as TickerProvider);
    _animation = Tween(begin: 300.0, end: 50.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _scrollDown();
      } else {}
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  Future loadData() async {
    var tmpData = await _userProvider?.get(null);
    setState(() {
      user = tmpData?.firstWhere(
          (element) => element.userId == Authorization.id,
          orElse: () => new User());
      aboutController.text = user!.description!;
      passwordController.text = Authorization.password!;
      firstNameController.text = user!.firstName!;
      lastNameController.text = user!.lastName!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50), child: TopBar()),
          body: SingleChildScrollView(
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
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(top: 10),
                          child: user != null && user!.profilePicture != ""
                              ? (image != null
                                  ? Image.file(image!)
                                  : Text(
                                      "No image selected",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromRGBO(32, 50, 57, 1)),
                                      textAlign: TextAlign.center,
                                    ))
                              : Text(
                                  "No image selected",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(32, 50, 57, 1)),
                                  textAlign: TextAlign.center,
                                ))),
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
                              color: const Color.fromRGBO(32, 50, 57, 0.1),
                            ),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: TextField(
                                controller: firstNameController,
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
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            )),
                        Container(
                            width: 90,
                            height: 60,
                            margin: EdgeInsets.only(right: 10, left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(32, 50, 57, 0.1),
                            ),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: TextField(
                                controller: lastNameController,
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
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ))
                        // TextField(
                        //   //"${user?.firstName == null ? "" : user?.firstName} ${user?.lastName == null ? "" : user?.lastName}",
                        //   controller: firstNameController,
                        //   style: TextStyle(
                        //       fontSize: 25,
                        //       color: Color.fromRGBO(20, 30, 39, 1.0)),
                        //   textAlign: TextAlign.center,
                        // ),
                        // TextField(
                        //   //"${user?.firstName == null ? "" : user?.firstName} ${user?.lastName == null ? "" : user?.lastName}",
                        //   controller: lastNameController,
                        //   style: TextStyle(
                        //       fontSize: 25,
                        //       color: Color.fromRGBO(20, 30, 39, 1.0)),
                        //   textAlign: TextAlign.center,
                        // ),
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
                            controller: passwordController,
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
                          controller: passwordController,
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
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: TextButton(
                        onPressed: () async {
                          Object appUserUpdate = {
                            "firstName": firstNameController.text,
                            "lastName": firstNameController.text,
                            "role": "basic user",
                            "password": passwordController.text,
                            "description": aboutController.text,
                            "profilePicture": imageString
                          };
                          if (_userProvider != null && user != null)
                            await _userProvider?.update(
                                user!.userId!, appUserUpdate);
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(20, 30, 39, 1.0)),
                        )),
                  ),
                ]),
          ),
          bottomNavigationBar: const BottomBar()),
    );
  }
}
