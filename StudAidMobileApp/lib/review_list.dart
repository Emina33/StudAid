import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/components/loadingScreen.dart';
import 'package:stud_aid/providers/advert_provider.dart';
import 'package:stud_aid/providers/reservation_provider.dart';
import 'package:stud_aid/providers/user_provider.dart';
import 'package:stud_aid/review_page.dart';
import 'package:stud_aid/utils/util.dart';

import 'components/bottom_bar.dart';
import 'components/top_bar.dart';
import 'models/advert.dart';
import 'models/reservation.dart';
import 'models/user.dart';

class ReviewList extends StatefulWidget {
  const ReviewList({super.key});

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  UserProvider? userProvider = null;
  List<User> users = [];
  bool loading = true;
  @override
  void initState() {
    userProvider = context.read<UserProvider>();

    loadData();
  }

  Future loadData() async {
    var tmpData = await userProvider?.get(null);
    if (mounted && tmpData != null) {
      setState(() {
        users = tmpData;
      });
    }
    setState(() {
      loading = false;
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
          body: loading
              ? LoadingScreen()
              : SingleChildScrollView(
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
                          'Users',
                          style: TextStyle(
                              fontSize: 25,
                              color: Color.fromRGBO(20, 30, 39, 1.0)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Column(
                        children: _buildUsersCardList(),
                      )
                    ],
                  ),
                ),
          bottomNavigationBar: const BottomBar()),
    );
  }

  List<Widget> _buildUsersCardList() {
    if (users.length == 0) {
      return [Text("")];
    }

    List<Widget> list = users
        .map((x) => x.userId != Authorization.id
            ? InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReviewPage(x.userId!)),
                  );
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(32, 50, 57, 0.1),
                    ),
                    height: 80,
                    width: 330,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          child: x.profilePicture != ""
                              ? imageFromBase64String(x.profilePicture!)
                              : Image.asset('images/blueFullBetter.png'),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ReviewPage(x.userId!)),
                                  );
                                },
                                child: Text(
                                  "Review ${x.firstName} ${x.lastName}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(20, 30, 39, 1.0)),
                                )))
                      ],
                    )),
              )
            : Text(''))
        .cast<Widget>()
        .toList();

    return list;
  }
}
