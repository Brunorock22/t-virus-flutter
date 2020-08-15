import 'package:geolocator/geolocator.dart';

class GPSService{
  Future<Position> getUserLocation() async{
    Position survivorPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return survivorPosition;
  }
}