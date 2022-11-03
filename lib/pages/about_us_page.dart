import 'package:din/widgets/CustomTexts.dart';
import 'package:din/widgets/appbar.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context,title: 'About Us'),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 26),
        child: SingleChildScrollView(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                // letterSpacing: 2,
                height: 2
              ),
              children: [
                TextSpan(
                  text: "This Web-Application is an Interactive Digital Map of Dams in Nigeria where all the available information on dams in Nigeria, showcasing potentials in hydropower generation and water works, is made available to individuals and investors."
                ),
                TextSpan(
                    text: "\n\nAll Rights reserved.  This web-application is the property of the Federal Government of Nigeria. The information contained in this application cannot be altered in whole or in part without the permission of the Dams and Reservoir Operations Department."
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
