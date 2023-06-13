import 'package:stud_aid/utils/util.dart';

import '../models/location.dart';
import 'base_provider.dart';

class LocationProvider extends BaseProvider<Location> {
  LocationProvider() : super("Location");

  @override
  Location fromJson(data) {
    // TODO: implement fromJson

    return Location.fromJson(data);
  }
}
