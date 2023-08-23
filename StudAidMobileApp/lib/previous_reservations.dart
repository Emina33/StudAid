import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/advert_details_ful.dart';
import 'package:stud_aid/providers/advert_provider.dart';
import 'package:stud_aid/providers/reservation_provider.dart';
import 'package:stud_aid/utils/util.dart';

import 'components/bottom_bar.dart';
import 'components/loadingScreen.dart';
import 'components/top_bar.dart';
import 'models/advert.dart';
import 'models/reservation.dart';

class PreviousReservations extends StatefulWidget {
  const PreviousReservations({super.key});

  @override
  State<PreviousReservations> createState() => _PreviousReservationsState();
}

class _PreviousReservationsState extends State<PreviousReservations> {
  bool loading = true;
  AdvertProvider? _advertProvider = null;
  List<Advert> data = [];
  ReservationProvider? _reservationProvider = null;
  List<Reservation> data3 = [];
  List<int> reservationIds = [];
  @override
  void initState() {
    super.initState();

    _advertProvider = context.read<AdvertProvider>();
    _reservationProvider = context.read<ReservationProvider>();
    loadData();
    loadData3();
  }

  Future loadData() async {
    var tmpData = await _advertProvider?.get(null);
    if (mounted && tmpData != null) {
      setState(() {
        data = tmpData;
      });
    }
    setState(() {
      loading = false;
    });
  }

  Future loadData3() async {
    var tmpData = await _reservationProvider?.get(null);
    if (mounted && tmpData != null) {
      setState(() {
        data3 = tmpData
            .where((element) => element.userId == Authorization.id)
            .toList();
        reservationIds = data3.map((e) => e.advertId!).toList();
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
                        margin:
                            const EdgeInsets.only(top: 30, right: 30, left: 30),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color: Color.fromRGBO(32, 50, 57, 0.4)))),
                        child: const Text(
                          'Previous reservations',
                          style: TextStyle(
                              fontSize: 25,
                              color: Color.fromRGBO(20, 30, 39, 1.0)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Column(
                        children: _buildChatCardList(),
                      )
                    ],
                  ),
                ),
          bottomNavigationBar: const BottomBar()),
    );
  }

  List<Widget> _buildChatCardList() {
    if (data.length == 0) {
      return [Text("")];
    }

    List<Widget> list = data3
        .map((x) => reservationIds.contains(x.advertId)
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
                    height: 80,
                    width: 330,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Reserved ${data.where((element) => element.advertId == x.advertId).first.advertName} at ${x.selectedTime}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(20, 30, 39, 1.0)),
                              textAlign: TextAlign.center,
                            ))
                      ],
                    )),
              )
            : Text(''))
        .cast<Widget>()
        .toList();

    return list;
  }
}
