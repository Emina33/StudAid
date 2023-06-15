import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/models/advert.dart';
import 'package:stud_aid/models/reservation.dart';
import 'package:stud_aid/providers/advert_provider.dart';
import 'package:stud_aid/providers/reservation_provider.dart';
import 'package:stud_aid/review_page.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:stud_aid/utils/util.dart';
import 'components/alertDialog.dart';
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
  ReservationProvider? _reservationProvider = null;
  Reservation? reservation = null;
  String? selectedTime = 'unselected';
  @override
  @override
  void initState() {
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

  Future changeAvailableTime(int id) async {
    String? newTime = advert!.availableTime != null &&
            advert!.availableTime!.lastIndexOf(',') ==
                (advert!.availableTime!.length - 1)
        ? advert!.availableTime?.replaceAll("$selectedTime,", "")
        : advert!.availableTime?.replaceAll("$selectedTime", "");
    if (advert != null) {
      Object advertNew = {
        "advertName": advert!.advertName,
        "availableTime": newTime,
        "price": advert!.price,
        "tutor": advert!.tutor,
        "subjectId": advert!.subjectId,
        "date": 1
      };
      await _advertProvider?.update(id, advertNew);
    }
  }

  bool Validate() {
    if (selectedTime == "unselected") {
      showAlertDialog(context, "Please select a time", "Warning");
      return false;
    }
    return true;
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
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
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
                    margin: const EdgeInsets.only(top: 30),
                    child: selectedTime == "unselected"
                        ? const Text(
                            'Click a time to select',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Color.fromRGBO(20, 30, 39, 1.0)),
                          )
                        : Text(
                            'Selected time: $selectedTime',
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Color.fromRGBO(20, 30, 39, 1.0)),
                          ),
                  ),
                  Container(
                    width: 270,
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          reservation?.advertId = widget.id;
                          reservation?.userId = 2;
                          reservation?.selectedTime = selectedTime;
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UsePaypal(
                                  sandboxMode: true,
                                  clientId:
                                      "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
                                  secretKey:
                                      "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
                                  returnURL: "https://samplesite.com/return",
                                  cancelURL: "https://samplesite.com/cancel",
                                  transactions: const [
                                    {
                                      "amount": {
                                        "total": '10.00',
                                        "currency": "USD",
                                        "details": {
                                          "subtotal": '10.00',
                                          "shipping": '0',
                                          "shipping_discount": 0
                                        }
                                      },
                                      "description":
                                          "The payment transaction description.",
                                      // "payment_options": {
                                      //   "allowed_payment_method":
                                      //       "INSTANT_FUNDING_SOURCE"
                                      // },
                                      "item_list": {
                                        "items": [
                                          {
                                            "name": "A tutoring session",
                                            "quantity": 1,
                                            "price": '10.00',
                                            "currency": "USD"
                                          }
                                        ],

                                        // shipping address is not required though
                                        "shipping_address": {
                                          "recipient_name": "Jane Foster",
                                          "line1": "Travis County",
                                          "line2": "",
                                          "city": "Austin",
                                          "country_code": "US",
                                          "postal_code": "73301",
                                          "phone": "+00000000",
                                          "state": "Texas"
                                        },
                                      }
                                    }
                                  ],
                                  note:
                                      "Contact us for any questions on your order.",
                                  onSuccess: (Map params) async {
                                    print("onSuccess: $params");
                                    if (selectedTime != "unselected") {
                                      setState(() {
                                        reservation?.advertId = widget.id;
                                        reservation?.userId = 2;
                                        reservation?.selectedTime =
                                            selectedTime;
                                      });
                                      Object reservation2 = {
                                        "advertId": widget.id,
                                        "userId": Authorization.id,
                                        "selectedTime": selectedTime
                                      };

                                      await _reservationProvider
                                          ?.insert(reservation2);
                                      showAlertDialog(
                                          context,
                                          "You have successfully made a reservation!",
                                          "Success");
                                      changeAvailableTime(widget.id);
                                    }
                                  },
                                  onError: (error) {
                                    print("onError: $error");
                                  },
                                  onCancel: (params) {
                                    print('cancelled: $params');
                                  })),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          primary: const Color.fromRGBO(20, 30, 39, 1.0),
                          minimumSize: Size(170, 45)),
                      child: Text(
                        'Confirm and pay now',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    width: 270,
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (selectedTime != "unselected") {
                          setState(() {
                            reservation?.advertId = widget.id;
                            reservation?.userId = 2;
                            reservation?.selectedTime = selectedTime;
                          });
                          Object reservation2 = {
                            "advertId": widget.id,
                            "userId": Authorization.id,
                            "selectedTime": selectedTime
                          };

                          await _reservationProvider?.insert(reservation2);
                          showAlertDialog(
                              context,
                              "You have successfully made a reservation!",
                              "Success");
                          changeAvailableTime(widget.id);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          primary: const Color.fromRGBO(20, 30, 39, 1.0),
                          minimumSize: Size(170, 45)),
                      child: Text(
                        'Confirm and pay later',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ]),
          bottomNavigationBar: const BottomBar()),
    );
  }

  List<Widget> _buildAvailableTime(Advert? item) {
    if (item == null) {
      return [Text("")];
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
