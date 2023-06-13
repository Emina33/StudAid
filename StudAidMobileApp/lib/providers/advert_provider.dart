import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/io_client.dart';
import 'package:stud_aid/providers/base_provider.dart';

import '../models/advert.dart';

class AdvertProvider extends BaseProvider<Advert> {
  AdvertProvider() : super("Advert");

  @override
  Advert fromJson(data) {
    return Advert.fromJson(data);
  }
}
