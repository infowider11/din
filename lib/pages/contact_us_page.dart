import 'package:flutter/material.dart';


import '../../../widgets/showSnackbar.dart';
import '../constants/sized_box.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/appbar.dart';
import '../widgets/buttons.dart';
import '../widgets/customloader.dart';
import '../widgets/customtextfield.dart';

class ContactUsScreen extends StatefulWidget {
  static const String id = 'contact_us_screen';
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  bool load = false;

  // initializeValues()async{
  //   print(userData);
  //   emailController.text = userData!['email']??'';
  //   mobileNumberController.text = userData!['phone']??'';
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:load?null: appBar(context: context, title: 'Get Support'),
      body:load?CustomLoader(): Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSizedBox2,
              SubHeadingText(
                text: 'Name',
              ),
              vSizedBox,
              CustomTextField(
                  controller: nameController,
                  hintText: 'HiTek Productions'),

              vSizedBox2,
              SubHeadingText(
                text: 'Email',
              ),
              vSizedBox,
              CustomTextField(
                  controller: emailController,
                  hintText: 'htp@htpng.com'),
              vSizedBox2,
              SubHeadingText(
                text: 'Mobile No.',
              ),
              vSizedBox,
              CustomTextField(
                  controller: mobileNumberController,
                  keyboardType: TextInputType.numberWithOptions(),
                  hintText: '+234 816 920 3344'),
              vSizedBox2,
              SubHeadingText(
                text: 'Message',
              ),
              vSizedBox,
              CustomTextField(
                controller: descriptionController,
                hintText: 'Say Something here...',
                maxLines: 6,
                height: 150,
              ),
              vSizedBox2,
              vSizedBox2,
              RoundEdgedButton(
                text: 'Send',
                onTap: ()async{
                  if (nameController.text == '') {
                    showSnackbar( 'Please Enter your name');
                  }else if (emailController.text == '') {
                    showSnackbar( 'Please Enter your email');
                  } else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text)){
                    showSnackbar( 'Please Enter valid email.');
                  }   else if (mobileNumberController.text == '') {
                    showSnackbar(
                         'Please Enter your phone number.');
                  } else if(mobileNumberController.text.length<10){
                    showSnackbar( 'Please Enter valid phone number.');
                  }else if(descriptionController.text.length<30){
                    showSnackbar( 'Please type a description of atleast 30 characters');
                  }else{
                    setState(() {
                      load = true;
                    });
                    var request = {
                      "name": nameController.text,
                      "email": emailController.text,
                      "phone": mobileNumberController.text,
                      "message": descriptionController.text,
                    };
                    var jsonResponse = await Webservices.postData(apiUrl: ApiUrls.contactUs, request: request);
                    if(jsonResponse['status']==1){
                      showSnackbar( '${jsonResponse['message']}');
                      Navigator.pop(context);
                    }
                    setState(() {
                      load = false;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
