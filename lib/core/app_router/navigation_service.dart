import 'package:flutter/material.dart';

import '../../di/get_it.dart';

class NavigationService {
  NavigationService._() : navigatorKey = getIt();
  late GlobalKey<NavigatorState> navigatorKey;
  static final NavigationService navigationServiceInstance =
      NavigationService._();

  navigateTo(BuildContext? context, String routeName) {
    print('route name : $routeName');
    if (context == null) {
      navigatorKey.currentState!.pushNamed(routeName);
      return;
    }
    Navigator.of(context).pushNamed(routeName);
  }

  navigateToWithData(BuildContext? context, String routeName, Object data) {
    print('route name : $routeName');
    if (context == null) {
      navigatorKey.currentState!.pushNamed(
        routeName,
        arguments: data,
      );
      return;
    }
    Navigator.of(context).pushNamed(
      routeName,
      arguments: data,
    );
  }

  navigateToAndClearStack(BuildContext? context, String routeName) {
    if (context == null) {
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
      return;
    }
    print('route name : $routeName');
    Navigator.of(context)
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }

  goBack(BuildContext? context) {
    if (context == null) {
      navigatorKey.currentState!.pop();
      return;
    }
    Navigator.of(context).pop();
  }

  goBackWithData(BuildContext? context, data) {
    if (context == null) {
      navigatorKey.currentState!.pop(data);
      return;
    }
    return Navigator.of(context).pop(data);
  }
}
