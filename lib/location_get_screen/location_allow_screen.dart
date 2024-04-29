import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_flutter_demo/location_get_screen/location_screen.dart';

class LocationAllowScreeen extends StatelessWidget {
  bool service;
  LocationAllowScreeen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Image.asset(
                "assets/images/no_location.jpg",
                // height: 200,
              ),
            ),
            Center(
              child: service
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Text(
                            "Allow Location service or enable service",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                                fontSize: 20),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                var checkPermission =
                                    await Location().requestService();
                                if (checkPermission) {
                                  NavigateToMainScreen(context);
                                }
                              },
                              child: const Text("Enable Service"))
                        ])
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Text(
                            "Allow Location permission from settings",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                                fontSize: 20),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                var checkPermission = await GeolocatorPlatform
                                    .instance
                                    .openAppSettings()
                                    .then((checkPermission) {
                                  print(
                                      "permission from service is $checkPermission");
                                  if (checkPermission) {
                                    Future.delayed(Duration(seconds: 3), () {
                                      NavigateToMainScreen(context);
                                    });
                                  }
                                });
                              },
                              child: const Text("Allow Permission"))
                        ]),
            ),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }

  void NavigateToMainScreen(context) {
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const LocationGetScreen()));
  }
}
