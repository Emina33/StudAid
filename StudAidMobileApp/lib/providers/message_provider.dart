import 'package:stud_aid/providers/base_provider.dart';

import '../models/message.dart';

class MessageProvider extends BaseProvider<Message> {
  MessageProvider() : super("Message");

  @override
  Message fromJson(data) {
    return Message.fromJson(data);
  }
}
