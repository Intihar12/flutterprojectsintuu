

import 'package:antrakuserinc/controllers/contact_us_controller/contact_us_controller.dart';
import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:antrakuserinc/ui/values/size_config.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../values/dimens.dart';
import '../values/my_colors.dart';
import '../values/my_imgs.dart';
import '../values/strings.dart';
import '../widgets/custom_textfield.dart';



class CustomerSupport extends StatelessWidget {

  ContactUsController contactUsController = Get.put(ContactUsController());

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var textTheme=theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          centerTitle: true,
          title: Text(Strings.supportAppbar),
        ),
        body:  GestureDetector(
          onTap: (){FocusScope.of(context).requestFocus(FocusNode());},
          child: Padding(
            padding: const EdgeInsets.all(Dimens.size20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(MyImgs.support, height: getHeight(Dimens.size200),),
                Text(Strings.supportHeading, style:  textTheme.headline1!.copyWith(fontSize: 18),),
                SizedBox(height: getHeight(Dimens.size20),),
                Text(Strings.supportText, textAlign: TextAlign.center,
                style: textTheme.caption,
                ),
                SizedBox(height: getHeight(Dimens.size50),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        contactUsController.emailLaunch("${SingleToneValue.instance.contactEmail}");
                      },
                      child: Container(
                        height: getHeight(Dimens.size100),
                        width: getWidth(Dimens.size150),
                        decoration: BoxDecoration(
                          color: MyColors.fadedBlue.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(Dimens.size12)
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(MyImgs.email,
                              height: getHeight(Dimens.size20),
                                width: getWidth(Dimens.size35),
                              ),
                              SizedBox(height: getHeight(5),),
                              Text(Strings.supportEmail, style: textTheme.headline1!.copyWith(
                                fontSize: getFont(14)
                              ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        contactUsController.makePhoneCall("${SingleToneValue.instance.contactPhone}");
                      },
                      child: Container(
                        height: getHeight(Dimens.size100),
                        width: getWidth(Dimens.size150),
                        decoration: BoxDecoration(
                          color: MyColors.fadedBlue.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(Dimens.size12)
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(MyImgs.phone,
                              height: getHeight(Dimens.size20),
                                width: getWidth(Dimens.size35),
                              ),
                              SizedBox(height: getHeight(5),),
                              Text(Strings.supportCall, style: textTheme.headline1!.copyWith(
                              fontSize: getFont(14)
                        ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

        ),

      ),
    );
  }
}








