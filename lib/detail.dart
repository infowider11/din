import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:din/constants/colors.dart';
import 'package:din/constants/sized_box.dart';
import 'package:din/services/api_urls.dart';
import 'package:din/services/webservices.dart';
import 'package:din/widgets/CustomTexts.dart';
import 'package:din/widgets/buttons.dart';
import 'package:din/widgets/custom_circular_image.dart';
import 'package:din/widgets/customloader.dart';
import 'package:din/widgets/customtextfield.dart';
import 'package:din/widgets/info.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final int damId;
  const DetailPage({Key? key, required this.damId}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _current = 0;

  final CarouselController carousalController = CarouselController();
  TextEditingController email = TextEditingController();
  bool load = false;
  Map? damDetails;
  getDamDetails() async {
    setState(() {
      load = true;
    });
    var request = {'id': widget.damId.toString()};
    var jsonResponse = await Webservices.postData(
        apiUrl: ApiUrls.getDamDetails, request: request, isGetMethod: true);
    if (jsonResponse['status'] == 1) {
      damDetails = jsonResponse['data'];
    }
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getDamDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('the dam details are ${widget.damId}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.whiteColor,
        elevation: 1,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.chevron_left_rounded, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('${damDetails?['name']}',
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
      body: load
          ? CustomLoader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CarouselSlider(
                        items: damDetails?['damImg'].map<Widget>((item) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomCircularImage(
                                    imageUrl: item['path'],
                                    width: MediaQuery.of(context).size.width,
                                    height: 230,
                                    borderRadius: 5,
                                  ),
                                ],
                              );
                            },
                          );
                        }).toList(),
                        carouselController: carousalController,
                        options: CarouselOptions(
                            height: 230,
                            enlargeCenterPage: false,
                            aspectRatio: 1,
                            autoPlay: false,
                            autoPlayInterval: Duration(seconds: 10),
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                      ),
                      Positioned(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    if (_current == 0) {
                                      carousalController.previousPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                    } else if (_current == 1) {
                                      carousalController.previousPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                    } else if (_current == 2) {
                                      carousalController.previousPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                    } else if (_current == 3) {
                                      carousalController.previousPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                    } else if (_current == 4) {
                                      carousalController.previousPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                    }
                                  },
                                  child: Image.asset(
                                    'assets/images/arrow-left.png',
                                    width: 45,
                                  )),
                              wSizedBox4,
                              GestureDetector(
                                  onTap: () {
                                    if (_current == 0) {
                                      carousalController.nextPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                    } else if (_current == 1) {
                                      carousalController.nextPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                    } else if (_current == 2) {
                                      carousalController.nextPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                    } else if (_current == 3) {
                                      carousalController.nextPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                    } else if (_current == 4) {
                                      carousalController.nextPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                    }
                                  },
                                  child: Image.asset(
                                    'assets/images/arrow-right.png',
                                    width: 45,
                                  )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListInfo(
                                      heading: 'Category:',
                                      subheading: ' ${damDetails?['catName']}'),
                                  ListInfo(
                                      heading: 'Hydrological Area:',
                                      subheading:
                                          ' ${damDetails?['damHydAreaName']}'),
                                  ListInfo(
                                      heading: 'River:',
                                      subheading:
                                          ' ${damDetails?['riverName']}'),
                                  ListInfo(
                                      heading: 'River Basin:',
                                      subheading:
                                          ' ${damDetails?['riverBasinName']}'),
                                  ListInfo(
                                      heading: 'Volume of Material:',
                                      subheading:
                                          ' ${damDetails?['volume_of_material']}'),
                                  ListInfo(
                                      heading: 'Reservoir Area:',
                                      subheading:
                                          ' ${damDetails?['reservoir_area']}'),
                                  ListInfo(
                                      heading: 'Reservoir Capacity:',
                                      subheading:
                                          ' ${damDetails?['reservoir_capacity']}'),
                                  ListInfo(
                                      heading: 'Instrumentation:',
                                      subheading:
                                          ' ${damDetails?['instrumentationName']}'),
                                  ListInfo(
                                      heading: 'Others:',
                                      subheading: ' ${damDetails?['others']}'),
                                  ListInfo(
                                      heading: 'Commencement Date:',
                                      subheading:
                                          ' ${damDetails?['commencement_date']}'),
                                  ListInfo(
                                      heading: 'Duration:',
                                      subheading:
                                          ' ${damDetails?['duration']}'),
                                  ListInfo(
                                      heading: 'Status:',
                                      subheading: ' ${damDetails?['status']}'),
                                  ListInfo(
                                      heading: 'Completion Date:',
                                      subheading:
                                          ' ${damDetails?['completion_date']}'),
                                  ListInfo(
                                      heading: 'Owner:',
                                      subheading: ' ${damDetails?['owner']}'),
                                  ListInfo(
                                      heading: 'Operator:',
                                      subheading:
                                          ' ${damDetails?['operator']}'),
                                  ListInfo(
                                      heading: 'Consultant:',
                                      subheading:
                                          ' ${damDetails?['consultant']}'),
                                  ListInfo(
                                      heading: 'Contractor:',
                                      subheading:
                                          ' ${damDetails?['contractor']}'),
                                  ListInfo(
                                      heading: 'Local Govt Area:',
                                      subheading:
                                          ' ${damDetails?['local_govt_area']}'),
                                  ListInfo(
                                      heading: 'State:',
                                      subheading:
                                          ' ${damDetails?['stateName']}'),
                                  ListInfo(
                                      heading: 'Geopolitical Zone:',
                                      subheading:
                                          ' ${damDetails?['geoPoliticalZoneName']}'),
                                ],
                              ),
                            ),
                            wSizedBox2,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListInfo(
                                      heading: 'Type:',
                                      subheading:
                                          ' ${damDetails?['damTypeName']}'),
                                  ListInfo(
                                      heading: 'Latitude:',
                                      subheading:
                                          ' ${damDetails?['latitude']}'),
                                  ListInfo(
                                      heading: 'Longitude:',
                                      subheading:
                                          ' ${damDetails?['longitude']}'),
                                  ListInfo(
                                      heading: 'Altitude:',
                                      subheading:
                                          ' ${damDetails?['altitude']}'),
                                  ListInfo(
                                      heading: 'Crest Width:',
                                      subheading:
                                          ' ${damDetails?['crest_width']}'),
                                  ListInfo(
                                      heading: 'Crest Length:',
                                      subheading:
                                          ' ${damDetails?['crest_length']}'),
                                  ListInfo(
                                      heading: 'Up Slope:',
                                      subheading:
                                          ' ${damDetails?['up_slope']}'),
                                  ListInfo(
                                      heading: 'Down Slope:',
                                      subheading:
                                          ' ${damDetails?['down_slope']}'),
                                  ListInfo(
                                      heading: 'Others:',
                                      subheading: ' ${damDetails?['others']}'),
                                  ListInfo(
                                      heading: 'Spillway Type:',
                                      subheading:
                                          ' ${damDetails?['spillwayTypeName']}'),
                                  ListInfo(
                                      heading: 'Spill Capacity:',
                                      subheading:
                                          ' ${damDetails?['spill_capacity']}'),
                                  ListInfo(
                                      heading: 'Irrigation:',
                                      subheading:
                                          ' ${damDetails?['irrigation'] == '1' ? 'Yes' : 'No'}'),
                                  ListInfo(
                                      heading: 'Water Supply:',
                                      subheading:
                                          ' ${damDetails?['water_Supply'] == '1' ? 'Yes' : 'No'}'),
                                  ListInfo(
                                      heading: 'Flood Control:',
                                      subheading:
                                          ' ${damDetails?['flood_control'] == '1' ? 'Yes' : 'No'}'),
                                  ListInfo(
                                      heading: 'Hydro Electricity:',
                                      subheading:
                                          ' ${damDetails?['hydro_electricity'] == '1' ? 'Yes' : 'No'}'),
                                  ListInfo(
                                      heading: 'Electric Capacity:',
                                      subheading:
                                          ' ${damDetails?['electric_capacity']}'),
                                  ListInfo(
                                      heading: 'Recreation:',
                                      subheading:
                                          ' ${damDetails?['recreation'] == '1' ? 'Yes' : 'No'}'),
                                  ListInfo(
                                      heading: 'Pollution Control:',
                                      subheading:
                                          ' ${damDetails?['pollution_control'] == '1' ? 'Yes' : 'No'}'),
                                  ListInfo(
                                      heading: 'Livestock:',
                                      subheading:
                                          ' ${damDetails?['livestock'] == '1' ? 'Yes' : 'No'}'),
                                  ListInfo(
                                      heading: 'Fishery/Fishing:',
                                      subheading:
                                          ' ${damDetails?['fishery_fishing'] == '1' ? 'Yes' : 'No'}'),
                                ],
                              ),
                            )
                          ],
                        ),
                        hSizedBox2,
                        RoundEdgedButton(
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => SimpleDialog(
                              backgroundColor: Colors.transparent,
                              // title:const Text('GeeksforGeeks'),
                              children: [
                                Container(
                                  width: 450,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xFEFAFAFA),
                                  ),
                                  child: Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 55,
                                            decoration: BoxDecoration(
                                                color: MyColors.purpleColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                )),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                MainHeadingText(
                                                  text: 'Download Form',
                                                  textAlign: TextAlign.center,
                                                  fontSize: 18,
                                                  color: MyColors.whiteColor,
                                                ),
                                                Positioned(
                                                  right: 5,
                                                  child: GestureDetector(
                                                    child: Icon(
                                                      Icons.close,
                                                      color:
                                                          MyColors.whiteColor,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                MainHeadingText(
                                                  text:
                                                      'Please enter your personal detail',
                                                  fontSize: 15,
                                                ),
                                                hSizedBox2,
                                                CustomTextField(
                                                    controller: email,
                                                    labelfontfamily: 'regular',
                                                    height: 40,
                                                    borderradius: 5,
                                                    label: 'Name',
                                                    showlabel: true,
                                                    hintText:
                                                        'Please enter your name'),
                                                hSizedBox,
                                                CustomTextField(
                                                    controller: email,
                                                    labelfontfamily: 'regular',
                                                    height: 40,
                                                    borderradius: 5,
                                                    label: 'Email',
                                                    showlabel: true,
                                                    hintText:
                                                        'Please enter your Email id'),
                                                hSizedBox,
                                                CustomTextField(
                                                    controller: email,
                                                    labelfontfamily: 'regular',
                                                    height: 40,
                                                    borderradius: 5,
                                                    label: 'Phone Number',
                                                    showlabel: true,
                                                    hintText:
                                                        'Please enter your phone number'),
                                                hSizedBox2,
                                                Center(
                                                    child: RoundEdgedButton(
                                                        onTap: () => {
                                                              Navigator.pop(
                                                                  context),
                                                              showDialog<
                                                                  String>(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    SimpleDialog(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          450,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: Color(
                                                                            0xFEFAFAFA),
                                                                      ),
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              16),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Column(
                                                                            children: [
                                                                              Image.asset(
                                                                                'assets/images/check.png',
                                                                                width: 150,
                                                                              ),
                                                                              hSizedBox2,
                                                                              MainHeadingText(
                                                                                fontFamily: 'light',
                                                                                height: 1.3,
                                                                                text: 'thank you for download, admin will send you download link on your email address within one business day',
                                                                                fontSize: 16,
                                                                                color: MyColors.headingcolor,
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                              hSizedBox2,
                                                                              RoundEdgedButton(onTap: () => Navigator.pop(context), text: 'Close', width: 150, height: 40, borderRadius: 4, fontSize: 18, color: MyColors.purpleColor),
                                                                              hSizedBox
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            },
                                                        text: 'Submit',
                                                        width: 150,
                                                        height: 40,
                                                        borderRadius: 4,
                                                        fontSize: 18,
                                                        color: MyColors
                                                            .purpleColor))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          text: 'Download',
                          width: 170,
                          height: 40,
                          borderRadius: 4,
                          fontSize: 18,
                          color: MyColors.purpleColor,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
