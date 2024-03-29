import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stud_aid/components/alertDialog.dart';
import 'package:stud_aid/components/loadingScreen.dart';
import 'package:stud_aid/components/top_bar.dart';
import 'package:stud_aid/document_page_ful.dart';
import 'package:stud_aid/my_profile_page_ful.dart';
import 'package:stud_aid/providers/advert_provider.dart';
import 'package:stud_aid/providers/document_provider.dart';
import 'package:stud_aid/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/review_list.dart';
import 'package:stud_aid/search_page_ful.dart';
import 'advert_details_ful.dart';
import 'components/bottom_bar.dart';
import 'models/document.dart';
import 'models/advert.dart';
import 'models/user.dart';
import 'utils/util.dart';

class HomePageNew extends StatefulWidget {
  static const String routeName = "/advert";
  const HomePageNew({super.key});

  @override
  State<HomePageNew> createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  AdvertProvider? _advertProvider = null;
  bool loading = true;
  UserProvider? _userProvider = null;
  DocumentProvider? _documentProvider = null;
  List<Advert> data = [];
  List<Advert> dataShow = [];
  List<Document> data2 = [];
  List<Document> data2Show = [];
  List<User> data3 = [];
  bool showYours = false;
  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _advertProvider = context.read<AdvertProvider>();
    _documentProvider = context.read<DocumentProvider>();
    _userProvider = context.read<UserProvider>();

    loadData3();
  }

  void showYourAdverts() {
    setState(() {
      dataShow = showYours
          ? data
          : data.where((element) => element.tutor != Authorization.id).toList();
    });
  }

  void filterData(String filter) {
    setState(() {
      dataShow = showYours
          ? data
              .where((element) =>
                  element.advertName!.toLowerCase().contains(filter))
              .toList()
          : data
              .where((element) =>
                  element.advertName!.toLowerCase().contains(filter) &&
                  element.tutor != Authorization.id)
              .toList();
      data2Show = data2
          .where(
              (element) => element.documentName!.toLowerCase().contains(filter))
          .toList();
    });
  }

  Future loadData() async {
    if (Authorization.id != null) {
      var tmpData = await _advertProvider?.getRecommended(Authorization.id!);
      setState(() {
        data = tmpData!;
        dataShow = showYours
            ? tmpData
            : tmpData
                .where((element) => element.tutor != Authorization.id)
                .toList();
      });
    } else {
      var tmpData = await _advertProvider?.get(null);
      setState(() {
        data = tmpData!;
        dataShow = showYours
            ? tmpData
            : tmpData
                .where((element) => element.tutor != Authorization.id)
                .toList();
      });
    }
  }

  Future loadData2() async {
    var tmpData = await _documentProvider?.get(null);
    setState(() {
      data2 = tmpData!;
      data2Show = tmpData;
    });
  }

  Future loadData3() async {
    var tmpData = await _userProvider?.get(null);
    setState(() {
      data3 = tmpData!;
    });
    if (data3.isNotEmpty &&
        data3
                .firstWhere(
                    (element) => element.username == Authorization.username)
                .userId !=
            null) {
      Authorization.id = data3
          .firstWhere((element) => element.username == Authorization.username)
          .userId;
    }
    loadData();
    loadData2();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50), child: TopBar()),
          body: SafeArea(
            child: loading
                ? const LoadingScreen()
                : SingleChildScrollView(
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: TextField(
                                controller: _searchController,
                                onSubmitted: (value) {
                                  filterData(value);
                                  _searchController.clear();
                                },
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(20, 30, 39, 1.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(20, 30, 39, 1.0)),
                                    ),
                                    hintText: "Search",
                                    prefixIcon: Icon(Icons.search),
                                    iconColor: Color.fromRGBO(20, 30, 39, 1.0),
                                    prefixIconColor:
                                        Color.fromRGBO(20, 30, 39, 1.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:
                                            BorderSide(color: Colors.grey))),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: IconButton(
                              icon: Icon(Icons.filter_list),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SearchPage2()),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      Container(
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReviewList()),
                              );
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.reviews_outlined,
                                    color: Color.fromRGBO(20, 30, 39, 1.0),
                                  ),
                                  const Text(
                                    ' Click here to review users',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromRGBO(20, 30, 39, 1.0)),
                                  )
                                ])),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: CheckboxListTile(
                          activeColor: Color.fromRGBO(32, 50, 57, 1),
                          title: Text("Select to include your own adverts",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(32, 50, 57, 1))),
                          value: showYours,
                          onChanged: (newValue) {
                            setState(() {
                              showYours = !showYours;
                            });
                            showYourAdverts();
                          },
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1,
                                    color: Color.fromRGBO(32, 50, 57, 0.4)))),
                        child: Column(
                          children: _buildAdvertCardList(),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(32, 50, 57, 0.4)))),
                          child: const Text(
                            ' Documents',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(20, 30, 39, 1.0)),
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Column(
                          children: _buildDocumentCardList(),
                        ),
                      ),
                    ]),
                  ),
          ),
          bottomNavigationBar: const BottomBar()),
    );
  }

  List<Widget> _buildAdvertCardList() {
    if (data.length == 0) {
      return [Text("")];
    }

    List<Widget> list = dataShow
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
                                data3.isNotEmpty &&
                                data3
                                        .firstWhere((element) =>
                                            element.userId == x.tutor)
                                        .profilePicture! !=
                                    ""
                            ? imageFromBase64String(data3
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
                            child: Row(
                              children: [
                                const Text('See profile',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromRGBO(20, 30, 39, 1.0))),
                                const Icon(
                                  Icons.arrow_outward_sharp,
                                  color: Color.fromRGBO(20, 30, 39, 1.0),
                                )
                              ],
                            )),
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
                                if (x.tutor == Authorization.id) {
                                  showAlertDialog(context,
                                      "You can't book your own class!", "");
                                }

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
    if (data2.length == 0) {
      return [Text("")];
    }

    List<Widget> list = data2Show
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
