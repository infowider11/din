import 'package:din/constants/global_data.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../constants/colors.dart';
import '../constants/sized_box.dart';
import '../detail.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/custom_circular_image.dart';
class GridViewPage extends StatefulWidget {
  const GridViewPage({Key? key}) : super(key: key);

  @override
  State<GridViewPage> createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: ResponsiveGridRow(
            children: [
              for(var i = 0; i < damList.length; i++)
                ResponsiveGridCol(
                  xs: 6,
                  child: GestureDetector(
                    // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewsPage())),
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: MyColors.bordercolor,
                                width: 1
                            )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image.asset('assets/images/dam.png'),
                            CustomCircularImage(
                              imageUrl: damList[i]['dam_img_data'],
                              height: 120,
                              width: MediaQuery.of(context).size.width,
                              borderRadius: 0,
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MainHeadingText(text: '${damList[i]['name']}', fontSize: 15,),
                                  hSizedBox,
                                  Text.rich(
                                    TextSpan(
                                      text: 'Type: ',
                                      style: TextStyle(fontSize: 11, color: Colors.black, fontFamily: 'light' ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '${damList[i]['damTypeName']}',
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
                                            text: '${damList[i]['catName']}',
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
                                            text: '${damList[i]['stateName']}',
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
                                  hSizedBox,
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
                                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(damId: damList[i]['id'],)))
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                )
            ]
        ),
      ),
    );
  }
}
