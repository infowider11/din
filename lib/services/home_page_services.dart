import 'dart:math';

import 'package:Din/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../constants/global_data.dart';
import '../constants/image_urls.dart';
import '../pages/marker_info_page.dart';
import '../widgets/CustomTexts.dart';
import 'api_urls.dart';

class SearchingServices {
  static Future<List<Map<String, dynamic>>> getSuggestions(String query, String search_field) async {
    var request = {
      'search_text': query
    };
    if(search_field!=''){
      request['search_field']=search_field;
    }
    // setState(() {
    //
    // });
    print('request for search-------------$request');
    var jsonResponse = await Webservices.postData(
      apiUrl:  ApiUrls.getDamsList,
      isGetMethod: true,
      request: request,
    );
    print('the status is ${jsonResponse}');
    damList = jsonResponse['data']['data'];
    print('the search list is $damList');

    markers.clear();

    for (int i = 0; i < damList.length; i++) {
      print('s${damList[i]['latitude']}s ------- s${damList[i]['longitude']}s');
      if(damList[i]['latitude']!='' && damList[i]['longitude']!='' && damList[i]['latitude']!=null && damList[i]['longitude']!=null){
        markers.add(
          Marker(
            point: LatLng(double.parse(damList[i]['latitude']),
                double.parse(damList[i]['longitude'])),
            height: 105,
            width: 115,
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














    await Future<void>.delayed(Duration(seconds: 1));

    return List.generate(damList.length, (index) {
      return damList[index];
      return {
        'name': query + index.toString(),
        'price': Random().nextInt(100).toString()
      };
    });
  }
}