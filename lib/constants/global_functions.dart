import 'package:din/constants/map_images_urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../modals/mapImages.dart';
import '../pages/marker_info_page.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import 'ImagesList.dart';
import 'global_data.dart';
import 'global_keys.dart';
import 'image_urls.dart';

getDams({required Map<String,dynamic> request}) async {

  request['t']='1';

  typeUsageStaticMap.forEach((key, value) {
    if(value==1){
      request[key] = '1';
    }
  });

  var jsonResponse = await Webservices.postData(
   apiUrl:  ApiUrls.getDamsList,
    isGetMethod: true,
    request: request,
  );
  print('the status is ${jsonResponse}');
  damList = jsonResponse['data']['data'];
  print('the dam list is $damList');
  // damList = await Webservices.getListFromRequestParameters(ApiUrls.getDamsList, request, isGetMethod: true);
  markers.clear();

  for (int i = 0; i < damList.length; i++) {
    print('s${damList[i]['latitude']}s ------- s${damList[i]['longitude']}s');
    if(damList[i]['latitude']!='' && damList[i]['longitude']!='' && damList[i]['latitude']!=null && damList[i]['longitude']!=null){
      markers.add(
        Marker(
          point: LatLng(double.parse(damList[i]['latitude']),
              double.parse(damList[i]['longitude'])),
          height: 95,
          width: 100,
          builder: (context) {
            return GestureDetector(
              onTap: (){
                print('Marker ${damList[i]['name']} pressed');
                showDialog(context: context, builder: (context){
                  return MarkerInfoWindow(damInfo: damList[i],);
                });
              },
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: Image.asset(
                        MyImages.markerIcon,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Icon(Icons.circle, color: Colors.brown,size: 10,),
                  Container(
                    height: 10,
                    width: 1,
                    color: Colors.blue,
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)
                    ),

                    child: ParagraphText(text: '${damList[i]['name']}', fontSize: 11,color: Colors.white,),
                  )
                ],
              ),
            );
          },
        ),
      );
    }


  }

  if(showMapHydro){
    List temp = jsonResponse['data']['hydrologicalArea'];
    temp.forEach((element) {
      if(element['status']==1){
        // MapImages.fromJson(data)
        for (int j = 0; j < kMapImages.length; j++){
          if(kMapImages[j]['mapType']=='hydrologicalArea' && kMapImages[j]['id']==element['id']){
            ImagesList.add(kMapImages[j]);
          }
        }
      }
    });
  }
  if(showMapState){
    List temp = jsonResponse['data']['state'];
    temp.forEach((element) {
      if(element['status']==1){
        // MapImages.fromJson(data)
        for (int j = 0; j < kMapImages.length; j++){
          if(kMapImages[j]['mapType']=='state' && kMapImages[j]['id']==element['id']){
            ImagesList.add(kMapImages[j]);
          }
        }
      }
    });
  }
  if(showMapRiver){
    List temp = jsonResponse['data']['river_basin'];
    temp.forEach((element) {
      if(element['status']==1){
        // MapImages.fromJson(data)
        for (int j = 0; j < kMapImages.length; j++){
          if(kMapImages[j]['mapType']=='river_basin' && kMapImages[j]['id']==element['id']){
            ImagesList.add(kMapImages[j]);
          }
        }
      }
    });
  }
  if(showMapGeo){
    List temp = jsonResponse['data']['geo_political_zone'];
    temp.forEach((element) {
      if(element['status']==1){
        // MapImages.fromJson(data)
        for (int j = 0; j < kMapImages.length; j++){
          if(kMapImages[j]['mapType']=='geo_political_zone' && kMapImages[j]['id']==element['id']){
            ImagesList.add(kMapImages[j]);
          }
        }
      }
    });
  }




  try{
    MyGlobalKeys.mapViewPageKey.currentState!.setState(() {

    });
  }catch(e){
    print('Error in catch block hh $e');
  }
}