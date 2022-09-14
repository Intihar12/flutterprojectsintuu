import 'package:antrakuserinc/ui/auth/signup/signup.dart';
import 'package:antrakuserinc/ui/profile/privacy_policy.dart';
import 'package:antrakuserinc/ui/profile/terms_&_conditions.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/my_imgs.dart';
import 'package:antrakuserinc/ui/values/size_config.dart';
import 'package:antrakuserinc/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../values/strings.dart';
import 'login/login.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  int id = 1;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Container(
      width: getWidth(double.infinity),
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                MyImgs.welcomePic,
              ))),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: getHeight(Dimens.size120),
            ),
            Padding(
              padding: const EdgeInsets.only(top: Dimens.size250),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CustomButton(
                        text: Strings.createNew,
                        width: getWidth(Dimens.size374),
                        height: getHeight(Dimens.size40),
                        color: MyColors.white,
                        textColor: MyColors.primaryColor,
                        borderColor: MyColors.white,
                        onPressed: () {
                          Get.off(SignUp());
                        },
                      ),
                      SizedBox(
                        height: getHeight(Dimens.size10),
                      ),
                      CustomButton(
                        text: Strings.loginExisting,
                        width: getWidth(Dimens.size374),
                        height: getHeight(Dimens.size40),
                        color: Colors.transparent,
                        textColor: MyColors.white,
                        borderColor: MyColors.white,
                        onPressed: () {
                          Get.off(Login());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            /*Text(Strings.or,
                style: Get.textTheme.subtitle2!.copyWith(
                    fontSize: getFont(18), fontWeight: FontWeight.w500)),
            SizedBox(
              height: getHeight(Dimens.size16),
            ),*/
            /*Padding(
              padding: const EdgeInsets.all(Dimens.size20),
              child: GoogleButton(
                borderColor: MyColors.white,
                textColor: MyColors.white,
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(Strings.welcomeBottomTxt1,
                          style: Get.textTheme.subtitle2!.copyWith(
                              fontSize: getFont(12),
                              fontWeight: FontWeight.normal,
                              color: MyColors.white)),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => TermsAndConditions());
                        },
                        child: Text(Strings.terms,
                            style: Get.textTheme.subtitle2!.copyWith(
                              fontSize: getFont(14),
                              fontWeight: FontWeight.normal,
                              color: MyColors.secondaryColor,
                              decoration: TextDecoration.underline,
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(Strings.and,
                          style: Get.textTheme.subtitle2!.copyWith(
                              fontSize: getFont(14),
                              fontWeight: FontWeight.normal,
                              color: MyColors.white)),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => PrivacyPolicy());
                        },
                        child: Text(
                          Strings.privacy,
                          style: Get.textTheme.subtitle2!.copyWith(
                            fontSize: getFont(14),
                            fontWeight: FontWeight.normal,
                            color: MyColors.secondaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Text(
                        ".",
                        style: Get.textTheme.subtitle2!.copyWith(
                          fontSize: getFont(14),
                          fontWeight: FontWeight.normal,
                          color: MyColors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
