import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeoExampleScreen extends StatefulWidget {
  const GeoExampleScreen({super.key});

  @override
  State<GeoExampleScreen> createState() => _GeoExampleScreenState();
}

class _GeoExampleScreenState extends State<GeoExampleScreen> {
  var lat;
  var lng;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void getMyLocation() async {
    var location = await _determinePosition();
    setState(() {
      lat = location.latitude;
      lng = location.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Text("Lat: $lat Lng: $lng"),
        TextButton(
            onPressed: () {
              getMyLocation();
            },
            child: Text("Get Location"))
      ]),
    );
  }
}
