import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_location_search/cubit/home_bloc/home_cubit.dart';
import 'package:weather_location_search/view/map_view/widgets/bottomsheet_child.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late CameraPosition cameraPosition =
      CameraPosition(target: LatLng(31.050473, 31.391846), zoom: 18.0);
  GoogleMapController? mapController;
  var markers = HashSet<Marker>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    HomeCubit cubit = HomeCubit.get(context);
    return Scaffold(
      key: cubit.scaffoldKey,
      body: Column(
        children: [
          Container(
            height: h * .9,
            width: w,
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: cameraPosition,
              markers: markers,
              onLongPress: (LatLng latLng) {
                setState(
                  () {
                    markers.length > 1
                        ? markers.removeWhere(
                            (element) => element.markerId == MarkerId('1'))
                        : print('no element');
                    markers.add(Marker(
                        markerId: MarkerId('1'),
                        position: latLng,
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueGreen),
                        infoWindow: InfoWindow(
                          title: '${markers.length - 1}',
                          snippet: 'marker',
                        )));
                  },
                );
              },
              onMapCreated: (GoogleMapController googleMapController) async {
                mapController = googleMapController;
                Position position = await cubit.getPosition();
                mapController!.moveCamera(CameraUpdate.newLatLng(
                    LatLng(position.latitude, position.longitude)));

                setState(() {
                  markers.add(Marker(
                      markerId: MarkerId('your location'),
                      position: LatLng(position.latitude, position.longitude),
                      infoWindow: InfoWindow(
                        title: 'location',
                        snippet: 'your city',
                      )));
                });
              },
            ),
          ),
          Container(
            height: h * .1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                cubit.gpsOpen
                    ? Text('select your City ...')
                    : TextButton(
                        onPressed: () async {
                          Position position = await cubit.getPosition();
                          mapController!.moveCamera(CameraUpdate.newLatLng(
                              LatLng(position.latitude, position.longitude)));
                        },
                        child: Text(
                          'open GPS to show your city',
                          style: TextStyle(color: Colors.red),
                        )),
                cubit.maploadingLocation
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () {
                          cubit
                              .getWeatherMap(
                                  '${markers.first.position.latitude}',
                                  '${markers.first.position.longitude}')
                              .then((value) => cubit.scaffoldKey.currentState!
                                  .showBottomSheet(
                                      (context) => BottomSheetChild()));
                        },
                        child: Text('ok'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
