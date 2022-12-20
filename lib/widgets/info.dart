import 'package:Din/constants/sized_box.dart';
import 'package:flutter/material.dart';

class ListInfo extends StatelessWidget {
  final String heading;
  final String subheading;

  const ListInfo({Key? key,
    required this.heading,
    required this.subheading,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text.rich(
          TextSpan(
            text: heading,
            style: TextStyle(fontSize: 11, color: Colors.black, fontFamily: 'light' ),
            children: <TextSpan>[
              TextSpan(
                  text: subheading,
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
        vSizedBox05,
      ],
    );
  }
}
