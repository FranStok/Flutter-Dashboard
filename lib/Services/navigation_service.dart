import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }
  //Esto permite que cuando pasamos del login al dashboard, no pueda volver al login.
  static replaceTo(String routeName){
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}
