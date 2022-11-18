import 'package:din/constants/global_keys.dart';
import 'package:din/constants/image_urls.dart';
import 'package:din/pages/marker_info_page.dart';
import 'package:din/services/api_urls.dart';
import 'package:din/services/webservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../constants/colors.dart';
import '../constants/global_data.dart';
import '../constants/sized_box.dart';
import '../functions/get_current_location.dart';
import '../widgets/CustomTexts.dart';
import 'package:din/widgets/customloader.dart';
import '../widgets/customtextfield.dart';

class MapViewHomePage extends StatefulWidget {
  final bool isViewMap ;
  final Function()? ViewMap ;
  const MapViewHomePage({required Key key,required this.isViewMap,this.ViewMap}) : super(key: key);

  @override
  State<MapViewHomePage> createState() => MapViewHomePageState();
}

class MapViewHomePageState extends State<MapViewHomePage>
    with AutomaticKeepAliveClientMixin {
  TextEditingController email = TextEditingController();

  MapController mapController = MapController();

  bool load = false;

  @override
  bool get wantKeepAlive => true;

  getCurrentLocation() async {
    currentPosition = await determinePosition();
    print('the current location is ${currentPosition?.longitude}');
    // getDams();
  }

  resetLocation(LatLng latLng, {double? zoom}) async {
    mapController.move(latLng, zoom ?? 8);

    print('the current location is ${currentPosition?.longitude}');
    // getDams();
  }

  @override
  void initState() {
    // TODO: implement initState

    // getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('the length is ${damList.length}');
    print('the m length is ${markers.length}');
    print('the current location is ${currentPosition?.longitude}');
    return load
        ? CustomLoader()
        : Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      // center: LatLng(currentPosition?.latitude??11.415018, currentPosition?.longitude??5.28),
                      // center: LatLng(9.0820,  8.6753),
                      // center: LatLng(30, 40),
                      center: LatLng(9.35962, 8.76361),

                      zoom: 11,
                    ),
                    nonRotatedChildren: [],
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        // userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                      ),
                      MarkerLayer(markers: markers),

                      // PolygonLayer(
                      //   polygonCulling: true,
                      //
                      //   polygons: [
                      //     Polygon(
                      //       isFilled: true,
                      //       points: [LatLng(20, 25), LatLng(25, 30), LatLng(30, 35),LatLng(35, 40),LatLng(40, 45),LatLng(20, 25),],
                      //       color: Colors.blue.withOpacity(0.4),
                      //       borderColor: Colors.red,
                      //       borderStrokeWidth: 1
                      //     ),
                      //   ],
                      // ),
                    ],
                  )),
                ],
              ),
              if(widget.isViewMap)
              Positioned(
                top: 16,
                right: 16,

                child: Tooltip(
                  message: 'Reset location',
                  child:  GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            color: MyColors.primaryColor,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: MainHeadingText(text: 'View Map', fontSize: 12, color: MyColors.whiteColor, fontFamily: 'semibold',),
                      ),
                      onTap:widget.ViewMap
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(damId: damList[i]['id'],))
                          )

                  )
                ),

              Positioned(
                bottom: 16,
                right: 16,
                child: Tooltip(
                  message: 'Reset location',
                  child: IconButton(
                    onPressed: () {
                      resetLocation(LatLng(9.0820, 8.6753));
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.black,
                      size: 26,
                    ),
                  ),
                ),
              )
            ],
          );
  }
}
