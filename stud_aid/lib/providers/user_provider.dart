import 'package:stud_aid/utils/util.dart';

import '../models/user.dart';
import 'base_provider.dart';

class UserProvider extends BaseProvider<User> {
  UserProvider() : super("AppUser");

  @override
  User fromJson(data) {
    // TODO: implement fromJson

    return User.fromJson(data);
  }
}
