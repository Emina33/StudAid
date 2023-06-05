import 'package:stud_aid/utils/util.dart';

import '../models/review.dart';
import 'base_provider.dart';

class ReviewProvider extends BaseProvider<Review> {
  ReviewProvider() : super("Review");

  @override
  Review fromJson(data) {
    // TODO: implement fromJson

    return Review.fromJson(data);
  }
}
