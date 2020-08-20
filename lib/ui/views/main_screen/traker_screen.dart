import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:t_virus/core/model/survivor.dart';
import 'package:t_virus/core/service/people_service.dart';
import 'package:t_virus/core/util/global_user_acess.dart';
import 'package:t_virus/ui/shared/app_colors.dart';
import 'package:map_launcher/map_launcher.dart' as mapl;

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
        ImageConfiguration(size: Size(100, 100), devicePixelRatio: 10.5),
        'images/marker_custom.png');
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
                      zoom: 3.0,
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
                            Image.asset('images/profile_survivor.png', width: 40),
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
                        onTap: () {

                          double longitude = double.parse(
                              formatLatLogArray(survivors[index].location)[0]);
                          double latitude = double.parse(
                              formatLatLogArray(survivors[index].location)[1]);
                          openRoute(lat: latitude, lon: longitude, name: survivors[index].name);
                        },
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

  //remove all characters yet lat lon
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
            icon: pinLocationIcon,
            onTap: () {
              showModal(lat: longitude, lon: longitude, name: survivor.name);
              //_onMarkerTapped(markerId);
            }));
      }
    });
  }

  void showModal({lat: double, lon: double, name: String}) {
    //if is ios plataform custom modal is showed and the user will be able to go to the point
    if (Platform.isIOS) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.map),
                  title: Text('Wanna go to: ' + name),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () => openRoute(lat: lat, lon: lon, name: name),
                ),
              ],
            );
          });
    }
  }

  void openRoute({double lat, double lon, String name}) async {
    if (Platform.isIOS) {
      // ignore: deprecated_member_use
      await mapl.MapLauncher.launchMap(
        mapType: mapl.MapType.apple,
        coords: mapl.Coords(lat, lon),
        title: name,
      );
    } else {
      // ignore: deprecated_member_use
      await mapl.MapLauncher.launchMap(
        mapType: mapl.MapType.google,
        coords: mapl.Coords(lat, lon),
        title: name,
      );
    }
  }
}
