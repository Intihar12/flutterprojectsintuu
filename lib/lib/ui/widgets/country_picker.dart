
import 'package:antrakuserinc/data/constants/constants.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';


class CountryPicker extends StatefulWidget {
  CountryPicker({this.callback,this.height,this.width});
  Function? callback;
  double? height;
  double? width;
  @override
  _CountryPickerState createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  String val=Constants.countryCode;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
     // color: Colors.amberAccent,
      // decoration: BoxDecoration(
      //   border: Border(right: BorderSide(
      //     color: MyColors.green50
      //   )
      //   ),
      // ),
      child: CountryCodePicker(
        onChanged:(value) {
          widget.callback!(value);
        },
        textStyle: TextStyle(
          fontSize: Dimens.size12,
        ),

        showFlag: true,
        showOnlyCountryWhenClosed: false,
        enabled: true,
        initialSelection: Constants.countryCodeEn,
        showFlagMain: false,
        showDropDownButton: true,
        // autofocus: true,
        showCountryOnly: true,
        favorite: [Constants.countryCode, Constants.countryCodeEn],
      //  alignLeft: true,
      ),
    );
  }
}