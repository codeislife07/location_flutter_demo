import 'package:flutter/material.dart';
import 'package:location/location.dart' as location;
import 'package:location_flutter_demo/location_get_screen/location_allow_screen.dart';

class LocationGetScreen extends StatefulWidget {
  const LocationGetScreen({super.key});

  @override
  State<LocationGetScreen> createState() => _LocationGetScreenState();
}

class _LocationGetScreenState extends State<LocationGetScreen> {
  location.Location _location = location.Location();

  location.LocationData? locationData;
  @override
  void initState() {
    super.initState();
    checkPermissionAndServiesEnable();
  }

  checkPermissionAndServiesEnable() async {
    if (await requestPermission()) {
      if (await getEnableLocationService()) {
      } else {
        navigateToLocationAllowScreen(true);
      }
    } else {
      navigateToLocationAllowScreen(false);
    }
  }

  navigateToLocationAllowScreen(bool service) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => LocationAllowScreeen(service: service)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: []),
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text("Location lat: ${locationData?.latitude ?? 0}"),
          Text("Location log: ${locationData?.longitude ?? 0}"),
          ElevatedButton(
              onPressed: () async {
                locationData = await getCurrentLocation();
                setState(() {});
              },
              child: const Text("Find location "))
        ]),
      ),
    );
  }

  //ask for permission of location
  Future<bool> requestPermission() async {
    final permission = await _location.requestPermission();
    return permission == location.PermissionStatus.granted;
  }

  Future<location.LocationData> getCurrentLocation() async {
    final locationData = await _location.getLocation();
    return locationData;
  }

  getEnableLocationService() async {
    final serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      final result = await _location.requestService();
      return result;
    }
    return true;
  }
}
