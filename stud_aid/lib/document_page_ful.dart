import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_aid/providers/document_provider.dart';
import 'package:stud_aid/utils/fileStorage.dart';
import 'package:stud_aid/utils/util.dart';

import 'components/bottom_bar.dart';
import 'components/top_bar.dart';
import 'models/document.dart';

class DocumentPage2 extends StatefulWidget {
  int id;
  DocumentPage2(this.id, {Key? key}) : super(key: key);

  @override
  State<DocumentPage2> createState() => _DocumentPage2State();
}

class _DocumentPage2State extends State<DocumentPage2> {
  DocumentProvider? _advertProvider = null;
  Document? document = null;
  @override
  void initState() {
    // TODO: implement initState
    _advertProvider = context.read<DocumentProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _advertProvider?.get(null);
    setState(() {
      document =
          tmpData!.firstWhere((element) => element.documentId == widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(238, 237, 222, 1.0),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50), child: TopBar()),
          body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Text(
                      document?.documentName ?? " ",
                      style: TextStyle(
                          fontSize: 25, color: Color.fromRGBO(20, 30, 39, 1.0)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(30),
                    child: const Text('Description',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(32, 50, 57, 0.4))),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    child: Text(document?.description ?? " ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(32, 50, 57, 0.4))),
                  ),
                  Container(
                    margin: const EdgeInsets.all(30),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(32, 50, 57, 0.4)))),
                    child: Text('By: ${document?.author ?? " "}',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(32, 50, 57, 0.4))),
                  ),
                  Container(
                    width: 100,
                    height: 50,
                    margin:
                        const EdgeInsets.only(top: 50.0, right: 100, left: 100),
                    child: ElevatedButton(
                      onPressed: () {
                        if (document != null &&
                            document?.documentFile != null) {
                          var s = dataFromBase64String(document!.documentFile!);

                          FileStorage.writeCounter(String.fromCharCodes(s),
                              "${document!.documentName!}.txt");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          primary: const Color.fromRGBO(20, 30, 39, 1.0),
                          minimumSize: Size(50, 40)),
                      child: const Text(
                        'Download',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  )
                ]),
          ),
          bottomNavigationBar: const BottomBar()),
    );
  }
}
