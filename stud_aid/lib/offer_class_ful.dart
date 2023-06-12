import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/components/alertDialog.dart';
import 'package:stud_aid/providers/advert_provider.dart';
import 'package:stud_aid/providers/category_provider.dart';
import 'package:stud_aid/providers/location_provider.dart';
import 'package:stud_aid/providers/subject_provider.dart';
import 'package:stud_aid/utils/util.dart';

import 'components/bottom_bar.dart';
import 'components/top_bar.dart';
import 'models/category.dart';
import 'models/location.dart';
import 'models/subject.dart';

class OfferClassPage2 extends StatefulWidget {
  const OfferClassPage2({super.key});

  @override
  State<OfferClassPage2> createState() => _OfferClassPage2State();
}

class _OfferClassPage2State extends State<OfferClassPage2> {
  CategoryProvider? _categoryProvider = null;
  List<Category> data = [];
  SubjectProvider? _subjectProvider = null;
  AdvertProvider? _advertProvider = null;
  List<Subject> dataSubjects = [];
  List<String> dataString = [];
  static const List<String> categories = ["Science", "Languages"];
  static const List<String> cities = [
    "Živinice",
    "Mostar",
    "Visoko",
    "Sarajevo",
    "Zenica",
    "Travnik",
    "Tuzla"
  ];
  static const List<String> subjects = ["Biology"];
  String selectedLocation = cities.first;
  String selectedCategory = categories.first;
  String selectedSubject = subjects.first;
  final timeRule = RegExp(r'(([01]?[0-9]|2[0-3]):[0-5][0-9],){1,8}');
  List<Location> data2 = [];
  List<String?> data2String = [];
  LocationProvider? _locationProvider = null;
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController authorController = new TextEditingController();
  final TextEditingController priceController = new TextEditingController();
  final TextEditingController timeController = new TextEditingController();
  bool Validate() {
    if (nameController.text == "") {
      showAlertDialog(context, "Write the advert name", "Warning");
      return false;
    }
    if (priceController.text == "") {
      showAlertDialog(context, "Write the price of a class", "Warning");
      return false;
    }
    if (int.tryParse(priceController.text) == null) {
      showAlertDialog(context, "Price must be a number", "Warning");
      return false;
    }
    if (timeController.text == "") {
      showAlertDialog(context, "Write the time you are available", "Warning");
      return false;
    }
    if (!timeRule.hasMatch("${timeController.text},")) {
      showAlertDialog(
          context, "The acceptable format is e.g 10:00,11:00", "Warning");
      return false;
    }
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    _categoryProvider = context.read<CategoryProvider>();
    _locationProvider = context.read<LocationProvider>();
    _subjectProvider = context.read<SubjectProvider>();
    _advertProvider = context.read<AdvertProvider>();
    loadData();
    loadData2();
    loadData3();
  }

  Future loadData() async {
    var tmpData = await _categoryProvider?.get(null);
    setState(() {
      data = tmpData!;
    });
    setState(() {
      data.forEach((element) {
        dataString.add(element.categoryName!);
      });
    });
    print(dataString.length);
  }

  Future loadData2() async {
    var tmpData = await _locationProvider?.get(null);
    setState(() {
      data2 = tmpData!;
    });
    setState(() {
      data2String = data2.map((e) => e.city).toList();
    });
  }

  Future loadData3() async {
    var tmpData = await _subjectProvider?.get(null);
    setState(() {
      dataSubjects = tmpData!;
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
            child: Container(
              padding: EdgeInsets.only(right: 30, left: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(32, 50, 57, 0.4)))),
                      child: const Text(
                        'Offer class',
                        style: TextStyle(
                            fontSize: 25,
                            color: Color.fromRGBO(20, 30, 39, 1.0)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // SizedBox(
                    //     width: 300.0,
                    //     height: 50.0,
                    //     child: DropdownButton<String>(
                    //       isExpanded: true,
                    //       hint: const Text("Category"),
                    //       value: selectedCategory,
                    //       icon: const Icon(Icons.arrow_drop_down),
                    //       elevation: 16,
                    //       style: const TextStyle(
                    //           color: Color.fromRGBO(20, 30, 39, 1.0),
                    //           fontSize: 20),
                    //       underline: Container(
                    //         height: 1,
                    //         color: Color.fromRGBO(20, 30, 39, 1.0),
                    //       ),
                    //       onChanged: (String? value) {
                    //         // This is called when the user selects an item.
                    //         setState(() {
                    //           selectedCategory = value!;
                    //         });
                    //       },
                    //       items: categories
                    //           .map<DropdownMenuItem<String>>((String value) {
                    //         return DropdownMenuItem<String>(
                    //           value: value,
                    //           child: Text(value),
                    //         );
                    //       }).toList(),
                    //     )),
                    SizedBox(
                      width: 300.0,
                      height: 50.0,
                      child: TextField(
                        controller: nameController,
                        cursorColor: const Color.fromRGBO(20, 30, 39, 1.0),
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(20, 30, 39, 1.0)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(20, 30, 39, 1.0)),
                          ),
                          border: UnderlineInputBorder(),
                          labelText: 'Advert name',
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(20, 30, 39, 1.0)),
                          isDense: true,
                        ),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(20, 30, 39, 1.0)),
                      ),
                    ),

                    SizedBox(
                        width: 300.0,
                        height: 50.0,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: const Text("Subject"),
                          value: selectedSubject,
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
                    SizedBox(
                      width: 300.0,
                      height: 50.0,
                      child: TextField(
                        controller: priceController,
                        cursorColor: Color.fromRGBO(20, 30, 39, 1.0),
                        decoration: const InputDecoration(
                          hintText: ("Enter a price for a single lesson"),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(20, 30, 39, 1.0)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(20, 30, 39, 1.0)),
                          ),
                          border: UnderlineInputBorder(),
                          labelText: 'Set price',
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(20, 30, 39, 1.0)),
                          isDense: true,
                        ),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(20, 30, 39, 1.0)),
                      ),
                    ),
                    SizedBox(
                      width: 300.0,
                      height: 50.0,
                      child: TextField(
                        controller: timeController,
                        cursorColor: Color.fromRGBO(20, 30, 39, 1.0),
                        decoration: const InputDecoration(
                          hintText: ("e.g. 10:00, 11:00, 12:00"),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(20, 30, 39, 1.0)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(20, 30, 39, 1.0)),
                          ),
                          border: UnderlineInputBorder(),
                          labelText: 'Available time',
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(20, 30, 39, 1.0)),
                          isDense: true,
                        ),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(20, 30, 39, 1.0)),
                      ),
                    ),
                    Container(
                      width: 300,
                      child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 60.0,
                              height: 50.0,
                              child: TextField(
                                cursorColor: Color.fromRGBO(20, 30, 39, 1.0),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(20, 30, 39, 1.0)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(20, 30, 39, 1.0)),
                                  ),
                                  border: UnderlineInputBorder(),
                                  labelText: 'Day',
                                  labelStyle: TextStyle(
                                      color: Color.fromRGBO(20, 30, 39, 1.0)),
                                  isDense: true,
                                ),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(20, 30, 39, 1.0)),
                              ),
                            ),
                            SizedBox(
                              width: 60.0,
                              height: 50.0,
                              child: TextField(
                                cursorColor: Color.fromRGBO(20, 30, 39, 1.0),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(20, 30, 39, 1.0)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(20, 30, 39, 1.0)),
                                  ),
                                  border: UnderlineInputBorder(),
                                  labelText: 'Month',
                                  labelStyle: TextStyle(
                                      color: Color.fromRGBO(20, 30, 39, 1.0)),
                                  isDense: true,
                                ),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(20, 30, 39, 1.0)),
                              ),
                            ),
                            SizedBox(
                              width: 120.0,
                              height: 50.0,
                              child: TextField(
                                cursorColor: Color.fromRGBO(20, 30, 39, 1.0),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(20, 30, 39, 1.0)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(20, 30, 39, 1.0)),
                                  ),
                                  border: UnderlineInputBorder(),
                                  labelText: 'Year',
                                  labelStyle: TextStyle(
                                      color: Color.fromRGBO(20, 30, 39, 1.0)),
                                  isDense: true,
                                ),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(20, 30, 39, 1.0)),
                              ),
                            ),
                          ]),
                    ),

                    // Container(
                    //   margin: const EdgeInsets.only(top: 30, bottom: 30),
                    //   decoration: const BoxDecoration(
                    //       border: Border(
                    //           bottom: BorderSide(
                    //               width: 1,
                    //               color: Color.fromRGBO(32, 50, 57, 0.4)))),
                    //   child: const Text(
                    //     'Additional information',
                    //     style: TextStyle(
                    //         fontSize: 20, color: Color.fromRGBO(32, 50, 57, 0.4)),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    // Container(
                    //     height: 150,
                    //     width: 300,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: const Color.fromRGBO(32, 50, 57, 0.1),
                    //     ),
                    //     child: Container(
                    //       height: double.infinity,
                    //       width: double.infinity,
                    //       child: TextField(
                    //         decoration: InputDecoration(
                    //           fillColor: Colors.white,
                    //           focusedBorder: OutlineInputBorder(
                    //             borderSide: const BorderSide(
                    //                 color: Colors.transparent, width: 2.0),
                    //             borderRadius: BorderRadius.circular(25.0),
                    //           ),
                    //           enabledBorder: OutlineInputBorder(
                    //             borderSide: const BorderSide(
                    //                 color: Colors.transparent, width: 2.0),
                    //             borderRadius: BorderRadius.circular(25.0),
                    //           ),
                    //         ),
                    //         keyboardType: TextInputType.multiline,
                    //         maxLines: null,
                    //       ),
                    //     )),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: TextButton(
                          onPressed: () async {
                            if (Validate()) {
                              if (dataSubjects != null &&
                                  dataSubjects.length > 0) {
                                int? num = dataSubjects
                                    .firstWhere((element) =>
                                        element.subjectName == selectedSubject)
                                    .subjectId;
                                ;
                                Object advertNew = {
                                  "advertName": nameController.text,
                                  "availableTime": timeController.text,
                                  "price": int.parse(priceController.text),
                                  "tutor": Authorization.id,
                                  "subjectId": num,
                                  "date": 1
                                };
                                await _advertProvider?.insert(advertNew);
                                showAlertDialog(
                                    context,
                                    "You have successfully added an advert",
                                    "Success");
                                nameController.clear();
                                timeController.clear();
                                priceController.clear();
                              }
                            }
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
}
