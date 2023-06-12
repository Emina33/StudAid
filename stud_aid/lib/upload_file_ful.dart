import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/providers/document_provider.dart';
import 'package:stud_aid/providers/subject_provider.dart';
import 'components/alertDialog.dart';
import 'components/bottom_bar.dart';
import 'dart:io';

import 'components/top_bar.dart';
import 'models/document.dart';
import 'models/subject.dart';

class UploadPage2 extends StatefulWidget {
  const UploadPage2({super.key});

  @override
  State<UploadPage2> createState() => _UploadPage2State();
}

class _UploadPage2State extends State<UploadPage2> {
  File? file;
  String fileString = "";
  static const List<String> subjects = ["Biology"];
  String selectedSubject = subjects.first;
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController authorController = new TextEditingController();
  final TextEditingController descriptionController =
      new TextEditingController();
  DocumentProvider? _documentProvider = null;
  Document? document = null;
  SubjectProvider? _subjectProvider = null;
  List<Subject> data = [];
  @override
  void initState() {
    // TODO: implement initState
    _documentProvider = context.read<DocumentProvider>();
    _subjectProvider = context.read<SubjectProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _subjectProvider?.get(null);
    setState(() {
      data = tmpData!;
    });
  }

  bool Validate() {
    if (nameController.text == "") {
      showAlertDialog(context, "Write the document name", "Warning");
      return false;
    }
    if (authorController.text == "") {
      showAlertDialog(context, "Write the name of the author", "Warning");
      return false;
    }
    if (descriptionController.text == "") {
      showAlertDialog(context,
          "Write a short content description of the document", "Warning");
      return false;
    }
    if (fileString == "") {
      showAlertDialog(context, "Select a document", "Warning");
      return false;
    }

    return true;
  }

  Future pickFile() async {
    try {
      //final file = await FilePicker.platform.pickFiles();
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) return;

      setState(() => file = File(result.files.single.path!));
      final temp = File(result.files.single.path!).readAsBytesSync();
      String fileBytes = base64Encode(temp);
      setState(() {
        fileString = fileBytes;
      });
    } on PlatformException catch (e) {
      print('Failed to pick file: $e');
    }
  }
  // void _openFileExplorer() async {
  //   FilePickerResult result = await FilePicker.platform.pickFiles();

  //   if (result != null) {
  //     setState(() {
  //       file = File(result.files.single.path);
  //     });
  //   } else {
  //     // User canceled the file selection
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50), child: TopBar()),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(right: 30, left: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(30),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(32, 50, 57, 0.4)))),
                      child: const Text(
                        'Upload file',
                        style: TextStyle(
                            fontSize: 25,
                            color: Color.fromRGBO(20, 30, 39, 1.0)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 300.0,
                      height: 60.0,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(20, 30, 39, 1.0)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(20, 30, 39, 1.0)),
                            ),
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(20, 30, 39, 1.0)),
                            border: UnderlineInputBorder(),
                            labelText: 'Document name',
                            isDense: true,
                            contentPadding:
                                EdgeInsets.only(right: 8, top: 8, bottom: 8)),
                        textAlign: TextAlign.left,
                        cursorColor: Color.fromRGBO(20, 30, 39, 1.0),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      width: 300.0,
                      height: 60.0,
                      child: TextField(
                        controller: authorController,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(20, 30, 39, 1.0)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(20, 30, 39, 1.0)),
                            ),
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(20, 30, 39, 1.0)),
                            labelText: 'Author',
                            isDense: true,
                            contentPadding:
                                EdgeInsets.only(right: 8, top: 8, bottom: 8)),
                        textAlign: TextAlign.left,
                        cursorColor: Color.fromRGBO(20, 30, 39, 1.0),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                        width: 300.0,
                        height: 60.0,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: const Text("Subject"),
                          value: selectedSubject,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          style: const TextStyle(
                            color: Color.fromRGBO(20, 30, 39, 1.0),
                            fontSize: 20,
                          ),
                          underline: Container(
                            height: 1,
                            color: Color.fromRGBO(20, 30, 39, 1.0),
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              selectedSubject = value!;
                            });
                          },
                          items: subjects
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )),
                    InkWell(
                        onTap: () {
                          pickFile();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(32, 50, 57, 0.1),
                            border: Border.all(
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.only(top: 30, bottom: 30),
                          child: file != null
                              ? Text(
                                  "File selected, click to change",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(32, 50, 57, 1)),
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  "Click to select file",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(32, 50, 57, 1)),
                                  textAlign: TextAlign.center,
                                ),
                        )),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(32, 50, 57, 0.4)))),
                      child: const Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(20, 30, 39, 1.0)),
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
                            autofocus: false,
                            cursorColor: Color.fromRGBO(20, 30, 39, 1.0),
                            controller: descriptionController,
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
                      margin: const EdgeInsets.only(top: 15),
                      child: TextButton(
                          onPressed: () async {
                            if (Validate()) {
                              int? selected = data
                                  .firstWhere((element) =>
                                      element.subjectName == selectedSubject)
                                  .subjectId;
                              Object document = {
                                "documentName": nameController.text,
                                "subjectId": selected,
                                "author": authorController.text,
                                "description": descriptionController.text,
                                "documentFile": fileString
                              };
                              await _documentProvider?.insert(document);
                              showAlertDialog(
                                  context,
                                  "You have successfully added a document.",
                                  "Success");
                              nameController.clear();
                              authorController.clear();
                              descriptionController.clear();
                              setState(() {
                                file = null;
                              });
                            }

                            //Navigator.pop(context);
                          },
                          child: const Text(
                            'Done',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(20, 30, 39, 1.0)),
                          )),
                    ),
                  ]),
            ),
          ),
          bottomNavigationBar: const BottomBar()),
    );
  }

  // showAlertDialog(BuildContext context) {
  //   // set up the button
  //   Widget okButton = TextButton(
  //     child: Text(
  //       "OK",
  //       style: TextStyle(color: Color.fromRGBO(20, 30, 39, 1.0)),
  //       textAlign: TextAlign.center,
  //     ),
  //     onPressed: () {
  //       Navigator.pop(context);
  //     },
  //   );

  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(32.0))),
  //     title: Text(
  //       "Success",
  //       style: TextStyle(fontSize: 20),
  //       textAlign: TextAlign.center,
  //     ),
  //     content: Container(
  //       height: 50,
  //       margin: EdgeInsets.only(top: 20),
  //       alignment: Alignment.center,
  //       child: Text(
  //         "You have succesfully added a document.",
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //     actions: [
  //       okButton,
  //     ],
  //   );

  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
}
