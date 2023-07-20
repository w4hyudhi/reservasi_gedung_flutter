import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Config {
  final String appName = 'RESERVASI GEDUNG';
  final String splashIcon = 'assets/images/logo.png';
  final String appIcon = 'assets/images/logo.png';
  final String supportEmail = 'admin.k@gmail.com';
  final String webAdrres = 'https://gsg.merauke.website/';
  final String imageAdrres = 'images/menu/';
  final CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(-8.490552412519914, 140.40063192838412),
    zoom: 12,
  );

  static final Color primaryColor =
      Color.fromRGBO(71, 148, 255, 1); //Preffered primary color
  static final Color highlightColor =
      Color.fromRGBO(71, 148, 255, 0.2); //Preffered primary color
  static final Color highlightColor2 = Color.fromRGBO(71, 148, 255, 0.3);
}

const double l = 24;
const double m = 20;
const double n = 16;
