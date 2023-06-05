import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stud_aid/components/top_bar.dart';
import 'package:stud_aid/document_page_ful.dart';
import 'package:stud_aid/my_profile_page_ful.dart';
import 'package:stud_aid/providers/advert_provider.dart';
import 'package:stud_aid/providers/document_provider.dart';
import 'package:stud_aid/providers/user_provider.dart';
import 'package:stud_aid/register.dart';
import 'package:stud_aid/search_page.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/search_page_ful.dart';
//import 'components/advert.dart';
import 'advertDetails.dart';
import 'advert_details_ful.dart';
import 'components/bottom_bar.dart';
import 'document_page.dart';
import 'models/document.dart';
import 'main.dart';
import 'models/advert.dart';
import 'models/user.dart';
import 'profile_page.dart';
import 'utils/util.dart';

class HomePageNew extends StatefulWidget {
  static const String routeName = "/advert";
  const HomePageNew({super.key});

  @override
  State<HomePageNew> createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  AdvertProvider? _advertProvider = null;
  UserProvider? _userProvider = null;
  DocumentProvider? _documentProvider = null;
  List<Advert> data = [];
  List<Document> data2 = [];
  List<User> data3 = [];
  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _advertProvider = context.read<AdvertProvider>();
    _documentProvider = context.read<DocumentProvider>();
    _userProvider = context.read<UserProvider>();
    loadData();
    loadData2();
    loadData3();
  }

  Future loadData() async {
    var tmpData = await _advertProvider?.get(null);
    setState(() {
      data = tmpData!;
    });
  }

  Future loadData2() async {
    var tmpData = await _documentProvider?.get(null);
    setState(() {
      data2 = tmpData!;
    });
  }

  Future loadData3() async {
    var tmpData = await _userProvider?.get(null);
    setState(() {
      data3 = tmpData!;
    });
    Authorization.id = data3
        .firstWhere((element) => element.username == Authorization.username)
        .userId;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50), child: TopBar()),
          // appBar: AppBar(
          //   backgroundColor: const Color.fromRGBO(20, 30, 39, 1.0),
          //   leading: Image.asset(
          //     'images/whiteHalfBetter.png',
          //   ),
          //   actions: [
          //     TextButton(
          //         onPressed: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => const RootPage()),
          //           );
          //         },
          //         child: Text('Log in',
          //             style: TextStyle(
          //                 fontSize: 18,
          //                 color: Color.fromRGBO(238, 237, 222, 1.0)))),
          //     TextButton(
          //         onPressed: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => const RegisterPage()),
          //           );
          //         },
          //         child: const Text('Sign up',
          //             style: TextStyle(
          //                 fontSize: 18,
          //                 color: Color.fromRGBO(238, 237, 222, 1.0))))
          //   ],
          // ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: TextField(
                          controller: _searchController,
                          onSubmitted: (value) async {
                            var tmpData = await _advertProvider
                                ?.get({'advertname': value});
                            setState(() {
                              data = tmpData!;
                            });
                            _searchController.clear();
                          },
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(20, 30, 39, 1.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(20, 30, 39, 1.0)),
                              ),
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search),
                              iconColor: Color.fromRGBO(20, 30, 39, 1.0),
                              prefixIconColor: Color.fromRGBO(20, 30, 39, 1.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: IconButton(
                        icon: Icon(Icons.filter_list),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchPage2()),
                          );
                        },
                      ),
                    )
                  ],
                ),
                /* Container(
                  height: 40,
                  width: 420,
                  margin: const EdgeInsets.only(right: 30.0, left: 30.0, top: 30),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1, color: Color.fromRGBO(32, 50, 57, 0.4)))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SearchPage()),
                            );
                          },
                          child: const Text('Search',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(32, 50, 57, 0.4)))),
                      TextButton(
                          onPressed: () {},
                          child: const Text('Filter',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(32, 50, 57, 0.4))))
                    ],
                  ),
                ), */

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
      return [Text("Loading...")];
    }

    List<Widget> list = data
        .map((x) => InkWell(
              onTap: () {
                var pic = data3.firstWhere(
                    (element) => element.userId == x.tutor,
                    orElse: () => new User());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdvertDetailsFul(x.advertId!)),
                );
              },
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
                        child: x.tutor != null && data3.isNotEmpty
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const BookPage()),
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
      return [Text("Loading...")];
    }

    List<Widget> list = data2
        .map((x) => InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DocumentPage2(x.documentId!)),
                );
              },
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
                                              const DocumentPage()),
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
