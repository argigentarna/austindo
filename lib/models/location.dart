import 'package:geolocator/geolocator.dart';

class Location {
  double lat;
  double long;
  Position position;

  Location({this.lat, this.long, this.position});

  Future<Position> getLocation() async {
    try {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return Position(
          latitude: position.latitude, longitude: position.longitude);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
