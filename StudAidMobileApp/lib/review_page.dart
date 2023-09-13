import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/components/alertDialog.dart';
import 'package:stud_aid/models/review.dart';
import 'package:stud_aid/providers/review_provider.dart';
import 'components/bottom_bar.dart';
import 'components/top_bar.dart';

class ReviewPage extends StatefulWidget {
  int id;
  ReviewPage(this.id, {Key? key}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  double? _ratingValue;
  int? stars = 0;
  ReviewProvider? _reviewProvider = null;
  List<Review> data = [];

  final TextEditingController reviewController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _reviewProvider = context.read<ReviewProvider>();
  }

  bool Validate() {
    if (stars == 0) {
      showAlertDialog(context, "The minimum is one star", "Validation error");
      return false;
    }
    if (reviewController.text == "") {
      showAlertDialog(context, "Fill the review field", "Validation error");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50), child: TopBar()),
          body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 400,
                    margin: const EdgeInsets.all(30),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(32, 50, 57, 0.4)))),
                    child: const Text(
                      'Leave a review',
                      style: TextStyle(
                          fontSize: 25, color: Color.fromRGBO(20, 30, 39, 1.0)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  RatingBar(
                      initialRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                          full: const Icon(Icons.star,
                              color: Color.fromRGBO(20, 30, 39, 1.0)),
                          half: const Icon(
                            Icons.star_half,
                            color: Color.fromRGBO(20, 30, 39, 1.0),
                          ),
                          empty: const Icon(
                            Icons.star_outline,
                            color: Color.fromRGBO(20, 30, 39, 1.0),
                          )),
                      onRatingUpdate: (value) {
                        setState(() {
                          _ratingValue = value;
                          stars = _ratingValue?.round();
                        });
                      }),
                  Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 40, bottom: 30),
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(32, 50, 57, 0.4)))),
                    child: const Text(
                      'How was your experience?',
                      style: TextStyle(
                          fontSize: 20, color: Color.fromRGBO(32, 50, 57, 1)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                      height: 150,
                      width: 300,
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(32, 50, 57, 0.1),
                      ),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: TextField(
                          controller: reviewController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20, top: 60),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (Validate()) {
                          Object review = {
                            "reviewText": reviewController.text,
                            "reviewStars": stars,
                            "reviewer": widget.id,
                          };
                          await _reviewProvider?.insert(review);
                          showAlertDialog(
                              context, "You have left a review", "Success");
                          reviewController.clear();
                          setState(() {
                            _ratingValue = 0.0;
                            stars = 0;
                          });
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          primary: const Color.fromRGBO(20, 30, 39, 1.0),
                          minimumSize: Size(130, 40)),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ]),
          ),
          bottomNavigationBar: const BottomBar()),
    );
  }
}
