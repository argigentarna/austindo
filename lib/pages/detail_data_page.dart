import 'dart:io';

import 'package:austindo/styles/font_style.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  String image;
  String lat;
  String long;
  String date;

  DetailPage({
    this.image,
    this.lat,
    this.long,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Detail data',
          style: appBarStyle(),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Image.file(
              File(image),
              fit: BoxFit.contain,
              height: 313,
              width: 313,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 37.0),
            child: Text(date.substring(0, 19)),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 37.0),
            child: Row(
              children: [Text(lat.toString()), Text(long.toString())],
            ),
          ),
        ],
      ),
    );
  }
}
