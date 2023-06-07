import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/providers/message_provider.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:stud_aid/utils/util.dart';
import 'components/bottom_bar.dart';
import 'components/top_bar.dart';
import 'models/message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatPage3 extends StatefulWidget {
  const ChatPage3({super.key});

  @override
  State<ChatPage3> createState() => _ChatPage3State();
}

class _ChatPage3State extends State<ChatPage3> {
  MessageProvider? _messageProvider = null;
  List<Message> data = [];
  List<String> strings = [];
  final TextEditingController messageController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    _messageProvider = context.read<MessageProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _messageProvider?.get(null);
    setState(() {
      data = tmpData!.reversed.toList();
    });
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
                "Naslov",
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
                                color:
                                    const Color.fromRGBO(238, 237, 222, 1.0)),
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
                                  color:
                                      const Color.fromRGBO(20, 30, 39, 1.0))),
                        ));
                //           ?
                // return Card(
                //   elevation: 8,
                //   child: Padding(
                //     padding: const EdgeInsets.all(12),
                //     child: Align(
                //       alignment: data[index].sender == Authorization.id
                //           ? Alignment.centerRight
                //           : Alignment.centerLeft,
                //       child: Text(data[index].content!),
                //     ),
                //   ),
                // );
              },
            )),
            Container(
              child: TextField(
                controller: messageController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: "Type your message"),
                onSubmitted: (text) async {
                  if (text.isNotEmpty) {
                    _channel.sink.add(text);
                    Object objectMessage = {
                      "content": text,
                      "sender": 2,
                      "receiver": 1
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
