import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/components/alertDialog.dart';
import 'package:stud_aid/providers/advert_provider.dart';
import 'package:stud_aid/providers/category_provider.dart';
import 'package:stud_aid/providers/location_provider.dart';
import 'package:stud_aid/providers/subject_provider.dart';
import 'package:stud_aid/utils/util.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
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
  String? _selectedDate = '';
  List<Subject> dataSubjects = [];
  List<String> dataString = [];
  List categories = [];
  List cities = [];
  List subjects = [];
  int selectedLocation = 1;
  int selectedCategory = 1;
  int selectedSubject = 1;
  final timeRule = RegExp(r'(([01]?[0-9]|2[0-3]):[0-5][0-9],){1,8}');
  List<Location> data2 = [];
  List<String?> data2String = [];
  LocationProvider? _locationProvider = null;
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController authorController = new TextEditingController();
  final TextEditingController priceController = new TextEditingController();
  final TextEditingController timeController = new TextEditingController();
  DateRangePickerController _datePickerController = DateRangePickerController();
  bool Validate() {
    if (nameController.text == "") {
      showAlertDialog(context, "Write the advert name", "Validation error");
      return false;
    }
    if (priceController.text == "") {
      showAlertDialog(
          context, "Write the price of a class", "Validation error");
      return false;
    }
    if (int.tryParse(priceController.text) == null) {
      showAlertDialog(context, "Price must be a number", "Validation error");
      return false;
    }
    if (timeController.text == "") {
      showAlertDialog(
          context, "Write the time you are available", "Validation error");
      return false;
    }
    if (!timeRule.hasMatch("${timeController.text},")) {
      showAlertDialog(context, "The acceptable format is e.g 10:00,11:00",
          "Validation error");
      return false;
    }
    if (_selectedDate == "") {
      showAlertDialog(context, "Select a date", "Validation error");
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _categoryProvider = context.read<CategoryProvider>();
    _locationProvider = context.read<LocationProvider>();
    _subjectProvider = context.read<SubjectProvider>();
    _advertProvider = context.read<AdvertProvider>();
    _datePickerController.view = DateRangePickerView.month;
    loadData();
    loadData2();
    loadData3();
  }

  Future loadData() async {
    var tmpData = await _categoryProvider?.get(null);
    setState(() {
      categories = tmpData!;
    });
    setState(() {
      categories.forEach((element) {
        dataString.add(element.categoryName!);
      });
    });
    print(dataString.length);
  }

  Future loadData2() async {
    var tmpData = await _locationProvider?.get(null);
    setState(() {
      cities = tmpData!;
    });
  }

  Future loadData3() async {
    var tmpData = await _subjectProvider?.get(null);
    setState(() {
      subjects = tmpData!;
    });
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        _selectedDate = DateFormat.yMd().format(args.value).toString();
      }
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
                        child: DropdownButton(
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
                          onChanged: (value) {
                            // This is called when the user selects an item.
                            setState(() {
                              selectedSubject = value as int;
                            });
                          },
                          items: subjects.map((e) {
                            return DropdownMenuItem(
                              value: e.subjectId,
                              child: Text(e.subjectName),
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
                      margin: EdgeInsets.only(top: 10),
                      child: SfDateRangePicker(
                        monthCellStyle: DateRangePickerMonthCellStyle(
                            todayTextStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Color.fromRGBO(20, 30, 39, 1.0))),
                        yearCellStyle: DateRangePickerYearCellStyle(
                            todayTextStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Color.fromRGBO(20, 30, 39, 1.0))),
                        controller: _datePickerController,
                        view: DateRangePickerView.month,
                        minDate: DateTime.now(),
                        maxDate: DateTime(2024),
                        todayHighlightColor: Color.fromRGBO(20, 30, 39, 1.0),
                        selectionColor: Color.fromRGBO(20, 30, 39, 1.0),
                        onSelectionChanged: onSelectionChanged,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 0),
                          child: TextButton(
                              onPressed: () async {
                                if (Validate()) {
                                  if (dataSubjects.length > 0) {
                                    Object advertNew = {
                                      "advertName": nameController.text,
                                      "availableTime":
                                          '${_selectedDate},${timeController.text},',
                                      "price": int.parse(priceController.text),
                                      "tutor": Authorization.id,
                                      "subjectId": selectedSubject,
                                      "date": 1
                                    };
                                    await _advertProvider?.insert(advertNew);
                                    showAlertDialog(
                                        context,
                                        "You have successfully added an advert",
                                        "Success");
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
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
                        Container(
                          margin: const EdgeInsets.only(top: 0),
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
                        )
                      ],
                    ),
                  ]),
            ),
          ),
          bottomNavigationBar: const BottomBar()),
    );
  }
}
