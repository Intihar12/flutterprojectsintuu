import 'package:antrakuserinc/controllers/auth_controller/auth_controller.dart';
import 'package:antrakuserinc/data/validation.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/size_config.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/singleton/singleton.dart';
import '../values/dimens.dart';
import '../values/strings.dart';

class PhonePicker extends StatelessWidget {
  String countryCode;
  final Function()? onTap;
  final TextEditingController? controller;
  bool? Readonly = false;
  PhonePicker({
    Key? key,
    required this.countryCode,
    this.Readonly,
    this.onTap,
    this.controller,
  }) : super(key: key);

  final _valid = ValidationOfField();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            height: getHeight(40),
            width: getWidth(Dimens.size120),
            decoration: BoxDecoration(
                borderRadius:  BorderRadius.circular(5),
              border: Border.all(color: MyColors.greyFont)
            ),

            child: CountryCodePicker(
              padding: EdgeInsets.zero,
              showFlag: true,
              flagWidth: 25,
              flagDecoration: BoxDecoration(),
              onChanged: (code) {
                countryCode = code.dialCode!;
                SingleToneValue.instance.code = countryCode;
              },
              showDropDownButton: true,
              textStyle: TextStyle(
                  fontSize: Dimens.size14,
                  color: MyColors.black.withOpacity(0.5)),
              initialSelection: 'US',
            ),
          ),
        ),

        Expanded(
          child: SizedBox(
            height: getHeight(50),
            child: TextFormField(
              onTap: onTap,
              validator: (value) {
                return _valid.phoneNumber(value!);
              },
              controller: controller,
              readOnly: Readonly == true ? true : false,
              maxLength: 10,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 2, bottom: 10, left: 10),
                  counter: Offstage(),

                  hintText: Strings.phone,
                  hintStyle: TextStyle(
                      fontSize: 14, color: MyColors.grey72.withOpacity(0.5)),
                errorStyle: TextStyle(fontSize: 0),
                counterText: "",
                //border: InputBorder.none,

                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(5),
                  ),
                  borderSide: new BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),


              ),

            ),
          ),
        ),
      ],
    );
  }
}
