import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/chat3.dart';
import 'package:stud_aid/components/loadingScreen.dart';
import 'package:stud_aid/providers/message_provider.dart';
import 'package:stud_aid/providers/user_provider.dart';
import 'package:stud_aid/utils/util.dart';

import 'components/bottom_bar.dart';
import 'components/top_bar.dart';
import 'models/message.dart';
import 'models/user.dart';

class ChatList2 extends StatefulWidget {
  const ChatList2({super.key});

  @override
  State<ChatList2> createState() => _ChatList2State();
}

class _ChatList2State extends State<ChatList2> {
  MessageProvider? _messageProvider = null;
  List<Message> data = [];
  UserProvider? _userProvider = null;
  List<User> data2 = [];
  List<int> all = [];
  List<User> unique = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();

    _messageProvider = context.read<MessageProvider>();
    _userProvider = context.read<UserProvider>();
    loadData();
    loadData2();
  }

  Future loadData() async {
    var tmpData = await _messageProvider?.get(null);
    if (mounted && tmpData != null) {
      for (var i = 0; i < tmpData.length; i++) {
        if (tmpData[i].sender == Authorization.id ||
            tmpData[i].receiver == Authorization.id) {
          if (!all.contains(tmpData[i].sender!) &&
              tmpData[i].sender! != Authorization.id) {
            all.add(tmpData[i].sender!);
          }
          if (!all.contains(tmpData[i].receiver!) &&
              tmpData[i].receiver! != Authorization.id) {
            all.add(tmpData[i].receiver!);
          }
        }
      }
      setState(() {
        data = tmpData.reversed.toList();
      });
    }
  }

  Future loadData2() async {
    var tmpData = await _userProvider?.get(null);
    if (mounted && tmpData != null) {
      setState(() {
        data2 = tmpData;
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
                          'Chats',
                          style: TextStyle(
                              fontSize: 25,
                              color: Color.fromRGBO(20, 30, 39, 1.0)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: _buildChatCardList(),
                      )
                    ],
                  ),
                ),
          bottomNavigationBar: const BottomBar()),
    );
  }

  List<Widget> _buildChatCardList() {
    if (data2.length == 0) {
      return [Text("")];
    }

    List<Widget> list = data2
        .map((x) => all.contains(x.userId)
            ? InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatPage3(
                            x.userId!, "${x.firstName} ${x.lastName}")),
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
                                        builder: (context) => ChatPage3(
                                            x.userId!,
                                            "${x.firstName} ${x.lastName}")),
                                  );
                                },
                                child: Text(
                                  "${x.firstName} ${x.lastName}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(20, 30, 39, 1.0)),
                                )))
                      ],
                    )),
              )
            : Container(width: 0, height: 0))
        .cast<Widget>()
        .toList();

    return list;
  }
}
