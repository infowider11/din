

import 'dart:developer';

import 'package:Din/constants/colors.dart';
import 'package:Din/constants/global_data.dart';
import 'package:Din/constants/image_urls.dart';
import 'package:Din/constants/navigation.dart';
import 'package:Din/constants/sized_box.dart';
import 'package:Din/detail.dart';
import 'package:Din/functions/get_current_location.dart';
import 'package:Din/pages/about_us_page.dart';
import 'package:Din/pages/contact_us_page.dart';
import 'package:Din/pages/grid_view_page.dart';
import 'package:Din/pages/list_view_home_page.dart';
import 'package:Din/pages/map_view_home_page.dart';
import 'package:Din/pages/marker_info_page.dart';
import 'package:Din/pages/zoomImg.dart';
import 'package:Din/services/api_urls.dart';
import 'package:Din/services/home_page_services.dart';
import 'package:Din/services/webservices.dart';
import 'package:Din/widgets/CustomTexts.dart';
import 'package:Din/widgets/buttons.dart';
import 'package:Din/widgets/customloader.dart';
import 'package:Din/widgets/customtextfield.dart';
import 'package:Din/widgets/dropdown.dart';
import 'package:Din/widgets/showSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants/ImagesList.dart';
import 'constants/constans.dart';
import 'constants/global_functions.dart';
import 'constants/global_keys.dart';
import 'constants/map_images_urls.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // late TabController tabController ;
  // bool isChecked = false;
  TextEditingController email = TextEditingController();
  TextEditingController keyword = TextEditingController();
  // TextEditingController searchKeyword = TextEditingController();
  bool load = false;
  bool isSuggestion = false;
  String? selectedValue;
  String? selectedSubValue;
  // bool showMap = false;
  List ViewFilterImg = [];
  List categoryList = [];
  List selectList = [];
  DateTime? dateTime;
  DateTime _selectedDate=DateTime.now();

  String? catType;
  List StaticDropDown= [{'name':'Yes','value':'1'},{'name':'No','value':'0'}];

  getCategoryList()async{
    categoryList= await Webservices.getList(ApiUrls.categoryList);
    // print("categoryList----------------${res}");
    // categoryList=res['data'];
    print("categoryList----------------${categoryList}");
    setState(() {

    });
  }
  getType(name)async{

    for(int i=0; i<categoryList.length;i++){
      if(name==categoryList[i]['name']){
        catType=categoryList[i]['type'];
        print('catType----------------${catType}');
        if(name=='dams.name'){
          isSuggestion=true;
        }
        else if(catType=='select'){
          selectList=categoryList[i]['value'];
        }
        setState(() {

        });
      }
    }
  }

  clearFilters()async{
    _scaffoldKey.currentState?.closeDrawer();
    selectedDamCategories.clear();
    selectedkdamBakamType.clear();
    selectedDamTypes.clear();
    selectedDamHydrologicalArea.clear();
    selectedDamRiverBasin.clear();
    selectedDamGeoPoliticalZone.clear();
    selectedDamState.clear();
     showMapHydro = false;
     showMapState = false;
     showMapRiver = false;
     showMapGeo = false;
    typeUsageStaticMap = {
      'fishery_fishing': 0,
      'livestock': 0,
      'pollution_control': 0,
      'recreation': 0,
      'hydro_electricity': 0,
      'flood_control': 0,
      'water_Supply': 0,
      'irrigation': 0,
    };

    try{
      MyGlobalKeys.mapViewPageKey.currentState!.resetLocation(MyGlobalConstants.initialLocation);
    }catch(e){
      print('Error in catch block 2525 $e');
    }
    await getDams( request: {});
    setState(() {

    });
  }
  Future<void> _showMyDialog(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('${msg}.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // getDams({bool shouldLoad = false}) async {
  //   if (shouldLoad)
  //     setState(() {
  //       load = true;
  //     });
  //   Map<String, dynamic> request = {};
  //   var jsonResponse = await Webservices.getMap(
  //     ApiUrls.getDamsList,
  //     isGetMethod: true,
  //   );
  //   print('the status is ${jsonResponse}');
  //   damList = jsonResponse['data'];
  //   print('the dam list is $damList');
  //   // damList = await Webservices.getListFromRequestParameters(ApiUrls.getDamsList, request, isGetMethod: true);
  //   markers.clear();
  //
  //   for (int i = 0; i < damList.length; i++) {
  //     markers.add(
  //       Marker(
  //         point: LatLng(double.parse(damList[i]['latitude']),
  //             double.parse(damList[i]['longitude'])),
  //         height: 95,
  //         width: 100,
  //         builder: (context) {
  //           return GestureDetector(
  //             onTap: () {
  //               print('Marker ${damList[i]['name']} pressed');
  //               showDialog(
  //                   context: context,
  //                   builder: (context) {
  //                     return MarkerInfoWindow(
  //                       damInfo: damList[i],
  //                     );
  //                   });
  //             },
  //             child: Column(
  //               children: [
  //                 Expanded(
  //                   child: Container(
  //                     child: Image.asset(
  //                       MyImages.markerIcon,
  //                       fit: BoxFit.fitHeight,
  //                     ),
  //                   ),
  //                 ),
  //                 Icon(
  //                   Icons.circle,
  //                   color: Colors.brown,
  //                   size: 10,
  //                 ),
  //                 Container(
  //                   height: 10,
  //                   width: 1,
  //                   color: Colors.red,
  //                 ),
  //                 Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
  //                   decoration: BoxDecoration(
  //                       color: Colors.red,
  //                       borderRadius: BorderRadius.circular(20)),
  //                   child: ParagraphText(
  //                     text: '${damList[i]['name']}',
  //                     fontSize: 8,
  //                     color: Colors.white,
  //                   ),
  //                 )
  //               ],
  //             ),
  //           );
  //         },
  //       ),
  //     );
  //     setState(() {});
  //   }
  //
  //   if (shouldLoad) {
  //     load = false;
  //   }
  //
  //   setState(() {});
  //
  //   try {
  //     MyGlobalKeys.mapViewPageKey.currentState!.setState(() {});
  //   } catch (e) {
  //     print('Error in catch block $e');
  //   }
  // }

  // getCurrentLocation()async{
  //   currentPosition = await  determinePosition();
  // }
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    // tabController = TabController(length: 3, vsync: this);
    getCategoryList();
    selectedDamCategories = {};
    // getDams();
    super.initState();
  }



  List<Widget> buildTypeUsageUi(){
    List<Widget> temp = [];
    typeUsageStaticMap.forEach((key, val) {
      temp.add(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Checkbox(
                  checkColor: Colors.white,
                  value: val==1,
                  onChanged: (bool? value) {
                    print('the val is $val and value is $value');
                    // isChecked = value;
                    // kdamCategories[i]['isChecked'] = value;
                    if (value == true) {
                      typeUsageStaticMap[key] = 1;
                    } else {
                      typeUsageStaticMap[key] = 0;
                    }
                    setState(() {

                    });
                    print('the val is $val and value is $value 111');
                  },
                ),
              ),
              hSizedBox05,
              Container(
                constraints: BoxConstraints(
                  maxWidth: MyGlobalConstants.filterMaxWidth,
                  minWidth: MyGlobalConstants.filterMinWidth,
                ),
                child: MainHeadingText(
                  text: '${key}',
                  fontSize: 14,
                  fontFamily: 'light',
                ),
              )
            ],
          )
      );
    });




        return temp;
  }

  @override
  Widget build(BuildContext context) {
    isSuggestion = false;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MyColors.whiteColor,
      appBar: AppBar(
        toolbarHeight: 38,
        backgroundColor: MyColors.whiteColor,
        elevation: 1,
        automaticallyImplyLeading: false,
        leading: Tooltip(
          message: 'About Us',
          child: IconButton(
              onPressed: () {
                push(context: context, screen: AboutUsPage());
              },
              icon: Icon(
                Icons.info,
                color: Colors.black,
              )),
        ),
        title: const Text('Dams in Nigeria',
            style: TextStyle(color: Colors.black, fontFamily: 'semibold')),
        centerTitle: true,
        actions: <Widget>[

          Tooltip(
            message: 'Contact Us',
            child: IconButton(
              icon: const Icon(
                Icons.contact_support,
                color: Colors.black,
              ),
              onPressed: () {
                push(context: context, screen: ContactUsScreen());
              },
            ),
          ),
          Tooltip(
            message: 'Download',
            child: IconButton(
              icon: const Icon(
                Icons.book_online,
                color: Colors.black,
              ),
              onPressed: ()async {
                String _url = "https://dams.ng/permanent_assets/dams.pdf";
                  if (!await launchUrl(Uri.parse(_url))) {
                    throw 'Could not launch $_url';
                  }
              },
            ),
          ),

        ],
      ),
      drawer: Drawer(
        width:MediaQuery.of(context).size.width>700?650:MediaQuery.of(context).size.width>500?450:MediaQuery.of(context).size.width-80,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Scaffold(
          body: Stack(
            children: [
              ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 70,
                    child: DrawerHeader(
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: MyColors.purpleColor,
                      ),
                      child: Text(
                        'Filter',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.whiteColor,
                            fontSize: 18,
                            fontFamily: 'light',
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MainHeadingText(
                              text: 'DAM/WEIRS',
                              fontSize: 16,
                            ),
                            vSizedBox,
                            Align(
                              alignment: Alignment.topLeft,
                              child: Wrap(
                                children: [
                                  for (int i = 0; i < kdamBakamType.length; i++)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Checkbox(
                                            checkColor: Colors.white,
                                            value: selectedkdamBakamType[
                                            kdamBakamType[i]['id']] ??
                                                false,
                                            onChanged: (bool? value) {
                                              if (value == true) {
                                                selectedkdamBakamType.clear();
                                                selectedkdamBakamType[kdamBakamType[i]
                                                ['id']] = value;
                                              } else {
                                                selectedkdamBakamType
                                                    .remove(kdamBakamType[i]['id']);
                                              }
                                              setState(() {
                                                // isChecked = value;
                                                // kdamCategories[i]['isChecked'] = value;
                                              });
                                            },
                                          ),
                                        ),
                                        hSizedBox05,
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MyGlobalConstants.filterMaxWidth,
                                            minWidth: MyGlobalConstants.filterMinWidth,
                                          ),
                                          child: MainHeadingText(
                                            text: '${kdamBakamType[i]['name']}',
                                            fontSize: 14,
                                            fontFamily: 'light',
                                          ),
                                        )
                                      ],
                                    ),
                                ],
                              ),
                            )

                          ],
                        ),
                        if (!selectedkdamBakamType.containsKey(2) ||
                            selectedkdamBakamType.length != 1)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MainHeadingText(
                                text: 'SIZE(Category)',
                                fontSize: 16,
                              ),
                              vSizedBox,
                              Align(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  children: [
                                    for (int i = 0; i < kdamCategories.length; i++)
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: Checkbox(
                                              checkColor: Colors.white,
                                              value: selectedDamCategories[
                                              kdamCategories[i]['id']] ??
                                                  false,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  // isChecked = value;
                                                  // kdamCategories[i]['isChecked'] = value;
                                                  if (value == true) {
                                                    selectedDamCategories[
                                                    kdamCategories[i]['id']] =
                                                        value;
                                                  } else {
                                                    selectedDamCategories.remove(
                                                        kdamCategories[i]['id']);
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          hSizedBox05,
                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth: MyGlobalConstants.filterMaxWidth,
                                              minWidth: MyGlobalConstants.filterMinWidth,
                                            ),
                                            child: MainHeadingText(
                                              text: '${kdamCategories[i]['name']}',
                                              fontSize: 14,
                                              fontFamily: 'light',
                                            ),
                                          )
                                        ],
                                      ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                        if (!selectedkdamBakamType.containsKey(2) ||
                            selectedkdamBakamType.length != 1)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              vSizedBox2,
                              MainHeadingText(
                                text: 'TYPE',
                                fontSize: 16,
                              ),
                              vSizedBox,
                              Align(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  children: [
                                    for (int i = 0; i < kdamTypes.length; i++)
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: Checkbox(
                                              checkColor: Colors.white,
                                              value: selectedDamTypes[kdamTypes[i]
                                              ['id']] ??
                                                  false,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  // isChecked = value;
                                                  // kdamCategories[i]['isChecked'] = value;
                                                  if (value == true) {
                                                    selectedDamTypes[kdamTypes[i]
                                                    ['id']] = value;
                                                  } else {
                                                    selectedDamTypes
                                                        .remove(kdamTypes[i]['id']);
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          hSizedBox05,
                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth: MyGlobalConstants.filterMaxWidth,
                                              minWidth: MyGlobalConstants.filterMinWidth,
                                            ),
                                            child: MainHeadingText(
                                              text: '${kdamTypes[i]['name']}',
                                              fontSize: 14,
                                              fontFamily: 'light',
                                            ),
                                          )
                                        ],
                                      )
                                  ],
                                ),
                              )

                            ],
                          ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            vSizedBox2,
                            MainHeadingText(
                              text: 'USAGE',
                              fontSize: 16,
                            ),
                            vSizedBox,
                            Align(
                              alignment: Alignment.topLeft,
                              child: Wrap(
                                children: [
                                  ...buildTypeUsageUi(),

                                ],
                              ),
                            )

                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            vSizedBox2,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MainHeadingText(
                                  text: 'HYDROLOGICAL AREA',
                                  fontSize: 14,
                                ),
                                // hSizedBox,
                                Row(
                                  children: [
                                    Text('Show Map'),
                                    Checkbox(
                                      value: showMapHydro,
                                      onChanged: (value) {
                                        setState(() {
                                          if (selectedDamHydrologicalArea.keys
                                                  .toList()
                                                  .length >
                                              0) {
                                            if (value != null) {
                                              showMapHydro = value;
                                              setState(() {});
                                            }
                                          } else {
                                            _showMyDialog(
                                                'Please select atleast one HYDROLOGICAL AREA');
                                            // showSnackbar('');
                                          }
                                          setState(() {});
                                        });
                                      },
                                    )
                                  ],
                                ),
                                // Expanded(
                                //   child: CheckboxListTile(value: showMapHydro,
                                //     contentPadding: EdgeInsets.symmetric(horizontal: 2),
                                //
                                //     onChanged: (value){
                                //       setState(() {
                                //         if(value!=null){
                                //           showMapHydro=value;
                                //
                                //         }
                                //       });
                                //     },
                                //     activeColor: MyColors.primaryColor,
                                //     title: Text(' Show Map'),),
                                // ),
                              ],
                            ),
                            vSizedBox,
                            Align(
                              alignment: Alignment.topLeft,
                              child: Wrap(
                                children: [
                                  for (int i = 0;
                                  i < kdamHydrologicalArea.length;
                                  i++)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Checkbox(
                                            checkColor: Colors.white,
                                            value: selectedDamHydrologicalArea[
                                            kdamHydrologicalArea[i]['id']] ??
                                                false,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                // isChecked = value;
                                                // kdamCategories[i]['isChecked'] = value;
                                                if (value == true) {
                                                  selectedDamHydrologicalArea[
                                                  kdamHydrologicalArea[i]
                                                  ['id']] = value;
                                                } else {
                                                  selectedDamHydrologicalArea.remove(
                                                      kdamHydrologicalArea[i]['id']);
                                                  if (selectedDamHydrologicalArea.keys.toList().length ==0) {
                                                    showMapHydro=false;

                                                  }
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        hSizedBox05,
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MyGlobalConstants.filterMaxWidth,
                                            minWidth: MyGlobalConstants.filterMinWidth,
                                          ),
                                          child: MainHeadingText(
                                            text:
                                            '${kdamHydrologicalArea[i]['name']}',
                                            fontSize: 14,
                                            fontFamily: 'light',
                                          ),
                                        )
                                      ],
                                    ),

                                ],
                              ),
                            ),

                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            vSizedBox2,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MainHeadingText(
                                  text: 'RIVER BASIN',
                                  fontSize: 14,
                                ),
                                // hSizedBox,
                                Row(
                                  children: [
                                    Text('Show Map'),
                                    Checkbox(
                                      value: showMapRiver,
                                      onChanged: (value) {
                                        setState(() {
                                          if (selectedDamRiverBasin.keys
                                                  .toList()
                                                  .length >
                                              0) {
                                            if (value != null) {
                                              showMapRiver = value;
                                            }
                                          } else {
                                            _showMyDialog(
                                                'Please select atleast one RIVER BASIN');
                                          }
                                        });
                                      },
                                    )
                                  ],
                                ),
                                // Expanded(
                                //   child: CheckboxListTile(value: showMapHydro,
                                //     contentPadding: EdgeInsets.symmetric(horizontal: 2),
                                //
                                //     onChanged: (value){
                                //       setState(() {
                                //         if(value!=null){
                                //           showMapHydro=value;
                                //
                                //         }
                                //       });
                                //     },
                                //     activeColor: MyColors.primaryColor,
                                //     title: Text(' Show Map'),),
                                // ),
                              ],
                            ),

                            //
                            // MainHeadingText(
                            //   text: 'RIVER BASIN',
                            //   fontSize: 16,
                            // ),
                            // CheckboxListTile(value: showMapRiver,
                            //   onChanged: (value){
                            //     setState(() {
                            //       if(value!=null){
                            //         showMapRiver=value;
                            //       }
                            //     });
                            //   },
                            //   activeColor: MyColors.primaryColor,
                            //   title: Text('Show Map'),),
                            vSizedBox,
                            Align(
                              alignment: Alignment.topLeft,
                              child: Wrap(
                                children: [
                                  for (int i = 0; i < kdamRiver_basin.length; i++)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Checkbox(
                                            checkColor: Colors.white,
                                            value: selectedDamRiverBasin[
                                            kdamRiver_basin[i]['id']] ??
                                                false,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                // isChecked = value;
                                                // kdamCategories[i]['isChecked'] = value;
                                                if (value == true) {
                                                  selectedDamRiverBasin[
                                                  kdamRiver_basin[i]['id']] =
                                                      value;
                                                } else {
                                                  selectedDamRiverBasin.remove(
                                                      kdamRiver_basin[i]['id']);
                                                  if (selectedDamRiverBasin.keys.toList().length ==0) {
                                                    showMapRiver=false;

                                                  }
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        hSizedBox05,
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MyGlobalConstants.filterMaxWidth,
                                            minWidth: MyGlobalConstants.filterMinWidth,
                                          ),
                                          child: MainHeadingText(
                                            text: '${kdamRiver_basin[i]['name']}',
                                            fontSize: 14,
                                            fontFamily: 'light',
                                          ),
                                        )
                                      ],
                                    ),

                                ],
                              ),
                            ),

                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            vSizedBox2,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MainHeadingText(
                                  text: 'GEO POLITICAL ZONE',
                                  fontSize: 14,
                                ),
                                // hSizedBox,
                                Row(
                                  children: [
                                    Text('Show Map'),
                                    Checkbox(
                                      value: showMapGeo,
                                      onChanged: (value) {
                                        setState(() {
                                          if (selectedDamGeoPoliticalZone.keys
                                                  .toList()
                                                  .length >
                                              0) {
                                            if (value != null) {
                                              showMapGeo = value;
                                            }
                                          } else {
                                            _showMyDialog(
                                                'Please select atleast one GEO POLITICAL ZONE');
                                          }
                                        });
                                      },
                                    )
                                  ],
                                ),
                                // Expanded(
                                //   child: CheckboxListTile(value: showMapHydro,
                                //     contentPadding: EdgeInsets.symmetric(horizontal: 2),
                                //
                                //     onChanged: (value){
                                //       setState(() {
                                //         if(value!=null){
                                //           showMapHydro=value;
                                //
                                //         }
                                //       });
                                //     },
                                //     activeColor: MyColors.primaryColor,
                                //     title: Text(' Show Map'),),
                                // ),
                              ],
                            ),

                            //
                            // MainHeadingText(
                            //   text: 'GEO POLITICAL ZONE',
                            //   fontSize: 16,
                            // ),
                            // CheckboxListTile(value: showMapGeo,
                            //   onChanged: (value){
                            //     setState(() {
                            //       if(value!=null){
                            //         showMapGeo=value;
                            //       }
                            //     });
                            //   },
                            //   activeColor: MyColors.primaryColor,
                            //   title: Text('Show Map'),),
                            vSizedBox,
                            Align(
                              alignment: Alignment.topLeft,
                              child: Wrap(
                                children: [
                                  for (int i = 0;
                                  i < kdamGeo_political_zone.length;
                                  i++)
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Checkbox(
                                            checkColor: Colors.white,
                                            value: selectedDamGeoPoliticalZone[
                                            kdamGeo_political_zone[i]
                                            ['id']] ??
                                                false,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                // isChecked = value;
                                                // kdamCategories[i]['isChecked'] = value;
                                                if (value == true) {
                                                  selectedDamGeoPoliticalZone[
                                                  kdamGeo_political_zone[i]
                                                  ['id']] = value;
                                                } else {
                                                  selectedDamGeoPoliticalZone.remove(
                                                      kdamGeo_political_zone[i]
                                                      ['id']);
                                                  if (selectedDamGeoPoliticalZone.keys.toList().length ==0) {
                                                    showMapGeo=false;

                                                  }
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        hSizedBox05,
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MyGlobalConstants.filterMaxWidth,
                                            minWidth: MyGlobalConstants.filterMinWidth,
                                          ),
                                          child: MainHeadingText(
                                            text:
                                            '${kdamGeo_political_zone[i]['name']}',
                                            fontSize: 14,
                                            fontFamily: 'light',
                                          ),
                                        )
                                      ],
                                    ),

                                ],
                              ),
                            ),

                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            vSizedBox2,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MainHeadingText(
                                  text: 'STATE',
                                  fontSize: 14,
                                ),
                                // hSizedBox,
                                Row(
                                  children: [
                                    Text('Show Map'),
                                    Checkbox(
                                      value: showMapState,
                                      onChanged: (value) {
                                        setState(() {
                                          if (selectedDamState.keys
                                                  .toList()
                                                  .length >
                                              0) {
                                            if (value != null) {
                                              showMapState = value;
                                            }
                                          } else {
                                            _showMyDialog(
                                                'Please select atleast one STATE');
                                          }
                                        });
                                      },
                                    )
                                  ],
                                ),
                                // Expanded(
                                //   child: CheckboxListTile(value: showMapHydro,
                                //     contentPadding: EdgeInsets.symmetric(horizontal: 2),
                                //
                                //     onChanged: (value){
                                //       setState(() {
                                //         if(value!=null){
                                //           showMapHydro=value;
                                //
                                //         }
                                //       });
                                //     },
                                //     activeColor: MyColors.primaryColor,
                                //     title: Text(' Show Map'),),
                                // ),
                              ],
                            ),

                            // MainHeadingText(
                            //   text: 'STATE',
                            //   fontSize: 16,
                            // ),
                            // CheckboxListTile(value: showMapState,
                            //   onChanged: (value){
                            //     setState(() {
                            //       if(value!=null){
                            //         showMapState=value;
                            //       }
                            //     });
                            //   },
                            //   activeColor: MyColors.primaryColor,
                            //   title: Text('Show Map'),),
                            vSizedBox,
                            Align(
                              alignment: Alignment.topLeft,
                              child: Wrap(
                                children: [
                                  for (int i = 0; i < kstate.length; i++)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Checkbox(
                                            checkColor: Colors.white,
                                            value:
                                            selectedDamState[kstate[i]['id']] ??
                                                false,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                // isChecked = value;
                                                // kdamCategories[i]['isChecked'] = value;
                                                if (value == true) {
                                                  selectedDamState[kstate[i]['id']] =
                                                      value;
                                                } else {
                                                  selectedDamState
                                                      .remove(kstate[i]['id']);
                                                  if (selectedDamState.keys.toList().length ==0) {
                                                    showMapState=false;

                                                  }
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        hSizedBox05,
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MyGlobalConstants.filterMaxWidth,
                                            minWidth: MyGlobalConstants.filterMinWidth,
                                          ),
                                          child: MainHeadingText(
                                            text: '${kstate[i]['name']}',
                                            fontSize: 14,
                                            fontFamily: 'light',
                                          ),
                                        )
                                      ],
                                    ),

                                ],
                              ),
                            ),

                          ],
                        ),
                        // hSizedBox4,
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     MainHeadingText(
                        //       text: 'TYPE USAGE',
                        //       fontSize: 16,
                        //     ),
                        //     hSizedBox,
                        //     Row(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Expanded(
                        //             child: Column(
                        //           children: [
                        //             Row(
                        //               children: [
                        //                 SizedBox(
                        //                   width: 24,
                        //                   height: 24,
                        //                   child: Checkbox(
                        //                     checkColor: Colors.white,
                        //                     value: isChecked,
                        //                     onChanged: (bool? value) {
                        //                       setState(() {
                        //                         isChecked = value!;
                        //                       });
                        //                     },
                        //                   ),
                        //                 ),
                        //                 wSizedBox05,
                        //                 MainHeadingText(
                        //                   text: 'Hydropower',
                        //                   fontSize: 14,
                        //                   fontFamily: 'light',
                        //                 )
                        //               ],
                        //             ),
                        //             hSizedBox05,
                        //             Row(
                        //               children: [
                        //                 SizedBox(
                        //                   width: 24,
                        //                   height: 24,
                        //                   child: Checkbox(
                        //                     checkColor: Colors.white,
                        //                     value: isChecked,
                        //                     onChanged: (bool? value) {
                        //                       setState(() {
                        //                         isChecked = value!;
                        //                       });
                        //                     },
                        //                   ),
                        //                 ),
                        //                 wSizedBox05,
                        //                 MainHeadingText(
                        //                   text: 'Water Supply',
                        //                   fontSize: 14,
                        //                   fontFamily: 'light',
                        //                 )
                        //               ],
                        //             ),
                        //             hSizedBox05,
                        //             Row(
                        //               children: [
                        //                 SizedBox(
                        //                   width: 24,
                        //                   height: 24,
                        //                   child: Checkbox(
                        //                     checkColor: Colors.white,
                        //                     value: isChecked,
                        //                     onChanged: (bool? value) {
                        //                       setState(() {
                        //                         isChecked = value!;
                        //                       });
                        //                     },
                        //                   ),
                        //                 ),
                        //                 wSizedBox05,
                        //                 MainHeadingText(
                        //                   text: 'Irrigation',
                        //                   fontSize: 14,
                        //                   fontFamily: 'light',
                        //                 )
                        //               ],
                        //             ),
                        //             hSizedBox05,
                        //             Row(
                        //               children: [
                        //                 SizedBox(
                        //                   width: 24,
                        //                   height: 24,
                        //                   child: Checkbox(
                        //                     checkColor: Colors.white,
                        //                     value: isChecked,
                        //                     onChanged: (bool? value) {
                        //                       setState(() {
                        //                         isChecked = value!;
                        //                       });
                        //                     },
                        //                   ),
                        //                 ),
                        //                 wSizedBox05,
                        //                 MainHeadingText(
                        //                   text: 'Flood Control',
                        //                   fontSize: 14,
                        //                   fontFamily: 'light',
                        //                 )
                        //               ],
                        //             )
                        //           ],
                        //         )),
                        //         Expanded(
                        //             child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           children: [
                        //             Row(
                        //               children: [
                        //                 SizedBox(
                        //                   width: 24,
                        //                   height: 24,
                        //                   child: Checkbox(
                        //                     checkColor: Colors.white,
                        //                     value: isChecked,
                        //                     onChanged: (bool? value) {
                        //                       setState(() {
                        //                         isChecked = value!;
                        //                       });
                        //                     },
                        //                   ),
                        //                 ),
                        //                 wSizedBox05,
                        //                 MainHeadingText(
                        //                   text: 'Fishery',
                        //                   fontSize: 14,
                        //                   fontFamily: 'light',
                        //                 )
                        //               ],
                        //             ),
                        //             hSizedBox05,
                        //             Row(
                        //               children: [
                        //                 SizedBox(
                        //                   width: 24,
                        //                   height: 24,
                        //                   child: Checkbox(
                        //                     checkColor: Colors.white,
                        //                     value: isChecked,
                        //                     onChanged: (bool? value) {
                        //                       setState(() {
                        //                         isChecked = value!;
                        //                       });
                        //                     },
                        //                   ),
                        //                 ),
                        //                 wSizedBox05,
                        //                 MainHeadingText(
                        //                   text: 'Livestock',
                        //                   fontSize: 14,
                        //                   fontFamily: 'light',
                        //                 )
                        //               ],
                        //             ),
                        //             hSizedBox05,
                        //             Row(
                        //               children: [
                        //                 SizedBox(
                        //                   width: 24,
                        //                   height: 24,
                        //                   child: Checkbox(
                        //                     checkColor: Colors.white,
                        //                     value: isChecked,
                        //                     onChanged: (bool? value) {
                        //                       setState(() {
                        //                         isChecked = value!;
                        //                       });
                        //                     },
                        //                   ),
                        //                 ),
                        //                 wSizedBox05,
                        //                 MainHeadingText(
                        //                   text: 'Tourism',
                        //                   fontSize: 14,
                        //                   fontFamily: 'light',
                        //                 )
                        //               ],
                        //             ),
                        //           ],
                        //         ))
                        //       ],
                        //     )
                        //   ],
                        // ),
                        // hSizedBox4,
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     MainHeadingText(
                        //       text: 'Hydrological Area',
                        //       fontSize: 16,
                        //     ),
                        //     hSizedBox,
                        //     Row(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Expanded(
                        //             child: Column(
                        //           children: [
                        //             Row(
                        //               children: [
                        //                 SizedBox(
                        //                   width: 24,
                        //                   height: 24,
                        //                   child: Checkbox(
                        //                     checkColor: Colors.white,
                        //                     value: isChecked,
                        //                     onChanged: (bool? value) {
                        //                       setState(() {
                        //                         isChecked = value!;
                        //                       });
                        //                     },
                        //                   ),
                        //                 ),
                        //                 wSizedBox05,
                        //                 MainHeadingText(
                        //                   text: 'Niger North',
                        //                   fontSize: 14,
                        //                   fontFamily: 'light',
                        //                 )
                        //               ],
                        //             ),
                        //             hSizedBox05,
                        //             Row(
                        //               children: [
                        //                 SizedBox(
                        //                   width: 24,
                        //                   height: 24,
                        //                   child: Checkbox(
                        //                     checkColor: Colors.white,
                        //                     value: isChecked,
                        //                     onChanged: (bool? value) {
                        //                       setState(() {
                        //                         isChecked = value!;
                        //                       });
                        //                     },
                        //                   ),
                        //                 ),
                        //                 wSizedBox05,
                        //                 MainHeadingText(
                        //                   text: 'Niger South',
                        //                   fontSize: 14,
                        //                   fontFamily: 'light',
                        //                 )
                        //               ],
                        //             ),
                        //           ],
                        //         )),
                        //         Expanded(
                        //             child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           children: [
                        //             Row(
                        //               children: [
                        //                 SizedBox(
                        //                   width: 24,
                        //                   height: 24,
                        //                   child: Checkbox(
                        //                     checkColor: Colors.white,
                        //                     value: isChecked,
                        //                     onChanged: (bool? value) {
                        //                       setState(() {
                        //                         isChecked = value!;
                        //                       });
                        //                     },
                        //                   ),
                        //                 ),
                        //                 wSizedBox05,
                        //                 MainHeadingText(
                        //                   text: 'Chad Basin',
                        //                   fontSize: 14,
                        //                   fontFamily: 'light',
                        //                 )
                        //               ],
                        //             ),
                        //             hSizedBox05,
                        //             Row(
                        //               children: [
                        //                 SizedBox(
                        //                   width: 24,
                        //                   height: 24,
                        //                   child: Checkbox(
                        //                     checkColor: Colors.white,
                        //                     value: isChecked,
                        //                     onChanged: (bool? value) {
                        //                       setState(() {
                        //                         isChecked = value!;
                        //                       });
                        //                     },
                        //                   ),
                        //                 ),
                        //                 wSizedBox05,
                        //                 MainHeadingText(
                        //                   text: 'Niger Central',
                        //                   fontSize: 14,
                        //                   fontFamily: 'light',
                        //                 )
                        //               ],
                        //             ),
                        //           ],
                        //         ))
                        //       ],
                        //     )
                        //   ],
                        // ),
                        vSizedBox8,
                        // Image.asset('assets/images/map-2.png'),
                        // hSizedBox4,
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 10,
                right: 0,
                left: 0,
                child: Row(
                  children: [
                    Expanded(
                      child: RoundEdgedButton(
                          text: 'Apply',
                          onTap: () async {
                            _scaffoldKey.currentState?.closeDrawer();
                            print('sssss');
                            print(selectedDamCategories);
                            // search_text:
                            // cat_ids:1
                            // type_ids:2,4
                            // hydrological_area_ids:9,10
                            // river_basin_ids:13,10
                            // geopolitical_zone_ids:3,6
                            // state_ids:14,34
                            // list_type:1

                            Map<String, dynamic> request = {};
                            if (selectedDamCategories.isNotEmpty &&
                                (!selectedkdamBakamType.containsKey(2) ||
                                    selectedkdamBakamType.length != 1)) {
                              request['cat_ids'] =
                                  selectedDamCategories.keys.join(',');
                            }
                            // if(selectedDamCategories.length!=0){
                            //   request['cat_ids'] = selectedDamCategories.join(',');
                            // }
                            if (selectedkdamBakamType.isNotEmpty) {
                              request['list_type'] =
                                  selectedkdamBakamType.keys.join(',');
                            }
                            if (selectedDamTypes.isNotEmpty &&
                                (!selectedkdamBakamType.containsKey(2) ||
                                    selectedkdamBakamType.length != 1)) {
                              request['type_ids'] =
                                  selectedDamTypes.keys.join(',');
                            }
                            if (selectedDamHydrologicalArea.isNotEmpty) {
                              request['hydrological_area_ids'] =
                                  selectedDamHydrologicalArea.keys.join(',');
                            }
                            if (selectedDamRiverBasin.isNotEmpty) {
                              request['river_basin_ids'] =
                                  selectedDamRiverBasin.keys.join(',');
                            }
                            if (selectedDamGeoPoliticalZone.isNotEmpty) {
                              request['geopolitical_zone_ids'] =
                                  selectedDamGeoPoliticalZone.keys.join(',');
                            }
                            if (selectedDamState.isNotEmpty) {
                              request['state_ids'] =
                                  selectedDamState.keys.join(',');
                            }
                            setState(() {});
                            ImagesList = [];
                            await getDams(request: request);

                            // setState(() {});
                            // print(
                            //     'list -------------${selectedDamHydrologicalArea.keys.toList()}');
                            // print(
                            //     'list -------------${selectedDamRiverBasin.keys.toList()}');
                            // print(
                            //     'list -------------${selectedDamGeoPoliticalZone.keys.toList()}');
                            // print(
                            //     'list -------------${selectedDamState.keys.toList()}');
                            //
                            // if (showMapHydro) {
                            //   for (int i = 0;
                            //       i <
                            //           selectedDamHydrologicalArea.keys
                            //               .toList()
                            //               .length;
                            //       i++) {
                            //     print(
                            //         'id--------${selectedDamHydrologicalArea.keys.toList()[i]}');
                            //
                            //     for (int j = 0; j < kMapImages.length; j++) {
                            //       if (kMapImages[j]['mapType'] ==
                            //               'hydrologicalArea' &&
                            //           selectedDamHydrologicalArea.keys
                            //                   .toList()[i]
                            //                   .toString() ==
                            //               kMapImages[j]['id'].toString()) {
                            //         ImagesList.add(kMapImages[j]);
                            //       }
                            //     }
                            //     print('ImagesList--------------${ImagesList}');
                            //   }
                            // }
                            // if (showMapRiver) {
                            //   for (int i = 0;
                            //       i <
                            //           selectedDamRiverBasin.keys
                            //               .toList()
                            //               .length;
                            //       i++) {
                            //     print(
                            //         'id--------${selectedDamRiverBasin.keys.toList()[i]}');
                            //
                            //     for (int j = 0; j < kMapImages.length; j++) {
                            //       if (kMapImages[j]['mapType'] ==
                            //               'river_basin' &&
                            //           selectedDamRiverBasin.keys
                            //                   .toList()[i]
                            //                   .toString() ==
                            //               kMapImages[j]['id'].toString()) {
                            //         ImagesList.add(kMapImages[j]);
                            //       }
                            //     }
                            //     print('ImagesList--------------${ImagesList}');
                            //   }
                            // }
                            // if (showMapGeo) {
                            //   for (int i = 0;
                            //       i <
                            //           selectedDamGeoPoliticalZone.keys
                            //               .toList()
                            //               .length;
                            //       i++) {
                            //     print(
                            //         'id--------${selectedDamGeoPoliticalZone.keys.toList()[i]}');
                            //
                            //     for (int j = 0; j < kMapImages.length; j++) {
                            //       if (kMapImages[j]['mapType'] ==
                            //               'geo_political_zone' &&
                            //           selectedDamGeoPoliticalZone.keys
                            //                   .toList()[i]
                            //                   .toString() ==
                            //               kMapImages[j]['id'].toString()) {
                            //         ImagesList.add(kMapImages[j]);
                            //       }
                            //     }
                            //     print('ImagesList--------------${ImagesList}');
                            //   }
                            // }
                            // if (showMapState) {
                            //   for (int i = 0;
                            //       i < selectedDamState.keys.toList().length;
                            //       i++) {
                            //     print(
                            //         'id--------${selectedDamState.keys.toList()[i]}');
                            //
                            //     for (int j = 0; j < kMapImages.length; j++) {
                            //       if (kMapImages[j]['mapType'] == 'state' &&
                            //           selectedDamState.keys
                            //                   .toList()[i]
                            //                   .toString() ==
                            //               kMapImages[j]['id'].toString()) {
                            //         ImagesList.add(kMapImages[j]);
                            //       }
                            //     }
                            //     print('ImagesList--------------${ImagesList}');
                            //   }
                            // }
                            // setState(() {});
                            setState(() {});
                          },
                          height: 40,
                          borderRadius: 4,
                          fontSize: 18,
                          color: MyColors.purpleColor),
                    ),
                    hSizedBox2,
                    Expanded(
                      child: RoundEdgedButton(
                          text: 'Reset',
                          onTap: () async {
                            await clearFilters();
                          },
                          height: 40,
                          borderRadius: 4,
                          fontSize: 18,
                          color: Color(0xFE9B9B9B)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Container(
              height: 38,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: MyColors.purpleColor, width: 2),
                  bottom: BorderSide(color: MyColors.purpleColor, width: 2),
                  left: BorderSide(color: MyColors.purpleColor, width: 2),
                  right: BorderSide(color: MyColors.purpleColor, width: 2),
                ),
              ),
              child: Material(
                color: MyColors.purpleColor,
                child: TabBar(
                    labelColor: MyColors.purpleColor,
                    unselectedLabelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.zero,
                    mouseCursor: MaterialStateMouseCursor.clickable,
                    indicator: BoxDecoration(color: Colors.white),
                    tabs: [
                      Tooltip(
                        message: 'Click to show Map View',
                        child: Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'MAP VIEW',
                              style: TextStyle(
                                  fontFamily: 'semibold', fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      Tooltip(
                        message: 'Click to show Grid View',
                        child: Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'GRID VIEW',
                              style: TextStyle(
                                  fontFamily: 'semibold', fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      Tooltip(
                        message: 'Click to show List View',
                        child: Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'LIST VIEW',
                              style: TextStyle(
                                  fontFamily: 'semibold', fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16,right:16, top: 10, bottom: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16,right:16,),
                      child: TypeAheadField<Map<String, dynamic>>(
                        textFieldConfiguration: TextFieldConfiguration(
                          autofocus: false,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'regular'),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              // border: InputBorder.none,
                              hintText: 'Search by name, Min 3 Char'),
                        ),
                        suggestionsCallback: (pattern) async {
                          return await SearchingServices.getSuggestions(pattern,'');
                        },
                        itemBuilder: (context, Map<String, dynamic> suggestion) {
                          return Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            child: ParagraphText(
                              text: '${suggestion['name']}',
                              color: Colors.black,
                            ),
                          );
                          return ListTile(
                            leading: Icon(Icons.shopping_cart),
                            title: Text(suggestion['name'] ?? 'd'),
                            subtitle: Text('\$${suggestion['price']}'),
                          );
                        },
                        onSuggestionSelected: (Map<String, dynamic> suggestion) {
                          try {
                            // markers.add(
                            //   Marker(
                            //     point: LatLng(double.parse(suggestion['latitude']),
                            //         double.parse(suggestion['longitude'])),
                            //     height: 95,
                            //     width: 100,
                            //     builder: (context) {
                            //       return GestureDetector(
                            //         onTap: (){
                            //           print('Marker ${suggestion['name']} pressed');
                            //           showDialog(context: context, builder: (context){
                            //             return MarkerInfoWindow(damInfo: suggestion,);
                            //           });
                            //         },
                            //         child: Column(
                            //           children: [
                            //             Expanded(
                            //               child: Container(
                            //                 child: Image.asset(
                            //                   MyImages.markerIcon,
                            //                   fit: BoxFit.fitHeight,
                            //                 ),
                            //               ),
                            //             ),
                            //             Icon(Icons.circle, color: Colors.brown,size: 10,),
                            //             Container(
                            //               height: 10,
                            //               width: 1,
                            //               color: Colors.blue,
                            //             ),
                            //
                            //             Container(
                            //               padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                            //               decoration: BoxDecoration(
                            //                   color: Colors.blue,
                            //                   borderRadius: BorderRadius.circular(20)
                            //               ),
                            //
                            //               child: ParagraphText(text: '${suggestion['name']}', fontSize: 11,color: Colors.white,),
                            //             )
                            //           ],
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // );
                            // setState(() {
                            //
                            // });
                            if (suggestion['latitude'] != '' &&
                                suggestion['longitude'] != '' &&
                                suggestion['latitude'] != null &&
                                suggestion['longitude'] != null) {
                              MyGlobalKeys.mapViewPageKey.currentState
                                  ?.resetLocation(
                                  LatLng(double.parse(suggestion['latitude']),
                                      double.parse(suggestion['longitude'])),
                                  zoom: 17);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return MarkerInfoWindow(
                                      damInfo: suggestion,
                                    );
                                  });
                            } else {
                              showSnackbar('Location coordinates not available');
                            }
                          } catch (e) {
                            print('Error in catch block 182838 $e');
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return MarkerInfoWindow(
                                    damInfo: suggestion,
                                  );
                                });
                          }
                          // Navigator.of(context).push<void>(MaterialPageRoute(
                          //     builder: (context) => ProductPage(product: suggestion)));
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                      child: Container(),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16,right:16, top: 5, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // if(categoryList.length>0)
                  Expanded(
                    flex:4,
                    child:DropDown(islabels:false,
                      items: categoryList.map((e) {
                        return DropdownMenuItem<String>(
                          value: e['name'].toString(),
                          child: Text(e['title'].toString()),
                        );
                      }).toList(),
                      selectedValue: selectedValue=='' ? null :selectedValue,
                      // selectedValue: selectedValue,
                      onChanged: (String? value) {

                        setState(() {
                          isSuggestion=false;
                          selectedValue = value;
                          keyword.text='';
                          selectedSubValue=null;

                          getType(selectedValue);
                        });
                      },
                    ),

                  ),
                  // if(catType=='string' || catType=='number')
                  hSizedBox05,
                  if((catType=='string' || catType=='number') && !isSuggestion )
                  Expanded(
                    flex:4,
                    child: CustomTextField(controller: keyword,hintText: 'Search...',
                    keyboardType:catType=='number'?TextInputType.number:TextInputType.text ,),
                  ),
                  if(catType=='string' || catType=='number' && !isSuggestion)
                  hSizedBox05,
                  if(catType=='bool-number' && !isSuggestion)
                    Expanded(
                      flex:3,
                      child:DropDown(islabels:false,
                        items: StaticDropDown.map((e) {
                          return DropdownMenuItem<String>(
                            value: e['value'].toString(),
                            child: Text(e['name'].toString()),
                          );
                        }).toList(),
                        selectedValue: selectedSubValue=='' ? null :selectedSubValue,
                        // selectedValue: selectedValue,
                        onChanged: (String? value) {

                          setState(() {
                            selectedSubValue = value;
                            // getType(selectedValue);
                          });
                        },
                      ),

                    ),
                  if(catType=='select' && !isSuggestion)
                    Expanded(
                      flex:3,
                      child:DropDown(islabels:false,
                        items: selectList.map((e) {
                          return DropdownMenuItem<String>(
                            value: e['value'].toString(),
                            child: Text(e['title'].toString()),
                          );
                        }).toList(),
                        selectedValue: selectedSubValue=='' ? null :selectedSubValue,
                        // selectedValue: selectedValue,
                        onChanged: (String? value) {

                          setState(() {
                            selectedSubValue = value;
                            // getType(selectedValue);
                          });
                        },
                      ),

                    ),
                  if(catType=='date' && !isSuggestion)
                    Expanded(
                      flex:3,
                      child: GestureDetector(
                        onTap: () async {
                          DateTime? temp = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1977),
                              lastDate: DateTime(2099));
                          // showTimePicker(context: context, initialTime: initialTime)
                          if (temp != null) {
                            dateTime = temp;
                            keyword.text = DateFormat("yyyy-MM-dd")
                                .format(dateTime!)
                                .toString();
                          }
                          setState(() {});
                        },
                        child: CustomTextField(
                          controller: keyword,
                          hintText: 'Select Date',
                          // label: 'Date of birth',
                          showlabel: false,
                          enable: false,
                        ),
                      ),
                    ),
                  if(catType=='year' && !isSuggestion)
                    Expanded(
                      flex:3,
                      child: GestureDetector(
                        onTap: () async {

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Select Year"),
                                content: Container( // Need to use container to add size constraint.
                                  width: 300,
                                  height: 300,
                                  child: YearPicker(
                                    firstDate: DateTime(DateTime.now().year - 100, 1),
                                    lastDate: DateTime(DateTime.now().year + 100, 1),
                                    initialDate: DateTime.now(),
                                    // save the selected date to _selectedDate DateTime variable.
                                    // It's used to set the previous selected date when
                                    // re-showing the dialog.
                                    selectedDate: _selectedDate,
                                    onChanged: (DateTime dateTime) {

                                      setState(() {
                                        _selectedDate=dateTime;
                                        keyword.text=DateFormat.y().format(dateTime);
                                        print('_selectedDate----$_selectedDate');
                                      });
                                      // close the dialog when year is selected.
                                      Navigator.pop(context);

                                      // Do something with the dateTime selected.
                                      // Remember that you need to use dateTime.year to get the year
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: CustomTextField(
                          controller: keyword,
                          hintText: 'Select Year',
                          // label: 'Date of birth',
                          showlabel: false,
                          enable: false,
                        ),
                      ),
                    ),

                  // Expanded(
                  //   flex:2,
                  //   child: RoundEdgedButton(text: '',
                  //   width: 25,
                  //   isIcon:true,
                  //   iconName: Icons.search,
                  //
                  //   onTap: ()async{
                  //     String text = catType=='bool-number' || catType=='select' ? selectedSubValue!:keyword.text;
                  //     String search_field=selectedValue!;
                  //     var res = await SearchingServices.getSuggestions(text,search_field);
                  //     print("res from search----------------$res");
                  //     setState(() {
                  //
                  //     });
                  //   },),
                  //
                  // ),

                  if(isSuggestion)
                    Expanded(
                      flex: 3,
                      child: TypeAheadField<Map<String, dynamic>>(
                        textFieldConfiguration: TextFieldConfiguration(
                          autofocus: false,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'regular'),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              // border: InputBorder.none,
                              hintText: 'Search by name, Min 3 Char'),
                        ),
                        suggestionsCallback: (pattern) async {
                          return await SearchingServices.getSuggestions(pattern,'');
                        },
                        itemBuilder: (context, Map<String, dynamic> suggestion) {
                          return Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            child: ParagraphText(
                              text: '${suggestion['name']}',
                              color: Colors.black,
                            ),
                          );
                          return ListTile(
                            leading: Icon(Icons.shopping_cart),
                            title: Text(suggestion['name'] ?? 'd'),
                            subtitle: Text('\$${suggestion['price']}'),
                          );
                        },
                        onSuggestionSelected: (Map<String, dynamic> suggestion) {
                          try {
                            // markers.add(
                            //   Marker(
                            //     point: LatLng(double.parse(suggestion['latitude']),
                            //         double.parse(suggestion['longitude'])),
                            //     height: 95,
                            //     width: 100,
                            //     builder: (context) {
                            //       return GestureDetector(
                            //         onTap: (){
                            //           print('Marker ${suggestion['name']} pressed');
                            //           showDialog(context: context, builder: (context){
                            //             return MarkerInfoWindow(damInfo: suggestion,);
                            //           });
                            //         },
                            //         child: Column(
                            //           children: [
                            //             Expanded(
                            //               child: Container(
                            //                 child: Image.asset(
                            //                   MyImages.markerIcon,
                            //                   fit: BoxFit.fitHeight,
                            //                 ),
                            //               ),
                            //             ),
                            //             Icon(Icons.circle, color: Colors.brown,size: 10,),
                            //             Container(
                            //               height: 10,
                            //               width: 1,
                            //               color: Colors.blue,
                            //             ),
                            //
                            //             Container(
                            //               padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                            //               decoration: BoxDecoration(
                            //                   color: Colors.blue,
                            //                   borderRadius: BorderRadius.circular(20)
                            //               ),
                            //
                            //               child: ParagraphText(text: '${suggestion['name']}', fontSize: 11,color: Colors.white,),
                            //             )
                            //           ],
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // );
                            // setState(() {
                            //
                            // });
                            if (suggestion['latitude'] != '' &&
                                suggestion['longitude'] != '' &&
                                suggestion['latitude'] != null &&
                                suggestion['longitude'] != null) {
                              MyGlobalKeys.mapViewPageKey.currentState
                                  ?.resetLocation(
                                  LatLng(double.parse(suggestion['latitude']),
                                      double.parse(suggestion['longitude'])),
                                  zoom: 17);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return MarkerInfoWindow(
                                      damInfo: suggestion,
                                    );
                                  });
                            } else {
                              showSnackbar('Location coordinates not available');
                            }
                          } catch (e) {
                            print('Error in catch block 182838 $e');
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return MarkerInfoWindow(
                                    damInfo: suggestion,
                                  );
                                });
                          }
                          // Navigator.of(context).push<void>(MaterialPageRoute(
                          //     builder: (context) => ProductPage(product: suggestion)));
                        },
                      ),
                      // CustomTextField(
                      //     controller: email,
                      //     suffix: Padding(
                      //       padding: const EdgeInsets.only(top: 5),
                      //       child:email.text.length<1?null: IconButton(
                      //         padding: EdgeInsets.zero,
                      //         onPressed: (){
                      //           email.clear();
                      //           damSearchText = email.text;
                      //           setState(() {
                      //
                      //           });
                      //         },
                      //         icon: Icon(Icons.clear),
                      //       ),
                      //     ),
                      //     borderradius: 100,
                      //     onChanged: (val){
                      //       print('hello');
                      //
                      //       if(email.text.length>2){
                      //         damSearchText = email.text;
                      //         var request = {
                      //           'search_text': val
                      //         };
                      //         // setState(() {
                      //         //
                      //         // });
                      //         getDams(request: request).then((d){
                      //           setState(() {
                      //
                      //           });
                      //         });
                      //       }else{
                      //         getDams().then((d){
                      //           setState(() {
                      //
                      //           });
                      //         });
                      //       }
                      //       // setState(() {
                      //       //
                      //       // });
                      //     },
                      //
                      //     hintText: 'Search by name, Min 3 char'),
                    ),
                  hSizedBox05,



                  Flexible(
                    flex: 2,
                      child: GestureDetector(
                        onTap: ()async{
                          String text = catType=='bool-number' || catType=='select' ? selectedSubValue!:keyword.text;
                          String search_field=selectedValue!;
                          setState(() {
                            load=true;
                          });
                          var res = await SearchingServices.getSuggestions(text,search_field);
                          print("res from search----------------$res");
                          setState(() {
                         load=false;
                          });
                        },
                        child: Tooltip(
                          message: 'Search',
                          child: Center(
                            child: Container(
                              height: 50,
                              // padding: EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                  color: Color(0xFED9D9D9),
                                  
                                  borderRadius: BorderRadius.circular(100)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: MyColors.primaryColor,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),









                  hSizedBox05,
                  Flexible(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () => _scaffoldKey.currentState?.openDrawer(),
                        child: Tooltip(
                          message: 'Select Filter for more options',
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xFED9D9D9),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.filter_alt,
                                    color: MyColors.primaryColor,
                                    size: 25,
                                  ),
                                  // MainHeadingText(
                                  //   text: 'Filter',
                                  //   fontFamily: 'regular',
                                  //   color: MyColors.primaryColor,
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                  hSizedBox05,
                  Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: ()async{
                          isSuggestion=false;
                          catType=null;
                          keyword.text='';
                          selectedSubValue=null;
                          selectedValue=null;
                          await clearFilters();
                          setState(() {

                          });
                        },
                        child: Tooltip(
                          message: 'Clear Filters',
                          child: Center(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xFED9D9D9),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: MyColors.primaryColor,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            vSizedBox,

            Expanded(
              child: TabBarView(
                // controller: tabController,
                children: [
                  load?CustomLoader():MapViewHomePage(
                    key: MyGlobalKeys.mapViewPageKey,
                    isViewMap: ImagesList.length > 0 ? true : false,
                    // isViewMap: showMapHydro==true || showMapRiver==true || showMapGeo==true || showMapState==true ?true:false,
                    ViewMap: () async {
                      // for()

                      push(
                          context: context,
                          screen: ZoomImgPage(
                            Images: ImagesList,
                            initialIndex: 0,
                            damName: 'Map View',
                            isNetwork: false,
                          ));
                    },
                  ),
                  // Column(
                  //   children: [
                  //     hSizedBox,
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 16,),
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Expanded(
                  //             flex: 8,
                  //             child: CustomTextField(controller: email, borderradius: 100, hintText: 'Search')
                  //           ),
                  //           wSizedBox05,
                  //           Expanded(
                  //             flex: 4,
                  //             child: GestureDetector(
                  //               onTap: () => _scaffoldKey.currentState?.openDrawer(),
                  //               child: Center(
                  //                 child: Container(
                  //                   height: 50,
                  //                   decoration: BoxDecoration(
                  //                     color: Color(0xFED9D9D9),
                  //                     borderRadius: BorderRadius.circular(100)
                  //                   ),
                  //                   child: Row(
                  //                     crossAxisAlignment: CrossAxisAlignment.center,
                  //                     mainAxisAlignment: MainAxisAlignment.center,
                  //                     children: [
                  //                       Icon(Icons.filter_alt, color: MyColors.primaryColor, size: 25,),
                  //                       MainHeadingText(text: 'Filter', fontFamily: 'regular', color: MyColors.primaryColor,)
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             )
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     hSizedBox2,
                  //     Expanded(child: FlutterMap(
                  //       options: MapOptions(
                  //         center: LatLng(22.7196, 75.8577),
                  //         zoom: 15,
                  //       ),
                  //       nonRotatedChildren: [
                  //       ],
                  //       children: [
                  //         TileLayer(
                  //           urlTemplate:
                  //           'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  //           // userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  //         ),
                  //         // MarkerLayer(markers: markers),
                  //       ],
                  //     )),
                  //   ],
                  // ),
                  GridViewPage(),
                  // SingleChildScrollView(
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 16),
                  //     child: Column(
                  //       children: [
                  //         hSizedBox,
                  //
                  //         ResponsiveGridRow(
                  //             children: [
                  //               for(var i = 0; i < 3; i++)
                  //                 ResponsiveGridCol(
                  //                   xs: 6,
                  //                   child: GestureDetector(
                  //                     // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewsPage())),
                  //                       child: Container(
                  //                         margin: EdgeInsets.all(5),
                  //                         decoration: BoxDecoration(
                  //                             border: Border.all(
                  //                                 color: MyColors.bordercolor,
                  //                                 width: 1
                  //                             )
                  //                         ),
                  //                         child: Column(
                  //                           crossAxisAlignment: CrossAxisAlignment.start,
                  //                           children: [
                  //                             Image.asset('assets/images/dam.png'),
                  //                             Padding(
                  //                               padding: EdgeInsets.all(10),
                  //                               child: Column(
                  //                                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                                 children: [
                  //                                   MainHeadingText(text: 'SHIRORO DAM', fontSize: 15,),
                  //                                   hSizedBox,
                  //                                   Text.rich(
                  //                                     TextSpan(
                  //                                       text: 'Type: ',
                  //                                       style: TextStyle(fontSize: 11, color: Colors.black, fontFamily: 'light' ),
                  //                                       children: <TextSpan>[
                  //                                         TextSpan(
                  //                                             text: '130,000',
                  //                                             style: TextStyle(
                  //                                                 color: Colors.black,
                  //                                                 fontFamily: 'semibold',
                  //                                                 fontSize: 11,
                  //                                                 height: 1.3
                  //                                             )
                  //                                         ),
                  //                                         // can add more TextSpans here...
                  //                                       ],
                  //                                     ),
                  //                                   ),
                  //                                   Text.rich(
                  //                                     TextSpan(
                  //                                       text: 'Category: ',
                  //                                       style: TextStyle(fontSize: 11, color: Colors.black, fontFamily: 'light' ),
                  //                                       children: <TextSpan>[
                  //                                         TextSpan(
                  //                                             text: 'large',
                  //                                             style: TextStyle(
                  //                                                 color: Colors.black,
                  //                                                 fontFamily: 'semibold',
                  //                                                 fontSize: 11,
                  //                                                 height: 1.3
                  //                                             )
                  //                                         ),
                  //                                         // can add more TextSpans here...
                  //                                       ],
                  //                                     ),
                  //                                   ),
                  //                                   Text.rich(
                  //                                     TextSpan(
                  //                                       text: 'Location: ',
                  //                                       style: TextStyle(fontSize: 11, color: Colors.black, fontFamily: 'light' ),
                  //                                       children: <TextSpan>[
                  //                                         TextSpan(
                  //                                             text: 'Shiroro, Niger State',
                  //                                             style: TextStyle(
                  //                                                 color: Colors.black,
                  //                                                 fontFamily: 'semibold',
                  //                                                 fontSize: 11,
                  //                                                 height: 1.3
                  //                                             )
                  //                                         ),
                  //                                         // can add more TextSpans here...
                  //                                       ],
                  //                                     ),
                  //                                   ),
                  //                                   hSizedBox,
                  //                                   Row(
                  //                                     mainAxisAlignment: MainAxisAlignment.end,
                  //                                     children: [
                  //                                       GestureDetector(
                  //                                           child: Container(
                  //                                             decoration: BoxDecoration(
                  //                                                 color: MyColors.primaryColor,
                  //                                                 borderRadius: BorderRadius.circular(5)
                  //                                             ),
                  //                                             padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  //                                             child: MainHeadingText(text: 'Details', fontSize: 12, color: MyColors.whiteColor, fontFamily: 'semibold',),
                  //                                           ),
                  //                                           onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage()))
                  //                                       )
                  //                                     ],
                  //                                   )
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       )
                  //                   ),
                  //                 )
                  //             ]
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  ListViewHomePage(),
                  // SingleChildScrollView(
                  //   child: Column(
                  //     children: [
                  //       hSizedBox,
                  //
                  //       Table(
                  //         children: [
                  //           TableRow(
                  //               decoration: BoxDecoration(
                  //                 color: MyColors.primaryColor,
                  //               ),
                  //               children: [
                  //                 Padding(
                  //                   padding: const EdgeInsets.all(10),
                  //                   child: MainHeadingText(text: 'Dam Name', fontSize: 12, color: MyColors.whiteColor,),
                  //                 ),
                  //                 Padding(
                  //                   padding: const EdgeInsets.all(10),
                  //                   child: MainHeadingText(text: 'Category', fontSize: 12, color: MyColors.whiteColor,),
                  //                 ),
                  //                 Padding(
                  //                   padding: const EdgeInsets.all(10),
                  //                   child: MainHeadingText(text: 'TYPE', fontSize: 12, color: MyColors.whiteColor,),
                  //                 ),
                  //                 Padding(
                  //                   padding: const EdgeInsets.all(10),
                  //                   child: MainHeadingText(text: 'RIVER', fontSize: 12, color: MyColors.whiteColor,),
                  //                 ),
                  //                 Container(
                  //                   width: 150,
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.all(10),
                  //                     child: MainHeadingText(text: '', fontSize: 12, color: MyColors.whiteColor,),
                  //                   ),
                  //                 ),
                  //               ]
                  //           ),
                  //           for(var i=0; i <30; i++)
                  //             TableRow(
                  //                 decoration: BoxDecoration(
                  //                   color: MyColors.whiteColor,
                  //                 ),
                  //                 children: [
                  //                   Padding(
                  //                     padding: const EdgeInsets.all(10),
                  //                     child: MainHeadingText(text: 'SHIRORO DAM ', fontSize: 12,),
                  //                   ),
                  //                   Padding(
                  //                     padding: const EdgeInsets.all(10),
                  //                     child: MainHeadingText(text: 'Large', fontSize: 12,),
                  //                   ),
                  //                   Padding(
                  //                     padding: const EdgeInsets.all(10),
                  //                     child: MainHeadingText(text: 'EARTHFILL', fontSize: 12,),
                  //                   ),
                  //                   Padding(
                  //                     padding: const EdgeInsets.all(10),
                  //                     child: MainHeadingText(text: 'ADADA', fontSize: 12,),
                  //                   ),
                  //                   Padding(
                  //                     padding: const EdgeInsets.all(10),
                  //                     child: GestureDetector(
                  //                       onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage())),
                  //                       child: Container(
                  //                         decoration: BoxDecoration(
                  //                             color: MyColors.primaryColor,
                  //                             borderRadius: BorderRadius.circular(5)
                  //                         ),
                  //                         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  //                         child: Center(child: MainHeadingText(text: 'Details', fontSize: 12, color: MyColors.whiteColor, fontFamily: 'semibold',)),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ]
                  //             ),
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}