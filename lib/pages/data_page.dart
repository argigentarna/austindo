import 'dart:io';

import 'package:austindo/helper/db_helper.dart';
import 'package:austindo/pages/detail_data_page.dart';
import 'package:austindo/styles/font_style.dart';
import 'package:flutter/material.dart';

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  List _items = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    fetchDatabase();
  }

  Future<void> fetchDatabase() async {
    final dataList = await DBHelper.getData('user_places');
    setState(() {
      _items = dataList;
    });
    print("CHECK DATA USER PLACE");
    print(_items);
    return null;
  }

  int _countItem() {
    return _items != null ? _items.length : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Data Location',
          style: appBarStyle(),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _countItem(),
        itemBuilder: (context, index) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => new DetailPage(
                            image: _items[index]['image'].toString(),
                            date: _items[index]['dateTime'].toString(),
                            lat: _items[index]['loc_lat'].toString(),
                            long: _items[index]['loc_lng'].toString(),
                          ),
                        ),
                      );
                    },
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              children: [
                                new Text(
                                  _items[index]['dateTime']
                                      .toString()
                                      .substring(0, 19),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
