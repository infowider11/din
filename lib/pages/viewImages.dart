import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:din/constants/navigation.dart';
import 'package:din/pages/zoomImg.dart';
import 'package:din/widgets/buttons.dart';
import 'package:din/widgets/customloader.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../constants/colors.dart';
import '../constants/sized_box.dart';
import '../dialogs/download_form_dialog.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import 'dart:convert' as convert;

class ViewOnlinePage extends StatefulWidget {
  final String damId;
  final String damName;
  final bool withDownloadOption;

  const ViewOnlinePage(
      {Key? key,
      required this.damId,
      required this.damName,
      this.withDownloadOption = false})
      : super(key: key);

  @override
  State<ViewOnlinePage> createState() => _ViewOnlinePageState();
}

class _ViewOnlinePageState extends State<ViewOnlinePage> {
  int selectedIndex = 1;
  int _current = 0;
  List selectedImageIds = [];
  final CarouselController carousalController = CarouselController();
  bool load = false;
  List ImgDetails = [];
  getDamDetails() async {
    setState(() {
      load = true;
    });
    // var request = {'id': widget.damId.toString()};
    var jsonResponse = await Webservices.getData(
        '${ApiUrls.damImages}?id=${widget.damId.toString()}'); //widget.damId.toString()
    log("jsonResponse----------Img--------------${jsonResponse}");
    var result = convert.jsonDecode(jsonResponse.body);
    log("jsonResponse----------Img-------55-------${result['status']}");
    if (result['status'].toString() == '1') {
      print('object----------${result['status']}');
      ImgDetails = result['data'];
      log("ImgDetails----------Img--------------${ImgDetails}");
    } else {
      print('else-------------------');
      ImgDetails = [];
    }

    // if (jsonResponse['status'] == 1) {
    //   ImgDetails = jsonResponse['data'];
    // }
    setState(() {
      load = false;
    });
  }

  List Img = [
    'assets/images/logo.png',
    'assets/images/logo.png',
    'assets/images/logo.png',
    'assets/images/logo.png',
    'assets/images/logo.png',
  ];
  // ImgView(context, index) {
  //   return Container(
  //     // height: 500,
  //     // width: 300,
  //     child: SingleChildScrollView(
  //       child: Stack(alignment: Alignment.center, children: [
  //         Column(
  //           children: [
  //             CarouselSlider(
  //               items: ImgDetails?[index]['images'].map<Widget>((item) {
  //                 return Builder(
  //                   builder: (BuildContext context) {
  //                     return Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Container(
  //                             height: 500,
  //                             child: PhotoViewGallery.builder(
  //                               scrollPhysics: const BouncingScrollPhysics(),
  //                               builder: (BuildContext context, int index) {
  //                                 return PhotoViewGalleryPageOptions(
  //                                   imageProvider:CachedNetworkImageProvider(item['path']),
  //                                   initialScale:
  //                                       PhotoViewComputedScale.contained * 0.8,
  //                                   heroAttributes:
  //                                       PhotoViewHeroAttributes(tag: 1),
  //                                 );
  //                               },
  //                               itemCount: 1,
  //                               loadingBuilder: (context, event) => Center(
  //                                 child: Container(
  //                                   width: 20.0,
  //                                   height: 20.0,
  //                                   child: CircularProgressIndicator(
  //                                     value: event == null ? 0 : 55,
  //                                   ),
  //                                 ),
  //                               ),
  //                               // backgroundDecoration: widget.backgroundDecoration,
  //                               // pageController: widget.pageController,
  //                               // onPageChanged: onPageChanged,
  //                             )
  //                             // backgroundDecoration: widget.backgroundDecoration,
  //                             // pageController: widget.pageController,
  //                             // onPageChanged: onPageChanged,
  //                             ),
  //                         // ),
  //
  //                         // CustomCircularImage(
  //                         //   imageUrl: item['path'],
  //                         //   width: MediaQuery.of(context).size.width,
  //                         //   height: 230,
  //                         //   borderRadius: 5,
  //                         // ),
  //                       ],
  //                     );
  //                   },
  //                 );
  //               }).toList(),
  //               carouselController: carousalController,
  //               options: CarouselOptions(
  //                   height: 500,
  //                   enlargeCenterPage: false,
  //                   aspectRatio: 1,
  //                   autoPlay: false,
  //                   autoPlayInterval: Duration(seconds: 10),
  //                   viewportFraction: 1,
  //                   onPageChanged: (index, reason) {
  //                     setState(() {
  //                       _current = index;
  //                     });
  //                   }),
  //             ),
  //             Positioned(
  //               child: Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 padding: EdgeInsets.all(10),
  //                 decoration: BoxDecoration(
  //                   color: Colors.transparent,
  //                 ),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     GestureDetector(
  //                         onTap: () {
  //                           if (_current == 0) {
  //                             carousalController.previousPage(
  //                                 duration: Duration(milliseconds: 300),
  //                                 curve: Curves.linear);
  //                           } else if (_current == 1) {
  //                             carousalController.previousPage(
  //                                 duration: Duration(milliseconds: 300),
  //                                 curve: Curves.linear);
  //                           } else if (_current == 2) {
  //                             carousalController.previousPage(
  //                                 duration: Duration(milliseconds: 300),
  //                                 curve: Curves.linear);
  //                           } else if (_current == 3) {
  //                             carousalController.previousPage(
  //                                 duration: Duration(milliseconds: 300),
  //                                 curve: Curves.linear);
  //                           } else if (_current == 4) {
  //                             carousalController.previousPage(
  //                                 duration: Duration(milliseconds: 300),
  //                                 curve: Curves.linear);
  //                           }
  //                         },
  //                         child: Image.asset(
  //                           'assets/images/arrow-left.png',
  //                           width: 45,
  //                         )),
  //                     wSizedBox4,
  //                     GestureDetector(
  //                         onTap: () {
  //                           if (_current == 0) {
  //                             carousalController.nextPage(
  //                                 duration: Duration(milliseconds: 300),
  //                                 curve: Curves.linear);
  //                           } else if (_current == 1) {
  //                             carousalController.nextPage(
  //                                 duration: Duration(milliseconds: 300),
  //                                 curve: Curves.linear);
  //                           } else if (_current == 2) {
  //                             carousalController.nextPage(
  //                                 duration: Duration(milliseconds: 300),
  //                                 curve: Curves.linear);
  //                           } else if (_current == 3) {
  //                             carousalController.nextPage(
  //                                 duration: Duration(milliseconds: 300),
  //                                 curve: Curves.linear);
  //                           } else if (_current == 4) {
  //                             carousalController.nextPage(
  //                                 duration: Duration(milliseconds: 300),
  //                                 curve: Curves.linear);
  //                           }
  //                         },
  //                         child: Image.asset(
  //                           'assets/images/arrow-right.png',
  //                           width: 45,
  //                         )),
  //                   ],
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ]),
  //     ),
  //   );
  // }

  @override
  void initState() {
    // TODO: implement initState
    getDamDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.whiteColor,
        elevation: 1,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.chevron_left_rounded, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('${widget.damName}',
            style: TextStyle(color: Colors.black, fontFamily: 'semibold')),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {
              // ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(content: Text('This is a Notification')));
            },
          ),
        ],
      ),
      body: load?CustomLoader():Column(
        children: [
          Expanded(
            child: ImgDetails.length > 0
                ?
                // Image.network('https://dams.ng/public/admin/images/weirsImage/1666336583.jpg')

                DefaultTabController(
                    length: ImgDetails.length,
                    child: Column(children: <Widget>[
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                color: MyColors.purpleColor, width: 2),
                            bottom: BorderSide(
                                color: MyColors.purpleColor, width: 2),
                            left: BorderSide(
                                color: MyColors.purpleColor, width: 2),
                            right: BorderSide(
                                color: MyColors.purpleColor, width: 2),
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
                                for (int i = 0; i < ImgDetails.length; i++)
                                  Tooltip(
                                    message: 'Click to show Map View',
                                    child: Tab(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${ImgDetails[i]['categoryName']}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'semibold',
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ]),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                            // controller: tabController,
                            children: [
                              // for (int i=0; i<ImgDetails.length ;i++)
                              // ImgView(context, i)
                              for (int j = 0; j < ImgDetails.length; j++)
                                GridView(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  children: [
                                    for (int i = 0;
                                        i < ImgDetails[j]['images'].length;
                                        i++)
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                print(
                                                    'object-----------585--${ImgDetails[j]['images']}');
                                                push(
                                                    context: context,
                                                    screen: ZoomImgPage(
                                                      Images: ImgDetails[j]
                                                          ['images'],
                                                      initialIndex: i,
                                                      damName: widget.damName, isNetwork: true,
                                                    ));
                                              },
                                              child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  child: Image.network(
                                                    ImgDetails[j]['images'][i]
                                                        ['path'],
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                            if(widget.withDownloadOption)
                                            Checkbox(
                                                value: ImgDetails[j]['images']
                                                        [i]['isSelected'] ==
                                                    true,
                                                onChanged: (val) {
                                                  if (ImgDetails[j]['images'][i]
                                                          ['isSelected'] ==
                                                      true) {
                                                    ImgDetails[j]['images'][i]
                                                        ['isSelected'] = false;
                                                    selectedImageIds.remove(
                                                        ImgDetails[j]['images']
                                                            [i]['id']);
                                                  } else {
                                                    ImgDetails[j]['images'][i]
                                                        ['isSelected'] = true;
                                                    selectedImageIds.add(
                                                        ImgDetails[j]['images']
                                                            [i]['id']);
                                                  }
                                                  print(
                                                      'the selected ids are ${selectedImageIds}');
                                                  setState(() {});
                                                }),
                                          ],
                                        ),
                                      ),
                                  ],
                                  padding: EdgeInsets.all(5),
                                )
                            ]),
                      )
                    ]))
                : Container(
                    child: Center(
                      child: Text('Image not found'),
                    ),
                  ),
          ),
          hSizedBox,
          if(widget.withDownloadOption)
          RoundEdgedButton(
            text: 'Download',
            horizontalMargin: 16,
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => DownloadFormDialog(damId: widget.damId.toString(), selectedImageIds: selectedImageIds.join(',')),
              );
            },
          ),
          hSizedBox,
        ],
      ),

      /// body without tab
      // body: Container(
      //   child:ImgDetails.length>0 ?ImgView(context, 1):Container(
      //     height: 500,
      //     child: Center(child:Text('Dam Images not found.')),
      //   ),
      // )
    );
  }
}
