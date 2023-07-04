import 'package:stud_aid/providers/base_provider.dart';

import '../models/advert.dart';

class AdvertProvider extends BaseProvider<Advert> {
  AdvertProvider() : super("Advert");

  @override
  Advert fromJson(data) {
    return Advert.fromJson(data);
  }
}
