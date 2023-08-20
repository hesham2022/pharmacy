import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService extends ChangeNotifier {
  factory LocationService() => _instance;
  LocationService._internal();
  static final LocationService _instance = LocationService._internal();
  static Position? position;

  Future<void> init(BuildContext context) async {
    try {
      print('init');
      position = await _determinePosition(context);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<Position> _determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (c) => Dialog(
          // backgroundColor: Colors.white.withOpacity(.8),
          insetPadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            color: Colors.white,
            height: 130,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Please Enable Location',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    // title: context.l10n.tryAgain,
                    // size: const Size(200, 20),
                    child: Text('Try Again'),
                    onPressed: () async {
                      serviceEnabled =
                          await Geolocator.isLocationServiceEnabled();
                      if (!serviceEnabled) {
                        return;
                      }
                      Future.delayed(Duration.zero, () {
                        init(c);
                        Navigator.pop(c);
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          // actions: const [Button1(title: 'Try Again')],
        ),
      );
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
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    return Geolocator.getCurrentPosition();
  }
}
