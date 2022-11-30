import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:din/constants/map_images_urls.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../constants/colors.dart';
import '../constants/sized_box.dart';
class ZoomImgPage extends StatefulWidget {
  final List Images;
  final int initialIndex;
  final String damName;
  final bool isNetwork ;



  ZoomImgPage({Key? key,required this.Images,required this.initialIndex,required this.damName,required this.isNetwork}) : super(key: key);

  @override
  State<ZoomImgPage> createState() => _ZoomImgPageState();
}

class _ZoomImgPageState extends State<ZoomImgPage> {
  int _current = 0;
  final CarouselController carousalController = CarouselController();

  // ImgView(context , index){
  //   return Container(
  //     // height: 500,
  //     // width: 300,
  //     child: SingleChildScrollView(
  //       child: Stack(
  //           alignment: Alignment.center,
  //           children:[
  //             Column(
  //               children: [
  //
  //                 CarouselSlider(
  //                   items: widget.Images.map<Widget>((item) {
  //                     return Builder(
  //                       builder: (BuildContext context) {
  //                         return Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Container(
  //                                 height:500,
  //                                 child:  PhotoViewGallery.builder(
  //                                   scrollPhysics: const BouncingScrollPhysics(),
  //                                   builder: (BuildContext context, int index) {
  //                                     return PhotoViewGalleryPageOptions(
  //                                       imageProvider:
  //                                           AssetImage(MyMapImages.abia),
  //                                       // NetworkImage(item['path']),
  //                                       initialScale: PhotoViewComputedScale.contained * 0.8,
  //                                       heroAttributes: PhotoViewHeroAttributes(tag: 1),
  //                                     );
  //                                   },
  //                                   itemCount:1,
  //                                   loadingBuilder: (context, event) => Center(
  //                                     child: Container(
  //                                       width: 20.0,
  //                                       height: 20.0,
  //                                       child: CircularProgressIndicator(
  //                                         value: event == null
  //                                             ? 0
  //                                             : 55,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   // backgroundDecoration: widget.backgroundDecoration,
  //                                   // pageController: widget.pageController,
  //                                   // onPageChanged: onPageChanged,
  //                                 )
  //                               // backgroundDecoration: widget.backgroundDecoration,
  //                               // pageController: widget.pageController,
  //                               // onPageChanged: onPageChanged,
  //                             ),
  //                             // ),
  //
  //
  //
  //
  //
  //                             // CustomCircularImage(
  //                             //   imageUrl: item['path'],
  //                             //   width: MediaQuery.of(context).size.width,
  //                             //   height: 230,
  //                             //   borderRadius: 5,
  //                             // ),
  //                           ],
  //                         );
  //                       },
  //                     );
  //                   }).toList(),
  //                   carouselController: carousalController,
  //                   options: CarouselOptions(
  //                       height: 500,
  //                       enlargeCenterPage: false,
  //                       aspectRatio: 1,
  //                       autoPlay: false,
  //                       autoPlayInterval: Duration(seconds: 10),
  //                       viewportFraction: 1,
  //                       onPageChanged: (index, reason) {
  //                         setState(() {
  //                           _current = index;
  //                         });
  //                       }),
  //                 ),
  //                 Positioned(
  //                   child: Container(
  //                     width: MediaQuery.of(context).size.width,
  //                     padding: EdgeInsets.all(10),
  //                     decoration: BoxDecoration(
  //                       color: Colors.transparent,
  //                     ),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         GestureDetector(
  //                             onTap: () {
  //                               if (_current == 0) {
  //                                 carousalController.previousPage(
  //                                     duration: Duration(milliseconds: 300),
  //                                     curve: Curves.linear);
  //                               } else if (_current == 1) {
  //                                 carousalController.previousPage(
  //                                     duration: Duration(milliseconds: 300),
  //                                     curve: Curves.linear);
  //                               } else if (_current == 2) {
  //                                 carousalController.previousPage(
  //                                     duration: Duration(milliseconds: 300),
  //                                     curve: Curves.linear);
  //                               } else if (_current == 3) {
  //                                 carousalController.previousPage(
  //                                     duration: Duration(milliseconds: 300),
  //                                     curve: Curves.linear);
  //                               } else if (_current == 4) {
  //                                 carousalController.previousPage(
  //                                     duration: Duration(milliseconds: 300),
  //                                     curve: Curves.linear);
  //                               }
  //                             },
  //                             child: Image.asset(
  //                               'assets/images/arrow-left.png',
  //                               width: 45,
  //                             )),
  //                         wSizedBox4,
  //                         GestureDetector(
  //                             onTap: () {
  //                               if (_current == 0) {
  //                                 carousalController.nextPage(
  //                                     duration: Duration(milliseconds: 300),
  //                                     curve: Curves.linear);
  //                               } else if (_current == 1) {
  //                                 carousalController.nextPage(
  //                                     duration: Duration(milliseconds: 300),
  //                                     curve: Curves.linear);
  //                               } else if (_current == 2) {
  //                                 carousalController.nextPage(
  //                                     duration: Duration(milliseconds: 300),
  //                                     curve: Curves.linear);
  //                               } else if (_current == 3) {
  //                                 carousalController.nextPage(
  //                                     duration: Duration(milliseconds: 300),
  //                                     curve: Curves.linear);
  //                               } else if (_current == 4) {
  //                                 carousalController.nextPage(
  //                                     duration: Duration(milliseconds: 300),
  //                                     curve: Curves.linear);
  //                               }
  //                             },
  //                             child: Image.asset(
  //                               'assets/images/arrow-right.png',
  //                               width: 45,
  //                             )),
  //                       ],
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ]
  //
  //       ),
  //     ),
  //   );
  // }
  @override
  void initState() {
    // TODO: implement initState
    print('Imges--------------${widget.Images}');
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
      body: Stack(
          alignment: Alignment.center,
          children:[
            Container(
              height:(MediaQuery.of(context).size.height-84),
              width:MediaQuery.of(context).size.width,
              // color: Colors.red,
              child: CarouselSlider(
                items: widget.Images.map<Widget>((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Stack(
                            children: [
                              Container(
// color:Colors.black,
                                 height:(MediaQuery.of(context).size.height-85),
                                width:MediaQuery.of(context).size.width,
                                  child:  PhotoViewGallery.builder(
                                    scrollPhysics: BouncingScrollPhysics(),
                                    builder: (BuildContext context, int index) {
                                      return PhotoViewGalleryPageOptions(
                                        // imageProvider: ,
                                        imageProvider:((widget.isNetwork == true)?CachedNetworkImageProvider(item['path']):AssetImage(item['path'])) as ImageProvider,
                                        // imageProvider: NetworkImage(item['path']),
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



                      ///Is Satellite Text
                          // if(item['is_satellite'].toString()=='1')
                          //   Positioned(
                          //       right:16,
                          //       bottom: 16,
                          //       child: Text('Satellite Image',style: TextStyle(color: Colors.white),))
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
                    height:(MediaQuery.of(context).size.height-84),
                    initialPage: widget.initialIndex,
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
            ),

          ]

      )
    );




  }
}
