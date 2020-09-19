import 'dart:convert';

import 'package:austindo/helper/const.dart';
import 'package:austindo/helper/helper.dart';
import 'package:austindo/models/covid.dart';
import 'package:austindo/styles/font_style.dart';
import 'package:flutter/material.dart';

class CovidPage extends StatefulWidget {
  @override
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  var data;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await fetchApi();
  }

  Future<void> fetchApi() async {
    doAction(apiUrl, (res) {
      setState(() {
        // data = Covid.fromJson(res);
        data = res;
      });

      print("Check data");
      print(data);
      print("Check features");
      // print(data["uniqueIdField"]);
      print(data['features']);
    });
  }

  int countData() {
    return data != null ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Covid Page',
          style: appBarStyle(),
        ),
        centerTitle: true,
      ),
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 11.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Confirmed'),
                            SizedBox(
                              height: 11,
                            ),
                            Text('Deaths'),
                            SizedBox(
                              height: 11,
                            ),
                            Text('Recovered'),
                            SizedBox(
                              height: 11,
                            ),
                            Text('Last Update'),
                          ],
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 11.0),
                              child: Text(
                                countData() == 0
                                    ? ''
                                    : data['features'][0]['attributes']
                                            ['Confirmed']
                                        .toString(),
                              ),
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Text(
                              countData() == 0
                                  ? ''
                                  : data['features'][0]['attributes']['Deaths']
                                      .toString(),
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Text(
                              countData() == 0
                                  ? ''
                                  : data['features'][0]['attributes']
                                          ['Recovered']
                                      .toString(),
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Text(
                              countData() == 0
                                  ? ''
                                  : epochToDayDMYHM(data['features'][0]
                                      ['attributes']['Last_Update']),
                            ),
                            SizedBox(
                              height: 11,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
