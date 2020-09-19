import 'dart:convert';

import 'package:austindo/models/location.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

var location = Location();

Future<void> doAction(String url, callback(Map<String, dynamic> res)) async {
  Map<String, dynamic> res;

  try {
    final http.Response response = await http.post(url);

    if (response.statusCode == 200) {
      res = await json.decode(response.body);
      callback(res);
    } else {
      try {
        if (res != null) {
          callback({"status": response.statusCode, "message": "Error"});
        } else {
          callback({"status": response.statusCode, "message": response.body});
        }
      } catch (e) {
        print("error");
        print(e);
      }
    }
  } catch (e) {
    return null;
  }
  return res;
}

String epochToDayDMYHM(num timestamp) {
  var format = new DateFormat("E, dd MMM yyyy HH:mm");
  var date = new DateTime.fromMillisecondsSinceEpoch((timestamp).round());
  String formatted = format.format(date);

  return formatted;
}
