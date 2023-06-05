import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/home_page.dart';
import 'package:stud_aid/models/advert.dart';
import 'package:stud_aid/models/reservation.dart';
import 'package:stud_aid/payment_page.dart';
import 'package:stud_aid/providers/advert_provider.dart';
import 'package:stud_aid/providers/reservation_provider.dart';
import 'package:stud_aid/review_page.dart';

import 'advertDetails.dart';
import 'components/bottom_bar.dart';
import 'components/top_bar.dart';

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
  late ReservationProvider _reservationProvider;
  late Reservation? reservation = null;
  String? selectedTime = 'unselected';
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _advertProvider = context.read<AdvertProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _advertProvider?.get(null);
    setState(() {
      advert = tmpData!.firstWhere((element) => element.advertId == widget.id);
    });
  }

  Future insertData() async {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50), child: TopBar()),
          body:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
                    onPressed: () /*async*/ {
                      setState(() {
                        reservation?.advertId = widget.id;
                        reservation?.userId = 2;
                        reservation?.selectedTime = selectedTime;
                      });
                      Object reservation2 = {
                        "advertId": widget.id,
                        "userId": 2,
                        "selectedTime": selectedTime
                      };
                      //await _reservationProvider.insert(reservation2);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaymentPage()),
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
          bottomNavigationBar: const BottomBar()),
    );
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
