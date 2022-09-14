import 'package:antrakuserinc/controllers/auth_controller/auth_controller.dart';
import 'package:antrakuserinc/ui/customer_support/customer_Support.dart';
import 'package:antrakuserinc/ui/home/home_page.dart';
import 'package:antrakuserinc/ui/payment/saved_card_screen.dart';
import 'package:antrakuserinc/ui/profile/account_setting.dart';
import 'package:antrakuserinc/ui/profile/edit_profile.dart';
import 'package:antrakuserinc/ui/profile/privacy_policy.dart';
import 'package:antrakuserinc/ui/profile/terms_&_conditions.dart';
import 'package:antrakuserinc/ui/saved_address/save_address_profile.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/strings.dart';
import 'package:antrakuserinc/ui/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../values/my_imgs.dart';
import '../values/size_config.dart';
import 'change_password.dart';

class ProfileDrawer extends StatelessWidget {
  ProfileDrawer({Key? key}) : super(key: key);

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return WillPopScope(
      onWillPop: () {
        return onBack();
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getHeight(Dimens.size60),
            ),

            Center(
              child: Container(
                height: getHeight(Dimens.size80),
                width: getWidth(Dimens.size80),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.orderHistory,
                ),
                child: Center(
                  child: Text(
                    "${GetStorage().read("name").toString().substring(0, 1).capitalize}${GetStorage().read("last_name").toString().substring(0, 1).capitalize}",
                    // "ZA",
                    style: textTheme.headline2!
                        .copyWith(color: MyColors.primaryColor),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getHeight(10),
            ),
            Center(
              child: Text(
                "${GetStorage().read("name").toString().capitalizeFirst} ${GetStorage().read("last_name").toString().capitalizeFirst}",
                style:
                    textTheme.headline2!.copyWith(color: MyColors.primaryColor),
              ),
            ),
            SizedBox(
              height: getHeight(20),
            ),

            Divider(
              color: MyColors.black,
              thickness: 0.5,
            ),
            GestureDetector(
              onTap: () {
                Get.offAll(() => SavedCards(
                      pgID: 1,
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          MyImgs.cards,
                          height: Dimens.size15,
                          width: Dimens.size15,
                        ),
                        SizedBox(
                          width: Dimens.size10,
                        ),
                        Text(
                          "My Cards",
                          style: textTheme.headline4!
                              .copyWith(color: MyColors.primaryColor),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: MyColors.primaryColor,
                      size: Dimens.size15,
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: MyColors.black,
              thickness: 0.5,
            ),
            SizedBox(
              height: getHeight(10),
            ),
            Divider(
              color: MyColors.black,
              thickness: 0.5,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => SavedAddressProfile());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          MyImgs.address,
                          height: Dimens.size15,
                          width: Dimens.size15,
                        ),
                        SizedBox(
                          width: Dimens.size10,
                        ),
                        Text(
                          "Saved Addresses",
                          style: textTheme.headline4!
                              .copyWith(color: MyColors.primaryColor),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: MyColors.primaryColor,
                      size: Dimens.size15,
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: MyColors.black,
              thickness: 0.5,
            ),

            SizedBox(
              height: getHeight(10),
            ),
            Divider(
              color: MyColors.black,
              thickness: 0.5,
            ),
            GestureDetector(
              onTap: () {
                Get.to(EditProfile());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          MyImgs.editProfile,
                          height: Dimens.size15,
                          width: Dimens.size15,
                        ),
                        SizedBox(
                          width: Dimens.size10,
                        ),
                        Text(
                          "Edit Profile",
                          style: textTheme.headline4!
                              .copyWith(color: MyColors.primaryColor),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: MyColors.primaryColor,
                      size: Dimens.size15,
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: MyColors.black,
              thickness: 0.5,
            ),
            SizedBox(
              height: getHeight(10),
            ),
            Divider(
              color: MyColors.black,
              thickness: 0.5,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => ChangePassword());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          MyImgs.changePassword,
                          height: Dimens.size15,
                          width: Dimens.size15,
                        ),
                        SizedBox(
                          width: Dimens.size10,
                        ),
                        Text(
                          "Change Password",
                          style: textTheme.headline4!
                              .copyWith(color: MyColors.primaryColor),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: MyColors.primaryColor,
                      size: Dimens.size15,
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: MyColors.black,
              thickness: 0.5,
            ),

            SizedBox(
              height: getHeight(20),
            ),
            GestureDetector(
              onTap: () {
                Get.to(CustomerSupport());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
                child: Text(
                  Strings.help,
                  style: textTheme.headline4!
                      .copyWith(color: MyColors.primaryColor),
                ),
              ),
            ),
            SizedBox(
              height: getHeight(10),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => PrivacyPolicy());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
                child: Text(
                  Strings.privacy,
                  style: textTheme.headline4!
                      .copyWith(color: MyColors.primaryColor),
                ),
              ),
            ),
            SizedBox(
              height: getHeight(10),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => TermsAndConditions());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
                child: Text(
                  Strings.terms,
                  style: textTheme.headline4!
                      .copyWith(color: MyColors.primaryColor),
                ),
              ),
            ),
            SizedBox(
              height: getHeight(10),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
              child: GestureDetector(
                onTap: () {
                  authController.logoutButton();
                },
                child: Text(
                  Strings.logout,
                  style: textTheme.headline4!
                      .copyWith(color: MyColors.primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onBack() {
    Get.offAll(() => HomePage());
  }
}
