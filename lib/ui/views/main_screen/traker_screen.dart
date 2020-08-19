import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:t_virus/core/util/global_user_acess.dart';
import 'package:t_virus/ui/shared/app_colors.dart';

class TrackerScreen extends StatefulWidget {
  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  GoogleMapController mapController;
  LatLng _center;
  String _mapStyle;
  @override
  void initState() {
    super.initState();
    //Here is setted the location of the user
    double longitude = double.parse(formatLatLogArray()[0]);
    double latitude = double.parse(formatLatLogArray()[1]);
    _center = new LatLng(latitude, longitude);

    rootBundle.loadString('assets/styles/google_black_style.json').then((string) {
      _mapStyle = string;
    });
  }
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(_mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      height: MediaQuery.of(context).size.height / 2,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15.0,
        ),
        myLocationEnabled: false,
        rotateGesturesEnabled: false,
        scrollGesturesEnabled: true,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
      ),
    );
  }
  List<String> formatLatLogArray(){
    return GlobalUser.survivor.location.replaceAll("Point(", "").replaceAll(")", "").split(" ");
  }
}
