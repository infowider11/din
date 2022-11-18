import 'package:din/constants/colors.dart';
import 'package:din/constants/global_functions.dart';
import 'package:din/constants/sized_box.dart';
import 'package:din/homepage.dart';
import 'package:din/services/api_urls.dart';
import 'package:din/services/webservices.dart';
import 'package:din/widgets/CustomTexts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants/global_data.dart';
import 'constants/navigation.dart';
import 'functions/get_current_location.dart';


class SplashScreenPage extends StatefulWidget {
  static const String id="splash";
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  getCurrentLocation()async{
    // currentPosition = await  determinePosition();
    await getFiltersList();
    await getDams();
    pushReplacement(context: context, screen: HomePage());
    print('the current location is ${currentPosition?.longitude}');
  }
  
  
  getFiltersList()async{
    var jsonResponse = await Webservices.postData(apiUrl: ApiUrls.getDamFilterType, request: {}, isGetMethod: true);
    if(jsonResponse['status']==1){
       kdamCategories = jsonResponse['data']['damCat'];
       kdamBakamType = [
         {
          'id': 2,
          'name': 'Weirs',
        },
         {
           'id':1,
           'name': 'Dam'
         }
      ];
       kdamTypes = jsonResponse['data']['damType'];
       kdamHydrologicalArea =jsonResponse['data']['hydrologicalArea'];
       kdamRiver_basin =jsonResponse['data']['river_basin'];
       kdamGeo_political_zone = jsonResponse['data']['geo_political_zone'];
       kstate =jsonResponse['data']['state'];
    }
  }
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    // Future.delayed(const Duration(seconds: 3)).then((value){
    //   push(context: context, screen: HomePage());
    // });
  }
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png', fit: BoxFit.fitWidth, width: 160, height: 160,),
          hSizedBox,
          MainHeadingText(text: 'Dams in Nigeria', color: MyColors.whiteColor, fontSize: 20, )
        ],
      ),
    );
  }
}
