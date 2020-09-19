import 'package:austindo/helper/const.dart';
import 'package:austindo/pages/covid_page.dart';
import 'package:austindo/pages/data_page.dart';
import 'package:austindo/pages/photo_page.dart';
import 'package:austindo/widget/button_primary.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              assLogo,
              height: 99,
            ),
            SizedBox(
              height: 15,
            ),
            primaryButton('Take a Photo', () {
              print("Take a photo");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new PhotoPage()));
            }),
            primaryButton('List Data', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new DataPage()));
            }),
            primaryButton('API Covid-19', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new CovidPage()));
            })
          ],
        ),
      ),
    );
  }
}
