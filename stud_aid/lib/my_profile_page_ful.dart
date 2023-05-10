import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/models/user.dart';
import 'package:stud_aid/providers/advert_provider.dart';
import 'package:stud_aid/providers/user_provider.dart';
import 'package:stud_aid/upload_file.dart';

import 'advertDetails.dart';
import 'advert_details_ful.dart';
import 'models/advert.dart';
import 'components/bottom_bar.dart';
import 'offer_class.dart';

class MyProfilePage2 extends StatefulWidget {
  int? id;
  MyProfilePage2(this.id, {Key? key}) : super(key: key);

  @override
  State<MyProfilePage2> createState() => _MyProfilePage2State();
}

class _MyProfilePage2State extends State<MyProfilePage2> {
  AdvertProvider? _advertProvider = null;
  List<Advert> data = [];
  UserProvider? _userProvider = null;
  User? user = null;
  @override
  void initState() {
    // TODO: implement initState
    _userProvider = context.read<UserProvider>();
    _advertProvider = context.read<AdvertProvider>();
    loadData();
    loadData2();
  }

  Future loadData() async {
    var tmpData = await _userProvider?.get(null);
    setState(() {
      user = tmpData?.firstWhere((element) => element.userId == widget.id,
          orElse: () => new User());
    });
  }

  Future loadData2() async {
    var tmpData = await _advertProvider?.get(null);
    setState(() {
      data = tmpData!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(20, 30, 39, 1.0),
          leading: Image.asset(
            'images/whiteHalfBetter.png',
          ),
          actions: [
            TextButton(
                onPressed: () {},
                child: const Text('Log in',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(238, 237, 222, 1.0)))),
            TextButton(
                onPressed: () {},
                child: const Text('Sign up',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(238, 237, 222, 1.0))))
          ],
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: TextButton(
                  onPressed: () {},
                  child: const Text('Edit profile',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(32, 50, 57, 0.4)))),
            ),
            Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.only(top: 10),
              child: Image.asset('images/blueFullBetter.png'),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                "${user?.firstName == null ? "" : user?.firstName} ${user?.lastName == null ? "" : user?.lastName}",
                style: TextStyle(
                    fontSize: 25, color: Color.fromRGBO(20, 30, 39, 1.0)),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              child: const Text('About',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromRGBO(32, 50, 57, 0.8))),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30),
              child: Text(
                  "${user?.description == null ? "" : user?.description}",
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(32, 50, 57, 0.8))),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: Color.fromRGBO(32, 50, 57, 0.8)))),
              child: const Text('Offered classes',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromRGBO(32, 50, 57, 0.8))),
            ),
            Container(
              margin: const EdgeInsets.only(right: 30, left: 30, bottom: 20),
              child: Column(
                children: _buildAdvertCardList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30, bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OfferClassPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        primary: const Color.fromRGBO(20, 30, 39, 1.0),
                        minimumSize: Size(130, 40)),
                    child: const Text(
                      'Offer class',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 30, bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UploadFilePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        primary: const Color.fromRGBO(20, 30, 39, 1.0),
                        minimumSize: Size(130, 40)),
                    child: const Text(
                      'Upload file',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
        bottomNavigationBar: const BottomBar());
  }

  List<Widget> _buildAdvertCardList() {
    if (data.length == 0) {
      return [Text("Loading...")];
    }

    List<Widget> list = data
        .map((x) => (x.tutor == widget.id
            ? InkWell(
                onTap: () {
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
                  padding: const EdgeInsets.all(10),
                  child: Row(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 110,
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: Image.asset(
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
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 10),
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
              )
            : null))
        .cast<Widget>()
        .toList();

    return list;
  }
}
