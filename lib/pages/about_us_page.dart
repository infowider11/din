import 'dart:developer';

import 'package:Din/services/api_urls.dart';
import 'package:Din/services/webservices.dart';
import 'package:Din/widgets/CustomTexts.dart';
import 'package:Din/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:convert' as convert;

import '../widgets/customloader.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool load=false;
  Map data={};
  getData()async{
    setState(() {
      load=true;
    });
    var res= await Webservices.getData('${ApiUrls.getAboutUs}');
    var jsonResponse = convert.jsonDecode(res.body);

    print("res about us data -----------$jsonResponse");
    data=jsonResponse['data'];
    setState(() {
      load=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context,title: 'About Us'),
      body:load?CustomLoader(): Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 26),
        child: SingleChildScrollView(
          child:Html(
              data:data['about']
            // data:'<p>aboutuscontent<\/p>'
          ),
          // RichText(
          //   text: TextSpan(
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontStyle: FontStyle.italic,
          //       // letterSpacing: 2,
          //       height: 2
          //     ),
          //     children: [
          //       TextSpan(
          //         text: "This Web-Application is an Interactive Digital Map of Dams in Nigeria where all the available information on dams in Nigeria, showcasing potentials in hydropower generation and water works, is made available to individuals and investors."
          //       ),
          //       TextSpan(
          //           text: "\n\nAll Rights reserved.  This web-application is the property of the Federal Government of Nigeria. The information contained in this application cannot be altered in whole or in part without the permission of the Dams and Reservoir Operations Department."
          //       )
          //     ]
          //   ),
          // ),
        ),
      ),
    );
  }
}
