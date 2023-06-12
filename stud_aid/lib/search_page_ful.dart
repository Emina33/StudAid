import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/models/category.dart';
import 'package:stud_aid/models/location.dart';
import 'package:stud_aid/providers/category_provider.dart';
import 'package:stud_aid/providers/location_provider.dart';
import 'package:filter_list/filter_list.dart';
import 'components/bottom_bar.dart';
import 'components/slider.dart';
import 'components/top_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class SearchPage2 extends StatefulWidget {
  const SearchPage2({super.key});

  @override
  State<SearchPage2> createState() => _SearchPage2State();
}

class _SearchPage2State extends State<SearchPage2> {
  CategoryProvider? _categoryProvider = null;
  List<Category> data = [];
  List<bool> boolCat = [false, false];

  List<Location> data2 = [];
  List<bool> boolCit = [false, false, false, false, false, false, false];
  LocationProvider? _locationProvider = null;
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  static const List<String> cities = [
    "Živinice",
    "Mostar",
    "Visoko",
    "Sarajevo",
    "Zenica",
    "Travnik",
    "Tuzla"
  ];
  static const List<String> categories = [
    "Science",
    "Languages",
  ];
  @override
  void initState() {
    // TODO: implement initState
    _categoryProvider = context.read<CategoryProvider>();
    _locationProvider = context.read<LocationProvider>();
    loadData();
    loadData2();
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
            child: Column(children: [
              Container(
                height: 40,
                width: 420,
                margin: const EdgeInsets.only(right: 30.0, left: 30.0, top: 30),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1, color: Color.fromRGBO(32, 50, 57, 0.4)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(categories[0],
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(32, 50, 57, 0.4))))
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
                        title: Text(categories[1],
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
                        title: const Text("Languages",
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
                      const Text(
                        'Price',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(32, 50, 57, 0.4)),
                        textAlign: TextAlign.start,
                      ),
                      RangeSlider(
                        activeColor: const Color.fromRGBO(20, 30, 39, 1.0),
                        inactiveColor: const Color.fromRGBO(32, 50, 57, 0.4),
                        values: _currentRangeValues,
                        max: 100,
                        divisions: 5,
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
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        child: TextButton(
                            onPressed: () {},
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
}
