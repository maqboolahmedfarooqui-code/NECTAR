import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class apis extends StatefulWidget {
  const apis({super.key});

  @override
  State<apis> createState() => _apisState();
}

class _apisState extends State<apis> {
  Future<void> currentlocation() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnable) {
      Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position current = await Geolocator.getCurrentPosition();

     // Map ka camera update karo
  valuee.animateCamera(
    CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(current.latitude, current.longitude),
        zoom: 16,
      ),
    ),
  );
  }

  @override
  void initState() {
    super.initState();
    currentlocation();
  }

  final CameraPosition cameraa = CameraPosition(
    target: LatLng(25.38, 68.42),
    zoom: 14,
  );
  late GoogleMapController valuee;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: cameraa,
        onMapCreated: (GoogleMapController controller) {
          valuee = controller;
        },
      ),
      floatingActionButton: FloatingActionButton( child: Text('+'),
        onPressed: () {
          currentlocation();
        },
      ),
    );
  }
}
