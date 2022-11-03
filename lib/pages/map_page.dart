import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(22.7196, 75.8577),
          zoom: 15,
        ),
        nonRotatedChildren: [
        ],
        children: [
          TileLayer(
            urlTemplate:
            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            // userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          // MarkerLayer(markers: markers),
        ],
      ),
    );
  }
}
