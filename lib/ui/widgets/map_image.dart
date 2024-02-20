import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapImageScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  MapImageScreen({required this.latitude,required this.longitude});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(latitude, longitude),
            initialZoom: 7,
            minZoom: 7,
            maxZoom: 7
          ),
          children: [
             TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                ),
              MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(latitude, longitude),
                  child: const Icon(Icons.location_pin)
                ),
              ],
            ),
          ],
         
        ),
    );
   
  }
}