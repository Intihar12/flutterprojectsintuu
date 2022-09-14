import 'package:antrakuserinc/controllers/auth_controller/auth_controller.dart';
import 'package:antrakuserinc/ui/profile/profile_drawer.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../values/size_config.dart';
import '../values/strings.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);

  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return WillPopScope(
      onWillPop: (){
        return onPopScope();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Strings.changePassword),
          leading: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Get.off(() => ProfileDrawer());
                authController.oldPasswordController.clear();
                authController.confirmNewPasswordController.clear();
                authController.newPasswordController.clear();
              },
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
              child: Form(
                key: authController.changePasswordKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: getHeight(Dimens.size200),
                    ),
                    Text(
                      Strings.changePassword,
                      style: textTheme.headline1!
                          .copyWith(color: MyColors.primaryColor),
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size20),
                    ),
                    CustomTextField(
                        controller: authController.oldPasswordController,
                        text: Strings.enterOldPassword,
                        length: 50,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters:
                            FilteringTextInputFormatter.singleLineFormatter),
                    SizedBox(height: getHeight(Dimens.size20),),
                    CustomTextField(
                        controller: authController.newPasswordController,
                        text: Strings.enterNewPassword,
                        length: 50,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        inputFormatters:
                            FilteringTextInputFormatter.singleLineFormatter),
                    SizedBox(height: getHeight(Dimens.size20),),

                    CustomTextField(
                        controller: authController.confirmNewPasswordController,
                        text: Strings.enterConfirmPassword,
                        textInputAction: TextInputAction.done,
                        length: 50,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters:
                            FilteringTextInputFormatter.singleLineFormatter),
                    SizedBox(
                      height: getHeight(Dimens.size30),
                    ),
                    CustomButton(
                        height: getHeight(Dimens.size40),
                        width: getWidth(374),
                        text: Strings.confirm,
                        onPressed: () {
                          authController.onChangePasswordButton();
                          // Get.off(() => HomePage());
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  onPopScope(){
    Get.off(() => ProfileDrawer());
    authController.oldPasswordController.clear();
    authController.confirmNewPasswordController.clear();
    authController.newPasswordController.clear();
  }
}
