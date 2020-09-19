import 'dart:io';

import 'package:animations/animations.dart';
import 'package:austindo/helper/db_helper.dart';
import 'package:austindo/helper/helper.dart';
import 'package:austindo/models/place.dart';
import 'package:austindo/styles/font_style.dart';
import 'package:austindo/widget/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location_permissions/location_permissions.dart';
// import 'package:simple_permissions/simple_permissions.dart';
import 'package:sqflite/sqflite.dart' as sql;

class PhotoPage extends StatefulWidget {
  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> with TickerProviderStateMixin {
  AnimationController _controller;
  File _imageFile;
  dynamic _pickImageError;
  List<File> _imagesList = List<File>();
  // Permission permission;
  PlaceLocation _pickedLocation;
  String _retrieveDataError;

  Future<void> _showPhoto() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: Icon(Icons.photo_album),
                    title: new Text(
                      'Gallery',
                    ),
                    onTap: () =>
                        {_onImageButtonPressed(ImageSource.gallery, context)}),
                new ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: new Text('Photo Camera'),
                  onTap: () =>
                      {_onImageButtonPressed(ImageSource.camera, context)},
                ),
              ],
            ),
          );
        });
  }

  void _onImageButtonPressed(ImageSource source, context) async {
    Navigator.pop(context);
    try {
      var imageFile = await ImagePicker.pickImage(source: source);
      _cropImage(imageFile);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
    }
  }

  // requestPermission() async {
  //   final res = await SimplePermissions.requestPermission(permission);
  //   print("permission request result is " + res.toString());
  // }

  // checkPermission() async {
  //   bool res = await SimplePermissions.checkPermission(permission);
  //   print("permission is " + res.toString());
  // }

  // getPermissionStatus() async {
  //   final res = await SimplePermissions.getPermissionStatus(permission);
  //   print("permission status is " + res.toString());
  // }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    super.dispose();
  }

  Future<void> _cropImage(imageFile) async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      cropStyle: CropStyle.rectangle,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      iosUiSettings: IOSUiSettings(aspectRatioLockEnabled: true),
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Edit Photo',
          toolbarColor: Color(0xFF51a649),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true),
    );

    setState(() {
      _imagesList.add(cropped);
      _imageFile = cropped ?? _imageFile;
    });
  }

  Future<void> _disposeVideoController() async {
    if (_controller != null) {
      await _controller.dispose();
      _controller = null;
    }
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      return Image.file(_imageFile);
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<bool> insertData(String table, Map<String, Object> data) async {
    bool res = false;
    final db = await DBHelper.database();
    try {
      await db.insert(
        table,
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
      res = true;
    } catch (e) {
      print("err");
      print(e);
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Take a photo',
          style: appBarStyle(),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _imageFile == null
              ? InkWell(
                  onTap: () {
                    _showPhoto();
                  },
                  child: Container(
                    height: 313,
                    width: 313,
                    color: Colors.grey,
                    child: Icon(
                      Icons.image,
                      size: 99,
                      color: Colors.blueGrey,
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    print("klik foto");
                  },
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: new BorderRadius.circular(5.0),
                        child: _imageFile != null
                            ? Image.file(
                                _imageFile,
                                fit: BoxFit.fill,
                                height: 313,
                                width: 313,
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ),
          SizedBox(
            height: 11,
          ),
          primaryButton('Save', () async {
            if (_imageFile == null) {
              showModal<void>(
                context: context,
                configuration: FadeScaleTransitionConfiguration(),
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Ooops, image cannot be null!',
                    ),
                  );
                },
              );
              return;
            }
            // print("Check status location");
            ServiceStatus serviceStatus =
                await LocationPermissions().checkServiceStatus();
            // print(serviceStatus);
            // print("Save a photo");
            Position _loc = await location.getLocation();
            // print("LOCATION");
            // print(_loc.latitude.toString());
            // print(_loc.longitude.toString());
            if (serviceStatus != ServiceStatus.enabled) {
              showModal<void>(
                context: context,
                configuration: FadeScaleTransitionConfiguration(),
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Please turn on location and permission',
                    ),
                  );
                },
              );
            }
            if (_imageFile != null) {
              final res = await insertData(
                'user_places',
                {
                  'id': new DateTime.now().toString(),
                  'image': _imageFile.path,
                  'loc_lat': _loc.latitude,
                  'loc_lng': _loc.longitude,
                  'dateTime': new DateTime.now().toString()
                },
              );
              if (res) {
                showModal<void>(
                  context: context,
                  configuration: FadeScaleTransitionConfiguration(),
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Data saved!',
                      ),
                    );
                  },
                );
                setState(() {
                  _imageFile = null;
                });
              }
            }
            // print("Check data database");
            // print(dataList);
          }),
        ],
      ),
    );
  }
}
