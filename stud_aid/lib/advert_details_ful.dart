import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/home_page.dart';
import 'package:stud_aid/models/advert.dart';
import 'package:stud_aid/providers/advert_provider.dart';

import 'advertDetails.dart';
import 'components/bottom_bar.dart';

class AdvertDetailsFul extends StatefulWidget {
  int id;
  static const String routeName = "/advert";
  AdvertDetailsFul(this.id, {Key? key}) : super(key: key);

  @override
  State<AdvertDetailsFul> createState() => _AdvertDetailsFulState();
}

class _AdvertDetailsFulState extends State<AdvertDetailsFul> {
  AdvertProvider? _advertProvider = null;
  Advert? advert = null;
  String? selectedTime = 'unselected';
  @override
  void initState() {
    // TODO: implement initState
    _advertProvider = context.read<AdvertProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _advertProvider?.get(null);
    setState(() {
      advert = tmpData!.firstWhere((element) => element.advertId == widget.id);
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
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              advert?.advertName ?? " ",
              style: TextStyle(
                  fontSize: 25, color: Color.fromRGBO(20, 30, 39, 1.0)),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 500,
            height: 500,
            margin: const EdgeInsets.only(top: 20),
            color: const Color.fromRGBO(32, 50, 57, 0.1),
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: const Text(
                  'Select the time:',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromRGBO(20, 30, 39, 1.0)),
                ),
              ),
              Column(
                children: _buildAvailableTime(advert),
              ),
              Container(
                width: 270,
                margin: const EdgeInsets.only(top: 80),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BookPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: const Color.fromRGBO(20, 30, 39, 1.0),
                      minimumSize: Size(170, 45)),
                  child: Text(
                    'Confirm time : ${selectedTime}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
            ]),
          )
        ]),
        bottomNavigationBar: const BottomBar());
  }

  List<Widget> _buildAvailableTime(Advert? item) {
    if (item == null) {
      return [Text("Loading...")];
    }
    var timetable = item.availableTime!.split(',');
    List<Widget> list = timetable
        .map(
          (e) => TextButton(
            onPressed: () => {
              setState(() {
                selectedTime = e.toString();
              })
            },
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              child: Text(
                e.toString(),
                style: TextStyle(
                    fontSize: 18, color: Color.fromRGBO(20, 30, 39, 1.0)),
              ),
            ),
          ),
        )
        .cast<Widget>()
        .toList();
    return list;
  }
}
