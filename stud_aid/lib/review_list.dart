import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/bottom_bar.dart';
import 'components/top_bar.dart';

class ReviewList extends StatefulWidget {
  const ReviewList({super.key});

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50), child: TopBar()),
          body: SingleChildScrollView(
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
                    'Chats',
                    style: TextStyle(
                        fontSize: 25, color: Color.fromRGBO(20, 30, 39, 1.0)),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Column(
                //   children: _buildChatCardList(),
                // )
              ],
            ),
          ),
          bottomNavigationBar: const BottomBar()),
    );
  }
}
