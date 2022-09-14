import 'package:antrakuserinc/ui/profile/change_password.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/my_imgs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Account Setting"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
        child: Column(
          children: [
            SizedBox(
              height: Dimens.size15,
            ),
            Divider(
              color: MyColors.black,
              thickness: 0.5,
            ),
            Row(
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
            Divider(
              color: MyColors.black,
              thickness: 0.5,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => ChangePassword());
              },
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
            Divider(
              color: MyColors.black,
              thickness: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
