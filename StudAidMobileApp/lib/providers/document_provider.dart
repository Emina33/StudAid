import 'package:stud_aid/providers/base_provider.dart';

import '../models/document.dart';

class DocumentProvider extends BaseProvider<Document> {
  DocumentProvider() : super("Document");

  @override
  Document fromJson(data) {
    return Document.fromJson(data);
  }
}
