import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String text, String? title) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "OK",
      style: TextStyle(color: Color.fromRGBO(20, 30, 39, 1.0)),
      textAlign: TextAlign.center,
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0))),
    title: Text(
      title != null ? title : "Success",
      style: TextStyle(fontSize: 20),
      textAlign: TextAlign.center,
    ),
    content: Container(
      height: 50,
      margin: EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
