import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/sized_box.dart';
import '../detail.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/custom_circular_image.dart';
class MarkerInfoWindow extends StatelessWidget {
  final Map damInfo;
  const MarkerInfoWindow({Key? key, required this.damInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: Colors.transparent,
      child: Container(

        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: MyColors.bordercolor,
                width: 1
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  child: CustomCircularImage(
                    imageUrl: damInfo['dam_img_data'],
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    borderRadius: 20,
                  ),
                ),
                Positioned(right: 0,child: IconButton(icon: Icon(Icons.close, color: Colors.black,),onPressed: (){
                  Navigator.pop(context);
                },),),
              ],
            ),
            Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image.asset('assets/images/dam.png'),

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainHeadingText(text: '${damInfo['name']}', fontSize: 15,),
                        vSizedBox,
                        Text.rich(
                          TextSpan(
                            text: 'Type: ',
                            style: TextStyle(fontSize: 11, color: Colors.black, fontFamily: 'light' ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${damInfo['damTypeName']}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'semibold',
                                      fontSize: 11,
                                      height: 1.3
                                  )
                              ),
                              // can add more TextSpans here...
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: 'Category: ',
                            style: TextStyle(fontSize: 11, color: Colors.black, fontFamily: 'light' ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${damInfo['catName']}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'semibold',
                                      fontSize: 11,
                                      height: 1.3
                                  )
                              ),
                              // can add more TextSpans here...
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: 'Location: ',
                            style: TextStyle(fontSize: 11, color: Colors.black, fontFamily: 'light' ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${damInfo['stateName']}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'semibold',
                                      fontSize: 11,
                                      height: 1.3
                                  )
                              ),
                              // can add more TextSpans here...
                            ],
                          ),
                        ),
                        vSizedBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: MyColors.primaryColor,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  child: MainHeadingText(text: 'Details', fontSize: 12, color: MyColors.whiteColor, fontFamily: 'semibold',),
                                ),
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(damId: damInfo['id'],)))
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
