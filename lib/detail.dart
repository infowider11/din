import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:din/constants/colors.dart';
import 'package:din/constants/navigation.dart';
import 'package:din/constants/sized_box.dart';
import 'package:din/dialogs/download_form_dialog.dart';
import 'package:din/pages/viewImages.dart';
import 'package:din/services/api_urls.dart';
import 'package:din/services/webservices.dart';
import 'package:din/widgets/CustomTexts.dart';
import 'package:din/widgets/buttons.dart';
import 'package:din/widgets/custom_circular_image.dart';
import 'package:din/widgets/customloader.dart';
import 'package:din/widgets/customtextfield.dart';
import 'package:din/widgets/info.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
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
  TextEditingController name = TextEditingController();
  TextEditingController idsTextController = TextEditingController();
  // TextEditingController phone = TextEditingController();

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
                                  Stack(
                                    children: [
                                      Container(
                                        height:230,
                                        child:  PhotoViewGallery.builder(
                                          scrollPhysics: const BouncingScrollPhysics(),
                                          builder: (BuildContext context, int index) {
                                            return PhotoViewGalleryPageOptions(
                                              imageProvider: NetworkImage(item['path']),
                                              initialScale: PhotoViewComputedScale.contained * 0.8,
                                              heroAttributes: PhotoViewHeroAttributes(tag: 1),
                                            );
                                          },
                                          itemCount:1,
                                          loadingBuilder: (context, event) => Center(
                                            child: Container(
                                              width: 20.0,
                                              height: 20.0,
                                              child: CircularProgressIndicator(
                                                value: event == null
                                                    ? 0
                                                    : 55,
                                              ),
                                            ),
                                          ),
                                          // backgroundDecoration: widget.backgroundDecoration,
                                          // pageController: widget.pageController,
                                          // onPageChanged: onPageChanged,
                                        )
                                          // backgroundDecoration: widget.backgroundDecoration,
                                          // pageController: widget.pageController,
                                          // onPageChanged: onPageChanged,
                                        ),
                                      if(item['is_satellite'].toString()=='1')
                                        Positioned(
                                            right:16,
                                            bottom: 16,
                                            child: Text('Satellite Image',style: TextStyle(color: Colors.white),))
                                    ],
                                  ),
                                  // ),





                                  // CustomCircularImage(
                                  //   imageUrl: item['path'],
                                  //   width: MediaQuery.of(context).size.width,
                                  //   height: 230,
                                  //   borderRadius: 5,
                                  // ),
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
                    // Container(
                    //   height: 300,
                    //     child: PhotoViewGallery.builder(
                    //       scrollPhysics: const BouncingScrollPhysics(),
                    //       builder: (BuildContext context, int index) {
                    //         return PhotoViewGalleryPageOptions(
                    //           imageProvider: AssetImage('assets/images/check.png'),
                    //           initialScale: PhotoViewComputedScale.contained * 0.8,
                    //           heroAttributes: PhotoViewHeroAttributes(tag: 1),
                    //         );
                    //       },
                    //       itemCount:5,
                    //       loadingBuilder: (context, event) => Center(
                    //         child: Container(
                    //           width: 20.0,
                    //           height: 20.0,
                    //           child: CircularProgressIndicator(
                    //             value: event == null
                    //                 ? 0
                    //                 : 55,
                    //           ),
                    //         ),
                    //       ),
                    //       // backgroundDecoration: widget.backgroundDecoration,
                    //       // pageController: widget.pageController,
                    //       // onPageChanged: onPageChanged,
                    //     )
                    // ),
                        hSizedBox2,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(

                              children: [
                                RoundEdgedButton(text: 'View Images',
                                  width: 260,
                                  height: 44,
                                  borderRadius: 4,
                                  fontSize: 16,
                                  color: MyColors.purpleColor,
                                  verticalPadding: 4,
                                  horizontalPadding: 4,
                                  onTap: (){
                                    push(context: context, screen: ViewOnlinePage(damId: widget.damId.toString(), damName:damDetails?['name'],));
                                  },),
                                hSizedBox,
                                RoundEdgedButton(text: 'Download Selected Images',
                                  width: 260,
                                  height: 44,
                                  borderRadius: 4,
                                  fontSize: 16,
                                  color: MyColors.purpleColor,
                                  verticalPadding: 4,
                                  horizontalPadding: 0,
                                  onTap: (){
                                    push(context: context, screen: ViewOnlinePage(damId: widget.damId.toString(), damName:damDetails?['name'],withDownloadOption: true,));
                                  },),
                                hSizedBox,
                                RoundEdgedButton(
                                  onTap: () => showDialog<String>(
                                    context: context,
                                    // builder: (BuildContext context) => SimpleDialog(
                                    //   backgroundColor: Colors.transparent,
                                    //   // title:const Text('GeeksforGeeks'),
                                    //   children: [
                                    //     Container(
                                    //       width: 450,
                                    //       decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(5),
                                    //         color: Color(0xFEFAFAFA),
                                    //       ),
                                    //       child: Column(
                                    //         children: [
                                    //           Column(
                                    //             crossAxisAlignment:
                                    //                 CrossAxisAlignment.start,
                                    //             children: [
                                    //               Container(
                                    //                 height: 55,
                                    //                 decoration: BoxDecoration(
                                    //                     color: MyColors.purpleColor,
                                    //                     borderRadius: BorderRadius.only(
                                    //                       topLeft: Radius.circular(5),
                                    //                       topRight: Radius.circular(5),
                                    //                     )),
                                    //                 width: MediaQuery.of(context)
                                    //                     .size
                                    //                     .width,
                                    //                 child: Stack(
                                    //                   alignment: Alignment.center,
                                    //                   children: [
                                    //                     MainHeadingText(
                                    //                       text: 'Download Form',
                                    //                       textAlign: TextAlign.center,
                                    //                       fontSize: 18,
                                    //                       color: MyColors.whiteColor,
                                    //                     ),
                                    //                     Positioned(
                                    //                       right: 5,
                                    //                       child: GestureDetector(
                                    //                         onTap: (){
                                    //                           Navigator.pop(context);
                                    //                         },
                                    //                         child: Icon(
                                    //                           Icons.close,
                                    //                           color:
                                    //                               MyColors.whiteColor,
                                    //                         ),
                                    //                       ),
                                    //                     )
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //               Padding(
                                    //                 padding: EdgeInsets.all(16),
                                    //                 child: Column(
                                    //                   crossAxisAlignment:
                                    //                       CrossAxisAlignment.start,
                                    //                   children: [
                                    //                     MainHeadingText(
                                    //                       text:
                                    //                           'Please enter your personal detail',
                                    //                       fontSize: 15,
                                    //                     ),
                                    //                     hSizedBox2,
                                    //                     CustomTextField(
                                    //                         controller: name,
                                    //                         labelfontfamily: 'regular',
                                    //                         height: 40,
                                    //                         borderradius: 5,
                                    //                         label: 'Name',
                                    //                         showlabel: true,
                                    //                         hintText:
                                    //                             'Please enter your name'),
                                    //                     hSizedBox,
                                    //                     CustomTextField(
                                    //                         controller: email,
                                    //                         labelfontfamily: 'regular',
                                    //                         height: 40,
                                    //                         borderradius: 5,
                                    //                         label: 'Email',
                                    //                         showlabel: true,
                                    //                         hintText:
                                    //                             'Please enter your Email id'),
                                    //                     hSizedBox,
                                    //                     CustomTextField(
                                    //                         controller: idsTextController,
                                    //                         labelfontfamily: 'regular',
                                    //                         height: 40,
                                    //                         borderradius: 5,
                                    //                         label: 'Dam/Weir Ids',
                                    //                         showlabel: true,
                                    //                         hintText:
                                    //                             'Ex: (21,22)'),
                                    //                     // hSizedBox,
                                    //                     // CustomTextField(
                                    //                     //     controller: phone,
                                    //                     //     labelfontfamily: 'regular',
                                    //                     //     height: 40,
                                    //                     //     borderradius: 5,
                                    //                     //     label: 'Phone Number',
                                    //                     //     showlabel: true,
                                    //                     //      keyboardType: TextInputType.number,
                                    //                     //     hintText:
                                    //                     //         'Please enter your phone number'),
                                    //                     hSizedBox2,
                                    //                     Center(
                                    //                         child: RoundEdgedButton(
                                    //
                                    //                             onTap: ()  async{
                                    //                             String pattern =
                                    //                             r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    //                             RegExp regex = new RegExp(pattern);
                                    //                         String phonePattern =
                                    //                         r'^(\+?\d{1,4}[\s-])?(?!0+\s+,?$)\d{10}\s*,?$';
                                    //                         RegExp pnumber = new RegExp(phonePattern);
                                    //                           if(name.text==""){
                                    //                             ScaffoldMessenger.of(context).showSnackBar(
                                    //                             const SnackBar(content: Text('Please enter your name.')));
                                    //                           }
                                    //                           else if(email.text==''){
                                    //                             ScaffoldMessenger.of(context).showSnackBar(
                                    //                                 const SnackBar(content: Text('Please enter your email.')));
                                    //                           }
                                    //                             else if (!regex.hasMatch(email.text)) {
                                    //                               ScaffoldMessenger.of(context).showSnackBar(
                                    //                                  const SnackBar(content: Text('Please enter valid email.')));
                                    //                          }else if(idsTextController.text==""){
                                    //                             ScaffoldMessenger.of(context).showSnackBar(
                                    //                                 const SnackBar(content: Text('Please enter Dam Ids.')));
                                    //                           }
                                    //                             //      else if(phone.text==''){
                                    //                             //   ScaffoldMessenger.of(context).showSnackBar(
                                    //                             //       const SnackBar(content: Text('Please enter your phone number.')));
                                    //                             // }
                                    //                             //     else if (!pnumber.hasMatch(phone.text)) {
                                    //                             //           ScaffoldMessenger.of(context).showSnackBar(
                                    //                             //         const SnackBar(content: Text('Please enter valid phone number.')));
                                    //                             //      }
                                    //
                                    //                                 else {
                                    //
                                    //                                   Map<String, dynamic> request={
                                    //                                     'dam_id':widget.damId.toString(),
                                    //                                     'name':name.text,
                                    //                                     'email':email.text,
                                    //                                     'dam_image_id': idsTextController.text,
                                    //                                     // 'phone':phone.text
                                    //                                   };
                                    //                                   print("request-------------${request}");
                                    //                                   print("api-------------${ApiUrls.downloadform}");
                                    //
                                    //                                   var res = await Webservices.postData(apiUrl: ApiUrls.downloadform, request: request);
                                    //                                   print("res-------------${res}");
                                    //
                                    //                                   if(res['status'].toString()=="1"){
                                    //                                     Navigator.pop(
                                    //                                         context);
                                    //                                     showDialog<
                                    //                                         String>(
                                    //                                       context:
                                    //                                       context,
                                    //                                       builder: (
                                    //                                           BuildContext
                                    //                                           context) =>
                                    //                                           SimpleDialog(
                                    //                                             backgroundColor:
                                    //                                             Colors
                                    //                                                 .transparent,
                                    //                                             children: [
                                    //                                               Container(
                                    //                                                 width:
                                    //                                                 450,
                                    //                                                 decoration:
                                    //                                                 BoxDecoration(
                                    //                                                   borderRadius:
                                    //                                                   BorderRadius
                                    //                                                       .circular(
                                    //                                                       5),
                                    //                                                   color: Color(
                                    //                                                       0xFEFAFAFA),
                                    //                                                 ),
                                    //                                                 padding:
                                    //                                                 EdgeInsets
                                    //                                                     .all(
                                    //                                                     16),
                                    //                                                 child:
                                    //                                                 Column(
                                    //                                                   children: [
                                    //                                                     Column(
                                    //                                                       children: [
                                    //                                                         Image
                                    //                                                             .asset(
                                    //                                                           'assets/images/check.png',
                                    //                                                           width: 150,
                                    //                                                         ),
                                    //                                                         hSizedBox2,
                                    //                                                         MainHeadingText(
                                    //                                                           fontFamily: 'light',
                                    //                                                           height: 1.3,
                                    //                                                           text: 'Thank you ! Your Request has been sent successfully, You will receive mail soon with all data.',
                                    //                                                           fontSize: 16,
                                    //                                                           color: MyColors
                                    //                                                               .headingcolor,
                                    //                                                           textAlign: TextAlign
                                    //                                                               .center,
                                    //                                                         ),
                                    //                                                         hSizedBox2,
                                    //                                                         RoundEdgedButton(
                                    //                                                             onTap: () =>
                                    //                                                                 Navigator
                                    //                                                                     .pop(
                                    //                                                                     context),
                                    //                                                             text: 'Close',
                                    //                                                             width: 150,
                                    //                                                             height: 40,
                                    //                                                             borderRadius: 4,
                                    //                                                             fontSize: 18,
                                    //                                                             color: MyColors
                                    //                                                                 .purpleColor),
                                    //                                                         hSizedBox
                                    //                                                       ],
                                    //                                                     ),
                                    //                                                   ],
                                    //                                                 ),
                                    //                                               )
                                    //                                             ],
                                    //                                           ),
                                    //                                     );
                                    //                                   }
                                    //                                   else{
                                    //                                     ScaffoldMessenger.of(context).showSnackBar(
                                    //                                          SnackBar(content: Text('${res['maessage']}')));
                                    //                                   }
                                    //
                                    //                           }
                                    //
                                    //
                                    //
                                    //
                                    //                                 },
                                    //                             text: 'Submit',
                                    //                             width: 150,
                                    //                             height: 40,
                                    //                             borderRadius: 4,
                                    //                             fontSize: 18,
                                    //                             color: MyColors
                                    //                                 .purpleColor))
                                    //                   ],
                                    //                 ),
                                    //               )
                                    //             ],
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
                                    builder: (BuildContext context) => DownloadFormDialog(damId: widget.damId.toString()),
                                  ),
                                  text: 'Download All Images',
                                  width: 260,
                                  height: 40,
                                  borderRadius: 4,
                                  fontSize: 16,
                                  verticalPadding: 4,
                                  horizontalPadding: 0,
                                  color: MyColors.purpleColor,
                                ),
                              ],
                            ),
                          ],
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
