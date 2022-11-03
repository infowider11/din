import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../constants/colors.dart';
import '../constants/sized_box.dart';
import 'CustomTexts.dart';

class DropDown extends StatefulWidget {
  final String label;
  final Color? labelcolor;
  final Color iconcolor;
  final List<String> items;
  final bool islabels;
  final Function(String?)? onChanged;
  final String? selectedValue;

  const DropDown({
    Key? key,
    this.label = 'label',
    this.labelcolor = MyColors.primaryColor,
    this.iconcolor = MyColors.bordercolor,
    this.items = const [
      'All',
      'Option 1',
      'Option 2',
      'Option 3',
      'Option 4',
    ],
    this.islabels = true,
    this.onChanged,
    this.selectedValue,

  }) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.islabels)
          hSizedBox,
          if(widget.islabels)
          ParagraphText(
            text: widget.label,
            fontSize: 14,
            color: widget.labelcolor,
            fontFamily: 'medium',
          ),
          SizedBox(height: 7),
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: Text(
                widget.items[0],
                style: TextStyle(
                  fontSize: 14,
                  color: MyColors.darkGreyColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              items: widget.items
                  .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
                  .toList(),
              value: widget.selectedValue,
              onChanged: widget.onChanged,
              icon: const Icon(
                Icons.expand_more_outlined,
              ),
              iconSize: 20,
              iconEnabledColor: widget.iconcolor,
              iconDisabledColor: Colors.grey,
              buttonHeight: 52,
              buttonWidth: MediaQuery.of(context).size.width - 32,
              buttonPadding: const EdgeInsets.only(left: 14, right: 14),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: MyColors.bordercolor,
                ),
                // color: MyColors.primaryColor,
                color: Colors.white,
              ),
              buttonElevation: 0,
              itemHeight: 30,
              itemPadding: const EdgeInsets.only(left: 14, right: 14),
              dropdownMaxHeight: 200,
              dropdownWidth: MediaQuery.of(context).size.width - 48,
              dropdownPadding: null,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
                border: Border.all(
                  color: MyColors.bordercolor,
                ),

              ),
              dropdownElevation: 0,
              scrollbarRadius: const Radius.circular(40),
              scrollbarThickness: 6,
              scrollbarAlwaysShow: true,
              offset: const Offset(0, 0),
            ),
          ),
        ],
      ),
    );
  }
}
