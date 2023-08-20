import 'package:flutter/material.dart';

import '../../core/utils/map_utils/location_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    LocationService().init(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash.png'),
            // TextButton(
            //     onPressed: () {
            //       AwesomeNotifications().createNotification(
            //         content: NotificationContent(
            //           id: DateTime.now().day*67,
            //           channelKey: 'basic_channel',
            //           title: 'xxxx',
            //           body: 'xxx',
            //         ),
            //       );
            //     },
            //     child: Text('show'))
          ],
        ),
      ),
    );
  }
}
