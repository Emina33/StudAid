import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:provider/provider.dart';
import 'package:stud_aid/providers/message_provider.dart';
import 'package:stud_aid/providers/user_provider.dart';
import 'package:stud_aid/utils/util.dart';
import 'components/bottom_bar.dart';
import 'components/top_bar.dart';
import 'models/user.dart';
import 'models/message.dart' as model;
import 'package:bubble/bubble.dart';
import 'package:http/http.dart' as http;

class ChatPage2 extends StatefulWidget {
  const ChatPage2({super.key});

  @override
  State<ChatPage2> createState() => _ChatPage2State();
}

class _ChatPage2State extends State<ChatPage2> {
  final userId = Authorization.id;

  List<types.Message> _messages = [];

  MessageProvider? _messageProvider = null;
  List<model.Message> data = [];
  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
    print(_messages);
  }

  int _page = 0;
  // Future<void> _handleEndReached() async {
  //   final uri = Uri.parse(
  //     'https://api.instantwebtools.net/v1/passenger?page=$_page&size=20',
  //   );
  //   final response = await http.get(uri);
  //   final json = jsonDecode(response.body) as Map<String, dynamic>;
  //   final data = json['data'] as List<dynamic>;
  //   final messages = data
  //       .map(
  //         (e) => types.TextMessage(
  //           author: _user,
  //           id: e['_id'] as String,
  //           text: e['name'] as String,
  //         ),
  //       )
  //       .toList();
  //   setState(() {
  //     _messages = [..._messages, ...messages];
  //     _page = _page + 1;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messageProvider = context.read<MessageProvider>();
    loadData();
    // _handleEndReached();
  }

  Future loadData2() async {
    var tmpData = await _messageProvider?.get(null);

    setState(() {
      data = tmpData!;
    });
    //
    // for (var i = data.length - 1; i >= 0; i--) {
    //   _addMessage(types.TextMessage(
    //       author: types.User(id: data[i].sender.toString()),
    //       text: data[i].content.toString(),
    //       id: _user.id));
    // }
    //
    // setState(() {
    //
    // });
  }

  Future loadData() async {
    await loadData2();
    List<types.TextMessage> list = [];
    if (data != null) {
      for (var i = data.length - 1; i >= 0; i--) {
        types.TextMessage temp = new types.TextMessage(
            author: types.User(id: data[i].sender.toString()),
            id: _user.id,
            text: data[i].content.toString());
        list.add(temp);
      }
    }
    setState(() {
      _messages = list;
    });
  }

  // void onSendTap(String message, ReplyMessage replyMessage, MessageType type) {
  //   chatController.addMessage(
  //     Message(
  //       id: 4
  //           .toString(), // This can be the next message-id if you need to add according to your usecase
  //       createdAt: DateTime.now(),
  //       message: message,
  //       sendBy: 1.toString(),
  //       replyMessage: replyMessage,
  //     ),
  //   );
  // }

  final _user = types.User(
    id: Authorization.id.toString(),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50), child: TopBar()),
          body: Chat(
              bubbleBuilder: _bubbleBuilder,
              messages: _messages,
              user: _user,
              onSendPressed: _handleSendPressed,
              scrollToUnreadOptions: const ScrollToUnreadOptions(
                lastReadMessageId: 'lastReadMessageId',
                scrollOnOpen: true,
              )),
          // body: ChatView(
          //   currentUser: ChatUser(id: '1', name: 'Flutter'),
          //   chatController: chatController,
          //   chatViewState: ChatViewState.hasMessages,
          //   onSendTap: onSendTap,
          // ),
          bottomNavigationBar: const BottomBar()),
    );
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: _user.id,
      text: message.text,
    );

    _addMessage(textMessage);
  }

  Widget _bubbleBuilder(
    Widget child, {
    required message,
    required nextMessageInGroup,
  }) =>
      Bubble(
        child: child,
        color: _user.id != message.author.id ||
                message.type == types.MessageType.image
            ? const Color(0xfff5f5f7)
            : Color.fromRGBO(20, 30, 39, 1.0),
        margin: nextMessageInGroup
            ? const BubbleEdges.symmetric(horizontal: 6)
            : null,
        nip: nextMessageInGroup
            ? BubbleNip.no
            : _user.id != message.author.id
                ? BubbleNip.leftBottom
                : BubbleNip.rightBottom,
      );
}
