import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_flutter_demo/location_get_screen/location_screen.dart';

class LocationAllowScreeen extends StatelessWidget {
  bool service;
  LocationAllowScreeen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get User Location"),
      ),
      body: Center(
        child: service
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Allow Location service or enable service"),
                ElevatedButton(
                    onPressed: () async {
                      var checkPermission = await Location().requestService();
                      if (checkPermission) {
                        NavigateToMainScreen(context);
                      }
                    },
                    child: const Text("Enable Service"))
              ])
            : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Allow Location permission from settings"),
                ElevatedButton(
                    onPressed: () async {
                      var checkPermission = await GeolocatorPlatform.instance
                          .openAppSettings()
                          .then((checkPermission) {});
                      print("permission from service is $checkPermission");
                      if (checkPermission) {
                        NavigateToMainScreen(context);
                      }
                    },
                    child: const Text("Allow Permission"))
              ]),
      ),
    );
  }

  void NavigateToMainScreen(context) {
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const LocationGetScreen()));
  }
}
