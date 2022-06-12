import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:pisale/models/map_route.dart';

class RutaDetail extends StatefulWidget {
  const RutaDetail({Key? key}) : super(key: key);

  @override
  State<RutaDetail> createState() => _RutaDetailState();
}

class _RutaDetailState extends State<RutaDetail> {
  GoogleMapController? _googleMapController;

  @override
  void initState() {
    // TODO: implement initState
    // getDirections();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _googleMapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('entra');
    final mapRoute = ModalRoute.of(context)!.settings.arguments as MapRoute;

    return Scaffold(
      appBar: AppBar(
        title: Text(mapRoute.name),
      ),
      body: GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
              target: LatLng(mapRoute.initialCameraPos.latitude,
                  mapRoute.initialCameraPos.longitude),
              zoom: mapRoute.zoom),
          onMapCreated: (controller) => _googleMapController = controller,
          markers: {
            Marker(
                markerId: const MarkerId('origin'),
                infoWindow: const InfoWindow(title: 'origin'),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed),
                position: LatLng(
                    mapRoute.origin.latitude, mapRoute.origin.longitude)),
            Marker(
                markerId: const MarkerId('destination'),
                infoWindow: const InfoWindow(title: 'destination'),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen),
                position: LatLng(mapRoute.destination.latitude,
                    mapRoute.destination.longitude)),
          },
          polylines: {
            Polyline(
              polylineId: const PolylineId('overview_polyline'),
              color: Colors.red,
              width: 5,
              points: mapRoute.polylinePoints
                  .map((gPoint) => LatLng(gPoint.latitude, gPoint.longitude))
                  .toList(),
            )
          }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'Go destination',
            backgroundColor: Colors.red,
            onPressed: () {
              _googleMapController!.animateCamera(
                  CameraUpdate.newCameraPosition(CameraPosition(
                      target: LatLng(mapRoute.initialCameraPos.latitude,
                          mapRoute.initialCameraPos.longitude),
                      zoom: mapRoute.zoom)));
            },
            child: const Icon(
              Icons.location_on_sharp,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: 'Go origin',
            backgroundColor: Colors.green,
            onPressed: () {
              _googleMapController!.animateCamera(
                  CameraUpdate.newCameraPosition(CameraPosition(
                      target: LatLng(mapRoute.destination.latitude,
                          mapRoute.destination.longitude),
                      zoom: mapRoute.zoom)));
            },
            child: const Icon(Icons.location_on_sharp, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // getDirections() async {
  //   print('entra');
  //   final directions = await DirectionsProvider().getDirections(
  //       origin: _origin.position, destination: _destination.position);
  //   setState(() {
  //     _info = directions;
  //   });
  // }

}
