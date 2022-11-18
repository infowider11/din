import 'dart:math';

import 'package:din/constants/colors.dart';
import 'package:din/constants/global_data.dart';
import 'package:din/constants/image_urls.dart';
import 'package:din/constants/navigation.dart';
import 'package:din/constants/sized_box.dart';
import 'package:din/detail.dart';
import 'package:din/functions/get_current_location.dart';
import 'package:din/pages/about_us_page.dart';
import 'package:din/pages/grid_view_page.dart';
import 'package:din/pages/list_view_home_page.dart';
import 'package:din/pages/map_page.dart';
import 'package:din/pages/map_view_home_page.dart';
import 'package:din/pages/marker_info_page.dart';
import 'package:din/pages/zoomImg.dart';
import 'package:din/services/api_urls.dart';
import 'package:din/services/home_page_services.dart';
import 'package:din/services/webservices.dart';
import 'package:din/widgets/CustomTexts.dart';
import 'package:din/widgets/buttons.dart';
import 'package:din/widgets/customtextfield.dart';
import 'package:din/widgets/dropdown.dart';
import 'package:din/widgets/showSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:latlong2/latlong.dart';
import 'package:responsive_grid/responsive_grid.dart';

import 'constants/ImagesList.dart';
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
  bool load = false;
  bool showMapHydro = false;
  bool showMapState = false;
  bool showMapRiver = false;
  bool showMapGeo = false;
  bool showMap = false;
  List ViewFilterImg = [];
  List ImagesList = [];
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

    selectedDamCategories = {};
    // getDams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        ' ffffff ${!selectedkdamBakamType.containsKey(2) || selectedkdamBakamType.length != 1}  ${selectedkdamBakamType.containsKey(2)} ${selectedkdamBakamType.length}');
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MyColors.whiteColor,
      appBar: AppBar(
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
        title: const Text('Home',
            style: TextStyle(color: Colors.black, fontFamily: 'semibold')),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a Notification')));
            },
          ),
        ],
      ),
      drawer: Drawer(
        // width:MediaQuery.of(context).size.width-164,
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
                            hSizedBox,
                            for (int i = 0; i < kdamBakamType.length; i++)
                              Row(
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
                                  wSizedBox05,
                                  Expanded(
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
                        if (!selectedkdamBakamType.containsKey(2) ||
                            selectedkdamBakamType.length != 1)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MainHeadingText(
                                text: 'SIZE(Category)',
                                fontSize: 16,
                              ),
                              hSizedBox,
                              for (int i = 0; i < kdamCategories.length; i++)
                                Row(
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
                                    wSizedBox05,
                                    MainHeadingText(
                                      text: '${kdamCategories[i]['name']}',
                                      fontSize: 14,
                                      fontFamily: 'light',
                                    )
                                  ],
                                ),
                            ],
                          ),
                        if (!selectedkdamBakamType.containsKey(2) ||
                            selectedkdamBakamType.length != 1)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              hSizedBox2,
                              MainHeadingText(
                                text: 'TYPE',
                                fontSize: 16,
                              ),
                              hSizedBox,
                              for (int i = 0; i < kdamTypes.length; i++)
                                Row(
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
                                    wSizedBox05,
                                    Expanded(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            hSizedBox2,
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
                            hSizedBox,
                            for (int i = 0;
                                i < kdamHydrologicalArea.length;
                                i++)
                              Row(
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
                                  wSizedBox05,
                                  Expanded(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            hSizedBox2,
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
                            hSizedBox,
                            for (int i = 0; i < kdamRiver_basin.length; i++)
                              Row(
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
                                  wSizedBox05,
                                  Expanded(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            hSizedBox2,
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
                            hSizedBox,
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
                                  wSizedBox05,
                                  Expanded(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            hSizedBox2,
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
                            hSizedBox,
                            for (int i = 0; i < kstate.length; i++)
                              Row(
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
                                  wSizedBox05,
                                  Expanded(
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
                        hSizedBox8,
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

                            await getDams(request: request);
                            ImagesList = [];
                            setState(() {});
                            print(
                                'list -------------${selectedDamHydrologicalArea.keys.toList()}');
                            print(
                                'list -------------${selectedDamRiverBasin.keys.toList()}');
                            print(
                                'list -------------${selectedDamGeoPoliticalZone.keys.toList()}');
                            print(
                                'list -------------${selectedDamState.keys.toList()}');

                            if (showMapHydro) {
                              for (int i = 0;
                                  i <
                                      selectedDamHydrologicalArea.keys
                                          .toList()
                                          .length;
                                  i++) {
                                print(
                                    'id--------${selectedDamHydrologicalArea.keys.toList()[i]}');

                                for (int j = 0; j < MapImages.length; j++) {
                                  if (MapImages[j]['mapType'] ==
                                          'hydrologicalArea' &&
                                      selectedDamHydrologicalArea.keys
                                              .toList()[i]
                                              .toString() ==
                                          MapImages[j]['id'].toString()) {
                                    ImagesList.add(MapImages[j]);
                                  }
                                }
                                print('ImagesList--------------${ImagesList}');
                              }
                            }
                            if (showMapRiver) {
                              for (int i = 0;
                                  i <
                                      selectedDamRiverBasin.keys
                                          .toList()
                                          .length;
                                  i++) {
                                print(
                                    'id--------${selectedDamRiverBasin.keys.toList()[i]}');

                                for (int j = 0; j < MapImages.length; j++) {
                                  if (MapImages[j]['mapType'] ==
                                          'river_basin' &&
                                      selectedDamRiverBasin.keys
                                              .toList()[i]
                                              .toString() ==
                                          MapImages[j]['id'].toString()) {
                                    ImagesList.add(MapImages[j]);
                                  }
                                }
                                print('ImagesList--------------${ImagesList}');
                              }
                            }
                            if (showMapGeo) {
                              for (int i = 0;
                                  i <
                                      selectedDamGeoPoliticalZone.keys
                                          .toList()
                                          .length;
                                  i++) {
                                print(
                                    'id--------${selectedDamGeoPoliticalZone.keys.toList()[i]}');

                                for (int j = 0; j < MapImages.length; j++) {
                                  if (MapImages[j]['mapType'] ==
                                          'geo_political_zone' &&
                                      selectedDamGeoPoliticalZone.keys
                                              .toList()[i]
                                              .toString() ==
                                          MapImages[j]['id'].toString()) {
                                    ImagesList.add(MapImages[j]);
                                  }
                                }
                                print('ImagesList--------------${ImagesList}');
                              }
                            }
                            if (showMapState) {
                              for (int i = 0;
                                  i < selectedDamState.keys.toList().length;
                                  i++) {
                                print(
                                    'id--------${selectedDamState.keys.toList()[i]}');

                                for (int j = 0; j < MapImages.length; j++) {
                                  if (MapImages[j]['mapType'] == 'state' &&
                                      selectedDamState.keys
                                              .toList()[i]
                                              .toString() ==
                                          MapImages[j]['id'].toString()) {
                                    ImagesList.add(MapImages[j]);
                                  }
                                }
                                print('ImagesList--------------${ImagesList}');
                              }
                            }
                            setState(() {});
                            setState(() {});
                          },
                          height: 40,
                          borderRadius: 4,
                          fontSize: 18,
                          color: MyColors.purpleColor),
                    ),
                    wSizedBox2,
                    Expanded(
                      child: RoundEdgedButton(
                          text: 'Reset',
                          onTap: () async {
                            _scaffoldKey.currentState?.closeDrawer();
                            selectedDamCategories.clear();
                            selectedkdamBakamType.clear();
                            selectedDamTypes.clear();
                            selectedDamHydrologicalArea.clear();
                            selectedDamRiverBasin.clear();
                            selectedDamGeoPoliticalZone.clear();
                            selectedDamState.clear();
                            showMapState = false;
                            showMapRiver = false;
                            showMapGeo = false;
                            showMapHydro = false;
                            ImagesList=[];


                            await getDams();
                            setState(() {});
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
              height: 50,
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 8,
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
                        return await SearchingServices.getSuggestions(pattern);
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
                  wSizedBox05,
                  Expanded(
                      flex: 4,
                      child: GestureDetector(
                        onTap: () => _scaffoldKey.currentState?.openDrawer(),
                        child: Tooltip(
                          message: 'Select for more options',
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
                                    Icons.filter_alt,
                                    color: MyColors.primaryColor,
                                    size: 25,
                                  ),
                                  MainHeadingText(
                                    text: 'Filter',
                                    fontFamily: 'regular',
                                    color: MyColors.primaryColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            // Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            //     child: TypeAheadField<Map<String,dynamic>>(
            //       textFieldConfiguration: TextFieldConfiguration(
            //         autofocus: true,
            //         style: TextStyle(color: Colors.black, fontSize: 13, fontFamily: 'regular'),
            //         decoration: InputDecoration(
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(20),
            //
            //             ),
            //             // border: InputBorder.none,
            //             hintText: 'Search by name, Min 3 Char'),
            //       ),
            //       suggestionsCallback: (pattern) async {
            //
            //         return await SearchingServices.getSuggestions(pattern);
            //       },
            //       itemBuilder: (context, Map<String, dynamic> suggestion) {
            //         return Container(
            //           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            //           child: ParagraphText(text: '${suggestion['name']}', color: Colors.black,),
            //         );
            //         return ListTile(
            //           leading: Icon(Icons.shopping_cart),
            //           title: Text(suggestion['name']??'d'),
            //           subtitle: Text('\$${suggestion['price']}'),
            //         );
            //       },
            //       onSuggestionSelected: (Map<String, dynamic> suggestion) {
            //         Navigator.of(context).push<void>(MaterialPageRoute(
            //             builder: (context) => ProductPage(product: suggestion)));
            //       },
            //     ),
            // ),
            hSizedBox,

            Expanded(
              child: TabBarView(
                // controller: tabController,
                children: [
                  MapViewHomePage(
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

class ProductPage extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Text(
              this.product['name']!,
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              this.product['price']! + ' USD',
              style: Theme.of(context).textTheme.subtitle1,
            )
          ],
        ),
      ),
    );
  }
}
