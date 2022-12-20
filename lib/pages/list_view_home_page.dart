import 'package:Din/constants/global_data.dart';
import 'package:Din/constants/sized_box.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../detail.dart';
import '../widgets/CustomTexts.dart';
class ListViewHomePage extends StatefulWidget {
  const ListViewHomePage({Key? key}) : super(key: key);

  @override
  State<ListViewHomePage> createState() => _ListViewHomePageState();
}

class _ListViewHomePageState extends State<ListViewHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            vSizedBox,

            Table(

              children: [
                TableRow(
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: MainHeadingText(text: 'Dam Name', fontSize: 12, color: MyColors.whiteColor,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: MainHeadingText(text: 'Category', fontSize: 12, color: MyColors.whiteColor,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: MainHeadingText(text: 'TYPE', fontSize: 12, color: MyColors.whiteColor,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: MainHeadingText(text: 'RIVER', fontSize: 12, color: MyColors.whiteColor,),
                      ),
                      Container(
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: MainHeadingText(text: '', fontSize: 12, color: MyColors.whiteColor,),
                        ),
                      ),
                    ]
                ),
                for(var i=0; i <damList.length; i++)
                  TableRow(
                      decoration: BoxDecoration(
                        color: MyColors.whiteColor,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: MainHeadingText(text: '${damList[i]['name']}', fontSize: 12,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: MainHeadingText(text: '${damList[i]['catName']}', fontSize: 12,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: MainHeadingText(text: '${damList[i]['damTypeName']}', fontSize: 12,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: MainHeadingText(text: '${damList[i]['riverName']}', fontSize: 12,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(damId:damList[i]['id']))),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: MyColors.primaryColor,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                              child: Center(child: MainHeadingText(text: 'Details', fontSize: 12, color: MyColors.whiteColor, fontFamily: 'semibold',)),
                            ),
                          ),
                        ),
                      ]
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
