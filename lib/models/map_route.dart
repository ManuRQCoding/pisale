// To parse this JSON data, do
//
//     final mapRoute = mapRouteFromMap(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MapRoute {
  MapRoute({
    required this.name,
    required this.initialCameraPos,
    required this.destination,
    required this.zoom,
    required this.polylinePoints,
    required this.origin,
  });
  String name;
  GeoPoint initialCameraPos;
  GeoPoint destination;
  double zoom;
  List<GeoPoint> polylinePoints;
  GeoPoint origin;

  factory MapRoute.fromFirebaseObject(QueryDocumentSnapshot<Object?> object) =>
      MapRoute(
        name: object.get('name'),
        initialCameraPos: object.get('initialCameraPos'),
        destination: object.get('destination'),
        zoom: object.get('zoom'),
        polylinePoints:
            List<GeoPoint>.from(object.get('polylinePoints').map((x) => x)),
        origin: object.get('origin'),
      );
}
