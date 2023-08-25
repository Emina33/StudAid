import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/providers/message_provider.dart';
import 'package:stud_aid/providers/user_provider.dart';
import 'package:stud_aid/utils/util.dart';
import 'components/bottom_bar.dart';
import 'components/top_bar.dart';
import 'models/message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'models/user.dart';

class ChatPage3 extends StatefulWidget {
  int id;
  String fullName;
  ChatPage3(this.id, this.fullName, {Key? key}) : super(key: key);

  @override
  State<ChatPage3> createState() => _ChatPage3State();
}

class _ChatPage3State extends State<ChatPage3> {
  MessageProvider? _messageProvider = null;
  List<Message> data = [];
  UserProvider? _userProvider = null;
  List<User> data2 = [];
  List<String> strings = [];
  late User receiver;
  final TextEditingController messageController = new TextEditingController();
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
      setState(() {
        data = tmpData.reversed
            .where((element) =>
                (element.receiver == Authorization.id ||
                    element.sender == Authorization.id) &&
                (element.receiver == widget.id || element.sender == widget.id))
            .toList();
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
  }

  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50), child: TopBar()),
          body: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                widget.fullName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Expanded(
                child: ListView.builder(
              reverse: true,
              itemCount: data.length,
              itemBuilder: (context, int index) {
                return data[index].sender == Authorization.id
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(20, 30, 39, 1.0),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * .5),
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(
                              bottom: 5, right: 10, top: 5),
                          alignment: Alignment.centerRight,
                          child: Text(
                            data[index].content!,
                            style: TextStyle(
                                fontSize: 17,
                                color: const Color.fromRGBO(238, 237, 222, 1.0),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                  color: const Color.fromRGBO(20, 30, 39, 1.0)),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * .5),
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(
                              bottom: 5, left: 10, top: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(data[index].content!,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: const Color.fromRGBO(20, 30, 39, 1.0),
                                  fontWeight: FontWeight.w500)),
                        ));
              },
            )),
            Container(
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(20, 30, 39, 1.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(20, 30, 39, 1.0)),
                  ),
                  labelStyle: TextStyle(color: Color.fromRGBO(20, 30, 39, 1.0)),
                  border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.all(15),
                  hintText: "Type your message",
                  suffixIcon: InkWell(
                      onTap: () async {
                        if (messageController.text.isNotEmpty) {
                          _channel.sink.add(messageController.text);
                          Object objectMessage = {
                            "content": messageController.text,
                            "sender": Authorization.id,
                            "receiver": widget.id
                          };
                          await _messageProvider?.insert(objectMessage);
                          messageController.clear();
                        }
                      },
                      child: Icon(Icons.send_rounded)),
                  iconColor: Color.fromRGBO(20, 30, 39, 1.0),
                  suffixIconColor: Color.fromRGBO(20, 30, 39, 1.0),
                ),
                onSubmitted: (text) async {
                  if (text.isNotEmpty) {
                    _channel.sink.add(text);
                    Object objectMessage = {
                      "content": text,
                      "sender": Authorization.id,
                      "receiver": widget.id
                    };
                    await _messageProvider?.insert(objectMessage);
                    messageController.clear();
                  }
                },
              ),
            ),
            StreamBuilder(builder: (context, snapshot) {
              loadData();
              return Text(snapshot.hasData ? '' : '');
            })
          ]),
          bottomNavigationBar: const BottomBar()),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
