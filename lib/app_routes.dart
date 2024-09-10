import 'package:flutter/material.dart';
import 'package:galaxie_app/pages/add_advertisement_page.dart';
import 'package:galaxie_app/pages/advertisement_player_page.dart.dart';
import 'package:galaxie_app/pages/parametre_page.dart';
import 'package:galaxie_app/pages/starting_pages.dart';
 

class AppRoutes {
  static const String home = '/';
  static const String addAdvertisement = '/addAdvertisement';
  static const String advertisementPlayer = '/advertisementPlayer';
  static const String settings = '/settings';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => StartingPages(),
    addAdvertisement: (context) => AddAdvertisementPage(),
    advertisementPlayer: (context) => AdvertisementPlayerPage(),
    settings: (context) => ParametrePage(),
  };
}
