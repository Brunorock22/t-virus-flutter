import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:t_virus/core/model/survivor.dart';
import 'package:t_virus/core/service/people_service.dart';
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
  List<Survivor> survivors;

  Set<Marker> markers = Set();
  BitmapDescriptor pinLocationIcon;

  @override
  void initState() {
    super.initState();

    //Here is setted the location of the user
    double longitude =
        double.parse(formatLatLogArray(GlobalUser.survivor.location)[0]);
    double latitude =
        double.parse(formatLatLogArray(GlobalUser.survivor.location)[1]);
    _center = new LatLng(latitude, longitude);

    //Here is setted style nigth in google map
    rootBundle
        .loadString('assets/styles/google_black_style.json')
        .then((string) {
      _mapStyle = string;
    });

    setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(24, 24), devicePixelRatio: 2.5),
        'images/zombie_walker.png');
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(_mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllSurvivor(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Container(
                  color: primaryColor,
                  height: MediaQuery.of(context).size.height / 2,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 5.0,
                    ),
                    myLocationEnabled: true,
                    markers: markers,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      height: 2,
                      color: accentColor,
                    ),
                    itemCount: survivors.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading:
                            Image.asset('images/ic_back_pack.png', width: 30),
                        title: Text(survivors[index].name,
                            style: TextStyle(
                                color: accentColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w300)),
                        subtitle: Text(
                            'Age: ' + survivors[index].age.toString(),
                            style: TextStyle(
                                color: accentColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                                fontStyle: FontStyle.italic)),
                        trailing: Icon(
                          Icons.map,
                          color: accentColor,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: primaryColor,
            ));
          }
        });
  }

  List<String> formatLatLogArray(location) {
    return location
        .replaceAll("Point(", "")
        .replaceAll("POINT(", "")
        .replaceAll("POINT (", "")
        .replaceAll(")", "")
        .split(" ");
  }

  Future<List<Survivor>> getAllSurvivor() async {
    PeopleService peopleService = PeopleService();
    survivors = await peopleService.getAllSurvivor();
    setMarkesInMap();
    return survivors;
  }

  void setMarkesInMap() {
    survivors.forEach((survivor) {
      //format lat log from API
      if (survivor.location != null) {
        double longitude =
            double.parse(formatLatLogArray(survivor.location)[0]);
        double latitude = double.parse(formatLatLogArray(survivor.location)[1]);
        markers.add(Marker(
            infoWindow: InfoWindow(title: survivor.name),
            markerId: MarkerId(survivor.name),
            position: LatLng(latitude, longitude),
            icon: pinLocationIcon));
      }
    });
  }
}
