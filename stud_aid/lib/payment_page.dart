import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/bottom_bar.dart';
import 'components/top_bar.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50), child: TopBar()),
          body: Container(
            color: const Color.fromRGBO(32, 50, 57, 0.1),
            padding: EdgeInsets.only(left: 30, right: 30),
            margin: EdgeInsets.only(top: 60, bottom: 60),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 30, top: 0),
                        child: const Text('Payment',
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromRGBO(1, 1, 1, 1))),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.credit_card),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: const Text('Credit/Debit',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(1, 1, 1, 1))),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30, bottom: 30),
                    child: const SizedBox(
                      width: 500,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.credit_card),
                          border: UnderlineInputBorder(),
                          labelText: 'Card number',
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: TextField(
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Expiration date',
                              isDense: true,
                              contentPadding: EdgeInsets.all(8)),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: TextField(
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'CVC',
                              isDense: true,
                              contentPadding: EdgeInsets.all(8)),
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20, top: 60),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          primary: const Color.fromRGBO(20, 30, 39, 1.0),
                          minimumSize: Size(130, 40)),
                      child: const Text(
                        'Pay now',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 200),
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Pay later',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(20, 30, 39, 1.0)),
                        )),
                  ),
                ]),
          ),
          bottomNavigationBar: const BottomBar()),
    );
  }
}
