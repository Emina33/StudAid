import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/chat3.dart';
import 'package:stud_aid/components/alertDialog.dart';
import 'package:stud_aid/edit_profile_page.dart';
import 'package:stud_aid/models/user.dart';
import 'package:stud_aid/offer_class_ful.dart';
import 'package:stud_aid/providers/advert_provider.dart';
import 'package:stud_aid/providers/location_provider.dart';
import 'package:stud_aid/providers/reservation_provider.dart';
import 'package:stud_aid/providers/review_provider.dart';
import 'package:stud_aid/providers/user_provider.dart';
import 'package:stud_aid/upload_file_ful.dart';
import 'package:stud_aid/utils/fileStorage.dart';
import 'package:stud_aid/utils/util.dart';

import 'advert_details_ful.dart';
import 'components/loadingScreen.dart';
import 'components/top_bar.dart';
import 'models/advert.dart';
import 'components/bottom_bar.dart';
import 'models/location.dart';
import 'models/reservation.dart';
import 'models/review.dart';
import 'offer_class.dart';

class MyProfilePage2 extends StatefulWidget {
  int? id;
  MyProfilePage2(this.id, {Key? key}) : super(key: key);

  @override
  State<MyProfilePage2> createState() => _MyProfilePage2State();
}

class _MyProfilePage2State extends State<MyProfilePage2> {
  Future<void> generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: <pw.Widget>[
            pw.Text("Report for ${user?.firstName} ${user?.lastName}",
                textScaleFactor: 2,
                style: pw.Theme.of(context)
                    .defaultTextStyle
                    .copyWith(fontWeight: pw.FontWeight.bold)),
            pw.Container(
                padding: pw.EdgeInsets.only(top: 30, bottom: 10),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Container(
                          width: 200,
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text("Student name",
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(fontWeight: pw.FontWeight.bold),
                              textAlign: pw.TextAlign.left)),
                      pw.Container(
                          width: 200,
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text("Advert name",
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(fontWeight: pw.FontWeight.bold),
                              textAlign: pw.TextAlign.left)),
                      pw.Container(
                          width: 200,
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text("Price",
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(fontWeight: pw.FontWeight.bold),
                              textAlign: pw.TextAlign.left)),
                    ])),
            pw.Column(children: _buildTextCardList())
          ]),
        ),
      ),
    );
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
    } else if (status.isGranted) {
      final file = File("/storage/emulated/0/Download/report.pdf");
      await file.writeAsBytes(await pdf.save());
      showAlertDialog(context,
          "You have successfully generated and saved a report.", "Success");
    }
  }

  List<pw.Widget> _buildTextCardList() {
    if (data2.length == 0) {
      return [pw.Text("Loading...")];
    }

    List<pw.Widget> list = data3
        .map((x) => pw.Container(
              padding: pw.EdgeInsets.only(top: 10),
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                        width: 200,
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                            "${data2.firstWhere((element) => x.userId == element.userId).firstName} ${data2.firstWhere((element) => x.userId == element.userId).lastName}",
                            textAlign: pw.TextAlign.left)),
                    pw.Container(
                        width: 200,
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                            "${data.firstWhere((element) => x.advertId == element.advertId).advertName}",
                            textAlign: pw.TextAlign.left)),
                    pw.Container(
                        width: 200,
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                            "${data.firstWhere((element) => x.advertId == element.advertId).price}",
                            textAlign: pw.TextAlign.left)),
                  ]),
            ))
        .cast<pw.Widget>()
        .toList();

    return list;
  }

  File? image;
  bool loading = true;

  Future pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  AdvertProvider? _advertProvider = null;
  ReservationProvider? _reservationProvider = null;
  LocationProvider? _locationProvider = null;
  Location? city = null;
  List<Advert> data = [];
  UserProvider? _userProvider = null;
  List<User> data2 = [];
  ReviewProvider? _reviewProvider = null;
  List<Review> reviews = [];
  List<Reservation> data3 = [];
  List<int> advertIds = [];
  User? user = null;
  @override
  void initState() {
    // TODO: implement initState
    _userProvider = context.read<UserProvider>();
    _advertProvider = context.read<AdvertProvider>();
    _locationProvider = context.read<LocationProvider>();
    _reservationProvider = context.read<ReservationProvider>();
    _reviewProvider = context.read<ReviewProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _userProvider?.get(null);
    setState(() {
      data2 = tmpData!;
      if (widget.id == 0) {
        user = tmpData.firstWhere(
            (element) => element.username == Authorization.username,
            orElse: () => new User());
        Authorization.id = user!.userId;
      } else {
        user = tmpData?.firstWhere((element) => element.userId == widget.id,
            orElse: () => new User());
      }
    });
    loadData2();
    loadData3();
    loadData4();
    loadData5();
  }

  Future loadData2() async {
    var tmpData = await _advertProvider?.get(null);
    setState(() {
      if (tmpData != null && user != null) {
        data =
            tmpData.where((element) => element.tutor == user!.userId).toList();
      }
    });
    for (var i = 0; i < data.length; i++) {
      advertIds.add(data[i].advertId!);
    }
  }

  Future loadData3() async {
    var tmpData = await _locationProvider?.get(null);
    setState(() {
      if (user != null && user?.locationId != null) {
        city = tmpData!
            .firstWhere((element) => element.locationId == user!.locationId);
      }
    });
  }

  Future loadData4() async {
    var tmpData = await _reservationProvider?.get(null);
    setState(() {
      if (tmpData != null && advertIds.length != 0)
        data3 = tmpData
            .where((element) => advertIds.contains(element.advertId))
            .toList();
    });
    setState(() {
      loading = false;
    });
  }

  Future loadData5() async {
    var tmpData = await _reviewProvider?.get(null);
    setState(() {
      if (tmpData != null && user != null) {
        reviews = tmpData
            .where((element) => element.reviewer == user!.userId)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50), child: TopBar()),
          body: loading
              ? const LoadingScreen()
              : SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: user != null &&
                                  Authorization.id == user?.userId
                              ? TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EditProfilePage()),
                                    );
                                  },
                                  child: const Text('Edit profile',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromRGBO(32, 50, 57, 0.4))))
                              : const Text(""),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(top: 10),
                          child: user != null && user?.profilePicture != ''
                              ? imageFromBase64String(user!.profilePicture!)
                              : Image.asset(
                                  'images/blueFullBetter.png',
                                  fit: BoxFit.scaleDown,
                                ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Text(
                            "${user?.firstName == null ? "" : user?.firstName} ${user?.lastName == null ? "" : user?.lastName}",
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromRGBO(20, 30, 39, 1.0)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, top: 30, bottom: 15),
                          child: const Text('About',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(32, 50, 57, 0.8))),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 30, right: 30),
                          child: Text(
                            "${user?.description == null ? "" : user?.description}",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(32, 50, 57, 0.8)),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, top: 10, bottom: 15),
                          child: const Text('Location',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(32, 50, 57, 0.8))),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 30, bottom: 10),
                          child: city != null
                              ? Text("${city!.city}, ${city!.country}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.8)))
                              : Text("No location added",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.8))),
                        ),
                        Container(
                            child: user != null &&
                                    Authorization.id == user?.userId
                                ? Container(
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        right: 30,
                                        left: 30),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(32, 50, 57, 0.1),
                                      border: Border.all(
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: TextButton(
                                        onPressed: () {
                                          generatePdf();
                                        },
                                        child: const Text(
                                            'Generate and download report',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color.fromRGBO(
                                                    32, 50, 57, 1)))))
                                : Container(
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        right: 30,
                                        left: 30),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(32, 50, 57, 0.1),
                                      border: Border.all(
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: TextButton(
                                        onPressed: () {
                                          if (user != null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ChatPage3(
                                                      user!.userId!,
                                                      "${user?.firstName} ${user?.lastName}")),
                                            );
                                          }
                                        },
                                        child: const Text('Start a chat',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color.fromRGBO(
                                                    32, 50, 57, 1)))))),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, top: 10, bottom: 15),
                          child: const Text('Reviews',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(32, 50, 57, 0.8))),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 30, bottom: 10),
                          child: reviews.isNotEmpty
                              ? SingleChildScrollView(
                                  child:
                                      Column(children: _buildReviewCardList()),
                                )
                              : Text("User has no reviews",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(32, 50, 57, 0.8))),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              right: 30, left: 30, bottom: 15, top: 15),
                          padding: const EdgeInsets.only(bottom: 10),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(32, 50, 57, 0.8)))),
                          child: const Text('Offered classes',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(32, 50, 57, 0.8))),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              right: 30, left: 30, bottom: 20),
                          child: Column(
                            children: _buildAdvertCardList(),
                          ),
                        ),
                        Container(
                          child:
                              user != null && Authorization.id == user?.userId
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 30, bottom: 20),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const OfferClassPage2()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                                shape: const StadiumBorder(),
                                                primary: const Color.fromRGBO(
                                                    20, 30, 39, 1.0),
                                                minimumSize: Size(130, 40)),
                                            child: const Text(
                                              'Offer class',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              right: 30, bottom: 20),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const UploadPage2()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                                shape: const StadiumBorder(),
                                                primary: const Color.fromRGBO(
                                                    20, 30, 39, 1.0),
                                                minimumSize: Size(130, 40)),
                                            child: const Text(
                                              'Upload file',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const Text(""),
                        )
                      ]),
                ),
          bottomNavigationBar: const BottomBar()),
    );
  }

  List<Widget> _buildAdvertCardList() {
    if (data.length == 0) {
      return [Text("")];
    }
    List<Widget> list = [];
    if (user != null) {
      list = data
          .map((x) => (x.tutor == user!.userId
              ? InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdvertDetailsFul(x.advertId!)),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(32, 50, 57, 0.1),
                    ),
                    height: 220,
                    width: 330,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 110,
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            child: user != null && user?.profilePicture != ''
                                ? imageFromBase64String(user!.profilePicture!)
                                : Image.asset(
                                    'images/blueFullBetter.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                          ),
                          Container(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MyProfilePage2(x.tutor!)),
                                  );
                                },
                                child: const Text('See profile',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromRGBO(20, 30, 39, 1.0)))),
                          ),
                        ],
                      ),
                      Container(
                          width: 170,
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(bottom: 10, top: 10),
                                child: Text(x.advertName!,
                                    style: TextStyle(
                                        fontSize: 23,
                                        color:
                                            Color.fromRGBO(20, 30, 39, 1.0))),
                              ),
                              Text('Price: ${x.price!}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(20, 30, 39, 1.0))),
                              Container(
                                padding: const EdgeInsets.only(top: 50),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (x.tutor == Authorization.id) {
                                      showAlertDialog(
                                          context,
                                          "You can't book your own class!",
                                          "Warning");
                                    }
                                    // var pic = data3.firstWhere(
                                    //     (element) => element.userId == x.tutor,
                                    //     orElse: () => new User());
                                    if (x.tutor != Authorization.id)
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdvertDetailsFul(x.advertId!)),
                                      );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      primary:
                                          const Color.fromRGBO(20, 30, 39, 1.0),
                                      minimumSize: Size(90, 40)),
                                  child: const Text(
                                    'Book',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ]),
                  ),
                )
              : Container(
                  height: 0,
                  width: 0,
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: const Text(""))))
          .cast<Widget>()
          .toList();
    }

    if (user == null) {
      list = data
          .map((e) => Container(
                child: Text(""),
              ))
          .cast<Widget>()
          .toList();
    }
    return list;
  }

  List<Widget> _buildReviewCardList() {
    if (data.length == 0) {
      return [Text("")];
    }
    List<Widget> list = [];
    if (user != null) {
      list = reviews
          .map((x) => Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${x.reviewStars} stars     ",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Color.fromRGBO(32, 50, 57, 0.8)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 130,
                      child: Text(
                        "Review: ${x.reviewText}",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(32, 50, 57, 0.8)),
                      ),
                    ),
                  ],
                ),
              ))
          .cast<Widget>()
          .toList();
    }

    if (user == null) {
      list = data
          .map((e) => Container(
                child: Text(""),
              ))
          .cast<Widget>()
          .toList();
    }
    return list;
  }
}
