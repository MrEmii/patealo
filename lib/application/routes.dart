import 'package:flutter/material.dart';
import 'package:patealo/presentation/screens/chat.dart';
import 'package:patealo/presentation/screens/home.dart';
import 'package:patealo/presentation/screens/pictograms.dart';
import 'package:patealo/presentation/screens/splash.dart';

typedef AppRoute = Map<String, Widget Function(BuildContext)>;

class Routes {
  static AppRoute routes = {
    '/': (BuildContext context) => const Splash(),
    '/home': (BuildContext context) => const Home(),
    '/pictograms': (BuildContext context) => const Pictograms(),
    '/chat': (BuildContext context) => const Chat(),
  };
}
