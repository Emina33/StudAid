import 'package:stud_aid/utils/util.dart';

import '../models/subject.dart';
import 'base_provider.dart';

class SubjectProvider extends BaseProvider<Subject> {
  SubjectProvider() : super("Subject");

  @override
  Subject fromJson(data) {
    // TODO: implement fromJson

    return Subject.fromJson(data);
  }
}
