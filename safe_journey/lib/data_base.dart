import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Data extends ChangeNotifier {
  var appBarTitle = [
    "Home",
    "Create Scam",
    "Contact Us",
    "About Us",
  ];

  List<String> get getappBarTitle {
    return [...appBarTitle];
  }

  final address = "http://localhost:3000";

  Future<void> sendData(toSend) async {
    print(toSend);
    Map<String, String> instanceToSend = {...toSend};
    print(instanceToSend);
    final url = Uri.parse("$address/scam");
    var request = await http.post(
      url,
      body: instanceToSend,
      encoding: Encoding.getByName('utf-8'),
    );
    print(request);
  }

  Future<String> sendLocation(loc) async {
    print(loc);
    final location = {'location': loc};
    final url = Uri.parse("http://localhost:3000/");
    final request = await http.post(
      url,
      body: location,
      encoding: Encoding.getByName('utf-8'),
    );
    return request.body;
  }
}
