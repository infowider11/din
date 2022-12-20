import 'package:Din/constants/global_keys.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/sized_box.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/buttons.dart';
import '../widgets/customtextfield.dart';
class DownloadFormDialog extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  // TextEditingController idsTextController = TextEditingController();
  final String damId;
  final String? selectedImageIds;
   DownloadFormDialog({Key? key, required this.damId, this.selectedImageIds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SimpleDialog(
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
                              onTap: (){
                                Navigator.pop(context);
                              },
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
                          vSizedBox2,
                          CustomTextField(
                              controller: name,
                              labelfontfamily: 'regular',
                              height: 40,
                              borderradius: 5,
                              label: 'Name',
                              showlabel: true,
                              hintText:
                              'Please enter your name'),
                          vSizedBox,
                          CustomTextField(
                              controller: email,
                              labelfontfamily: 'regular',
                              height: 40,
                              borderradius: 5,
                              label: 'Email',
                              showlabel: true,
                              hintText:
                              'Please enter your Email id'),

                          vSizedBox2,
                          Center(
                              child: RoundEdgedButton(

                                  onTap: ()  async{
                                    String pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    String phonePattern =
                                        r'^(\+?\d{1,4}[\s-])?(?!0+\s+,?$)\d{10}\s*,?$';
                                    RegExp pnumber = new RegExp(phonePattern);
                                    if(name.text==""){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Please enter your name.')));
                                    }
                                    else if(email.text==''){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Please enter your email.')));
                                    }
                                    else if (!regex.hasMatch(email.text)) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Please enter valid email.')));
                                    }
                                    //      else if(phone.text==''){
                                    //   ScaffoldMessenger.of(context).showSnackBar(
                                    //       const SnackBar(content: Text('Please enter your phone number.')));
                                    // }
                                    //     else if (!pnumber.hasMatch(phone.text)) {
                                    //           ScaffoldMessenger.of(context).showSnackBar(
                                    //         const SnackBar(content: Text('Please enter valid phone number.')));
                                    //      }

                                    else {

                                      Map<String, dynamic> request={
                                        'dam_id':damId,
                                        'name':name.text,
                                        'email':email.text,
                                        // 'dam_image_id': selectedImageIds,
                                        // 'phone':phone.text
                                      };
                                      if(selectedImageIds!=null){
                                        request['dam_image_id'] = selectedImageIds;
                                      }
                                      print("request-------------${request}");
                                      print("api-------------${ApiUrls.downloadform}");

                                      var res = await Webservices.postData(apiUrl: ApiUrls.downloadform, request: request);
                                      print("res-------------${res}");

                                      if(res['status'].toString()=="1"){
                                        Navigator.pop(
                                            context);
                                        showDialog<
                                            String>(
                                          context:
                                          MyGlobalKeys.navigatorKey.currentContext!,
                                          builder: (
                                              BuildContext
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
                                                      BorderRadius
                                                          .circular(
                                                          5),
                                                      color: Color(
                                                          0xFEFAFAFA),
                                                    ),
                                                    padding:
                                                    EdgeInsets
                                                        .all(
                                                        16),
                                                    child:
                                                    Column(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Image
                                                                .asset(
                                                              'assets/images/check.png',
                                                              width: 150,
                                                            ),
                                                            vSizedBox2,
                                                            MainHeadingText(
                                                              fontFamily: 'light',
                                                              height: 1.3,
                                                              text: 'Thank you ! Your Request has been sent successfully, You will receive mail soon with all data.',
                                                              fontSize: 16,
                                                              color: MyColors
                                                                  .headingcolor,
                                                              textAlign: TextAlign
                                                                  .center,
                                                            ),
                                                            vSizedBox2,
                                                            RoundEdgedButton(
                                                                onTap: () =>
                                                                    Navigator
                                                                        .pop(
                                                                        context),
                                                                text: 'Close',
                                                                width: 150,
                                                                height: 40,
                                                                borderRadius: 4,
                                                                fontSize: 18,
                                                                color: MyColors
                                                                    .purpleColor),
                                                            vSizedBox
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                        );
                                      }
                                      else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('${res['maessage']}')));
                                      }

                                    }




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
    );
  }
}
