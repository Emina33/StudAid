import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/models/category.dart';
import 'package:stud_aid/models/location.dart';
import 'package:stud_aid/providers/advert_provider.dart';
import 'package:stud_aid/providers/category_provider.dart';
import 'package:stud_aid/providers/document_provider.dart';
import 'package:stud_aid/providers/location_provider.dart';
import 'package:filter_list/filter_list.dart';
import 'package:stud_aid/providers/subject_provider.dart';
import 'package:stud_aid/providers/user_provider.dart';
import 'package:stud_aid/utils/util.dart';
import 'advert_details_ful.dart';
import 'components/alertDialog.dart';
import 'components/bottom_bar.dart';
import 'components/slider.dart';
import 'components/top_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'document_page_ful.dart';
import 'models/advert.dart';
import 'models/document.dart';
import 'models/subject.dart';
import 'models/user.dart';
import 'my_profile_page_ful.dart';

class SearchPage2 extends StatefulWidget {
  const SearchPage2({super.key});

  @override
  State<SearchPage2> createState() => _SearchPage2State();
}

class _SearchPage2State extends State<SearchPage2> {
  CategoryProvider? _categoryProvider = null;
  List<Category> data = [];
  List<bool> boolCat = [false, false, false, false];
  AdvertProvider? _advertProvider = null;
  List<Advert> adverts = [];
  UserProvider? _userProvider = null;
  List<User> users = [];
  DocumentProvider? _documentProvider = null;
  List<Document> documents = [];

  SubjectProvider? _subjectProvider = null;
  List<Subject> subjects = [];
  List<Location> data2 = [];
  List<int> selectedCategories = [];
  List<int> selectedCities = [];
  List<int> selectedSubjects = [];
  List<int> selectedLocations = [];
  List<bool> boolCit = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  LocationProvider? _locationProvider = null;
  RangeValues _currentRangeValues = const RangeValues(0, 40);
  bool clicked = false;
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
  static const List<String> categories = [
    "Science",
    "Languages",
    "Arts and humanities",
    "Health oriented education"
  ];
  @override
  void initState() {
    // TODO: implement initState
    _categoryProvider = context.read<CategoryProvider>();
    _locationProvider = context.read<LocationProvider>();
    _advertProvider = context.read<AdvertProvider>();
    _documentProvider = context.read<DocumentProvider>();
    _userProvider = context.read<UserProvider>();
    _subjectProvider = context.read<SubjectProvider>();
    loadData();
    loadData2();
    loadUsers();
    loadData3();
    loadData4();
    loadData5();
  }

  void openFilterDelegate() async {
    await FilterListDelegate.show(
      context: context,
      list: data,
      onItemSearch: (user, query) {
        return true;
      },
      tileLabel: (category) => category.toString(),
      emptySearchChild: Center(child: Text('No user found')),
      searchFieldHint: 'Search Here..',
      onApplyButtonClick: (list) {
        // Do something with selected list
      },
    );
  }

  Future loadData() async {
    var tmpData = await _categoryProvider?.get(null);
    setState(() {
      data = tmpData!;
    });
  }

  Future loadUsers() async {
    var tmpData = await _userProvider?.get(null);
    setState(() {
      users = tmpData!;
    });
  }

  Future loadData3() async {
    var tmpData = await _advertProvider?.get(null);
    setState(() {
      adverts = tmpData!;
    });
  }

  Future loadData5() async {
    var tmpData = await _subjectProvider?.get(null);
    setState(() {
      subjects = tmpData!;
    });
  }

  void ChangeData() {
    for (var i = 0; i < boolCat.length; i++) {
      if (boolCat[i]) selectedCategories.add(i + 1);
    }
    for (var i = 0; i < boolCit.length; i++) {
      if (boolCit[i]) selectedLocations.add(i + 1);
    }
    for (var i = 0; i < subjects.length; i++) {
      if (selectedCategories.contains(subjects[i].categoryId))
        selectedSubjects.add(i + 1);
    }

    setState(() {
      adverts = adverts
          .where((advert) =>
              selectedLocations.contains(users
                  .firstWhere((element) => element.userId == advert.tutor)
                  .locationId) &&
              selectedSubjects.contains(advert.subjectId) &&
              advert.price! >= _currentRangeValues.start.round() &&
              advert.price! <= _currentRangeValues.end.round())
          .toList();
    });
    setState(() {
      documents = documents
          .where((document) => selectedSubjects.contains(document.subjectId))
          .toList();
    });
  }

  Future loadData4() async {
    var tmpData = await _documentProvider?.get(null);
    setState(() {
      documents = tmpData!;
    });
  }

  Future loadData2() async {
    var tmpData = await _locationProvider?.get(null);
    setState(() {
      data2 = tmpData!;
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
            child: clicked
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 420,
                          margin: const EdgeInsets.only(
                              right: 30.0, left: 30.0, top: 30),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(32, 50, 57, 0.4)))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Filtering by categories, cities and price",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromRGBO(32, 50, 57, 0.4)),
                                    textAlign: TextAlign.center,
                                  ))
                            ],
                          ),
                        ),
                        Column(
                          children: _buildAdvertCardList(),
                        ),
                        Column(
                          children: _buildDocumentCardList(),
                        )
                      ],
                    ),
                  )
                : Column(children: [
                    Container(
                      height: 40,
                      width: 420,
                      margin: const EdgeInsets.only(
                          right: 30.0, left: 30.0, top: 30),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(32, 50, 57, 0.4)))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "Filtering by categories, cities and price",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(32, 50, 57, 0.4)),
                                textAlign: TextAlign.center,
                              ))
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
                                  fontSize: 18,
                                  color: Color.fromRGBO(32, 50, 57, 0.4)),
                              textAlign: TextAlign.start,
                            ),
                            CheckboxListTile(
                              activeColor: Color.fromRGBO(32, 50, 57, 1),
                              title: Text(categories[0],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.4))),
                              value: boolCat[0],
                              onChanged: (newValue) {
                                setState(() {
                                  boolCat[0] = !boolCat[0];
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                            CheckboxListTile(
                              activeColor: Color.fromRGBO(32, 50, 57, 1),
                              title: Text(categories[1],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.4))),
                              value: boolCat[1],
                              onChanged: (newValue) {
                                setState(() {
                                  boolCat[1] = !boolCat[1];
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                            CheckboxListTile(
                              activeColor: Color.fromRGBO(32, 50, 57, 1),
                              title: Text(categories[2],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.4))),
                              value: boolCat[2],
                              onChanged: (newValue) {
                                setState(() {
                                  boolCat[2] = !boolCat[2];
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                            CheckboxListTile(
                              activeColor: Color.fromRGBO(32, 50, 57, 1),
                              title: Text(categories[3],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.4))),
                              value: boolCat[3],
                              onChanged: (newValue) {
                                setState(() {
                                  boolCat[3] = !boolCat[3];
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                            const Text(
                              'Cities',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(32, 50, 57, 0.4)),
                              textAlign: TextAlign.start,
                            ),
                            CheckboxListTile(
                              activeColor: Color.fromRGBO(32, 50, 57, 1),
                              title: Text(cities[0],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.4))),
                              value: boolCit[0],
                              onChanged: (newValue) {
                                setState(() {
                                  boolCit[0] = !boolCit[0];
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                            CheckboxListTile(
                              activeColor: Color.fromRGBO(32, 50, 57, 1),
                              title: Text(cities[1],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.4))),
                              value: boolCit[1],
                              onChanged: (newValue) {
                                setState(() {
                                  boolCit[1] = !boolCit[1];
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                            CheckboxListTile(
                              activeColor: Color.fromRGBO(32, 50, 57, 1),
                              title: Text(cities[2],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.4))),
                              value: boolCit[2],
                              onChanged: (newValue) {
                                setState(() {
                                  boolCit[2] = !boolCit[2];
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                            CheckboxListTile(
                              activeColor: Color.fromRGBO(32, 50, 57, 1),
                              title: Text(cities[3],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.4))),
                              value: boolCit[3],
                              onChanged: (newValue) {
                                setState(() {
                                  boolCit[3] = !boolCit[3];
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                            CheckboxListTile(
                              activeColor: Color.fromRGBO(32, 50, 57, 1),
                              title: Text(cities[4],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.4))),
                              value: boolCit[4],
                              onChanged: (newValue) {
                                setState(() {
                                  boolCit[4] = !boolCit[4];
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                            CheckboxListTile(
                              activeColor: Color.fromRGBO(32, 50, 57, 1),
                              title: Text(cities[5],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.4))),
                              value: boolCit[5],
                              onChanged: (newValue) {
                                setState(() {
                                  boolCit[5] = !boolCit[5];
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                            CheckboxListTile(
                              activeColor: Color.fromRGBO(32, 50, 57, 1),
                              title: Text(cities[6],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.4))),
                              value: boolCit[6],
                              onChanged: (newValue) {
                                setState(() {
                                  boolCit[6] = !boolCit[6];
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                            CheckboxListTile(
                              activeColor: Color.fromRGBO(32, 50, 57, 1),
                              title: Text(cities[7],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.4))),
                              value: boolCit[7],
                              onChanged: (newValue) {
                                setState(() {
                                  boolCit[7] = !boolCit[7];
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                            CheckboxListTile(
                              activeColor: Color.fromRGBO(32, 50, 57, 1),
                              title: Text(cities[8],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.4))),
                              value: boolCit[8],
                              onChanged: (newValue) {
                                setState(() {
                                  boolCit[8] = !boolCit[8];
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                            CheckboxListTile(
                              activeColor: Color.fromRGBO(32, 50, 57, 1),
                              title: Text(cities[9],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.4))),
                              value: boolCit[9],
                              onChanged: (newValue) {
                                setState(() {
                                  boolCit[9] = !boolCit[9];
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                            CheckboxListTile(
                              activeColor: Color.fromRGBO(32, 50, 57, 1),
                              title: Text(cities[10],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.4))),
                              value: boolCit[10],
                              onChanged: (newValue) {
                                setState(() {
                                  boolCit[10] = !boolCit[10];
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                            CheckboxListTile(
                              activeColor: Color.fromRGBO(32, 50, 57, 1),
                              title: Text(cities[11],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.4))),
                              value: boolCit[11],
                              onChanged: (newValue) {
                                setState(() {
                                  boolCit[11] = !boolCit[11];
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                            CheckboxListTile(
                              activeColor: Color.fromRGBO(32, 50, 57, 1),
                              title: Text(cities[12],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.4))),
                              value: boolCit[12],
                              onChanged: (newValue) {
                                setState(() {
                                  boolCit[12] = !boolCit[12];
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                            const Text(
                              'Price',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(32, 50, 57, 0.4)),
                              textAlign: TextAlign.start,
                            ),
                            RangeSlider(
                              activeColor:
                                  const Color.fromRGBO(20, 30, 39, 1.0),
                              inactiveColor:
                                  const Color.fromRGBO(32, 50, 57, 0.4),
                              values: _currentRangeValues,
                              max: 100,
                              divisions: 10,
                              labels: RangeLabels(
                                _currentRangeValues.start.round().toString(),
                                _currentRangeValues.end.round().toString(),
                              ),
                              onChanged: (RangeValues values) {
                                setState(() {
                                  _currentRangeValues = values;
                                });
                              },
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: TextButton(
                                  onPressed: () {
                                    ChangeData();
                                    setState(() {
                                      clicked = true;
                                    });
                                  },
                                  child: const Text(
                                    'Done',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromRGBO(20, 30, 39, 1.0)),
                                  )),
                            ),
                          ],
                        )),
                  ]),
          ),
          bottomNavigationBar: const BottomBar()),
    );
  }

  List<Widget> _buildCategoryList() {
    if (data.length == 0) {
      return [Text("Loading...")];
    }

    List<Widget> list = data
        .map(
          (x) => CheckboxListTile(
            title: Text(x.categoryName!,
                style: TextStyle(
                    fontSize: 18, color: Color.fromRGBO(32, 50, 57, 0.4))),
            value: boolCat[0],
            onChanged: (newValue) {},
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
        )
        .cast<Widget>()
        .toList();

    return list;
  }

  List<Widget> _buildLocationList() {
    if (data2.length == 0) {
      return [Text("Loading...")];
    }

    List<Widget> list = data2
        .map(
          (x) => CheckboxListTile(
            title: Text(x.city!,
                style: TextStyle(
                    fontSize: 18, color: Color.fromRGBO(32, 50, 57, 0.4))),
            value: false,
            onChanged: (newValue) {},
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
        )
        .cast<Widget>()
        .toList();

    return list;
  }

  List<Widget> _buildAdvertCardList() {
    if (adverts.length == 0) {
      return [Text("")];
    }

    List<Widget> list = adverts
        .map((x) => InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(32, 50, 57, 0.1),
                ),
                height: 220,
                width: 330,
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(top: 20),
                child: Row(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 110,
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: x.tutor != null &&
                                users.isNotEmpty &&
                                users
                                        .firstWhere((element) =>
                                            element.userId == x.tutor)
                                        .profilePicture! !=
                                    ""
                            ? imageFromBase64String(users
                                .firstWhere(
                                    (element) => element.userId == x.tutor)
                                .profilePicture!)
                            : Image.asset(
                                'images/blueFullBetter.png',
                                fit: BoxFit.scaleDown,
                              ),
                      ),
                      Container(
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MyProfilePage2(x.tutor!)),
                              );
                            },
                            child: const Text('See profile',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(20, 30, 39, 1.0)))),
                      ),
                    ],
                  ),
                  Container(
                      width: 170,
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(x.advertName!,
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Color.fromRGBO(20, 30, 39, 1.0))),
                          ),
                          Text('Price: ${x.price!}',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(20, 30, 39, 1.0))),
                          Container(
                            padding: const EdgeInsets.only(top: 50),
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => const BookPage()),
                                // );
                                if (x.tutor == Authorization.id) {
                                  showAlertDialog(
                                      context,
                                      "You can't book your own class!",
                                      "Warning");
                                }
                                // var pic = data3.firstWhere(
                                //     (element) => element.userId == x.tutor,
                                //     orElse: () => new User());
                                if (x.tutor != Authorization.id)
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AdvertDetailsFul(x.advertId!)),
                                  );
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  primary:
                                      const Color.fromRGBO(20, 30, 39, 1.0),
                                  minimumSize: Size(90, 40)),
                              child: const Text(
                                'Book',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      )),
                ]),
              ),
            ))
        .cast<Widget>()
        .toList();

    return list;
  }

  List<Widget> _buildDocumentCardList() {
    if (documents.length == 0) {
      return [Text("")];
    }

    List<Widget> list = documents
        .map((x) => InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(32, 50, 57, 0.1),
                ),
                height: 162,
                width: 330,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [],
                  ),
                  Container(
                      width: 310,
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(x.documentName!,
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Color.fromRGBO(20, 30, 39, 1.0))),
                          ),
                          Text('By: ${x.author!}',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(20, 30, 39, 1.0))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 11),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DocumentPage2(x.documentId!)),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      primary:
                                          const Color.fromRGBO(20, 30, 39, 1.0),
                                      minimumSize: Size(90, 40)),
                                  child: const Text(
                                    'See details',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                ]),
              ),
            ))
        .cast<Widget>()
        .toList();

    return list;
  }
}
