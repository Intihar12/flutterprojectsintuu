import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import '../../data/constants/constants.dart';
import '../values/dimens.dart';
import '../values/my_colors.dart';
import '../values/size_config.dart';
import '../values/strings.dart';

class CountryPickerForEdit extends StatelessWidget {
  String countryCode;
  final TextEditingController? controller;
  bool? Readonly = false;
  CountryPickerForEdit({
    Key? key,
    required this.countryCode,
    this.Readonly,
    this.controller,
  }) : super(key: key);

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Center(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: MyColors.black),
            borderRadius: BorderRadius.circular(5)),
       // width: getWidth(Dimens.size350),
        height: getHeight(Dimens.size40),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1, color: MyColors.greyFont)),
              ),
              width: getWidth(Dimens.size120),
              child: CountryCodePicker(
                  padding: EdgeInsets.zero,
                  showFlag: true,
                  flagWidth: 25,
                  flagDecoration: BoxDecoration(),
                  onChanged: (code) {
                    countryCode = code.dialCode!;
                    SingleToneValue.instance.cCode = countryCode;
                  },
                  showDropDownButton: true,
                  textStyle: TextStyle(
                      fontSize: Dimens.size14,
                      color: MyColors.black.withOpacity(0.5)),
                  initialSelection: countryCode,
                  favorite: [Constants.countryCode, Constants.countryCodeEn]),
            ),
            SizedBox(
              width: Dimens.size15,
            ),
            Expanded(
              child: TextFormField(
                controller: controller,
                readOnly: Readonly == true ? true : false,
                maxLength: 10,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 2, bottom: 10),
                    counter: Offstage(),
                    border: InputBorder.none,
                    hintText: Strings.phone,
                    hintStyle: TextStyle(
                        fontSize: 14, color: MyColors.grey72.withOpacity(0.5))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
