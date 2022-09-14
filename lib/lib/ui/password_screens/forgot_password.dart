import 'package:antrakuserinc/controllers/auth_controller/auth_controller.dart';
import 'package:antrakuserinc/controllers/password_controller/password_controller.dart';
import 'package:antrakuserinc/ui/auth/login/login.dart';
import 'package:antrakuserinc/ui/auth/signup/signup.dart';
import 'package:antrakuserinc/ui/home/home_page.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/my_imgs.dart';
import 'package:antrakuserinc/ui/values/size_config.dart';
import 'package:antrakuserinc/ui/values/strings.dart';
import 'package:antrakuserinc/ui/widgets/custom_button.dart';
import 'package:antrakuserinc/ui/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'change_forgot_password.dart';

class ForgotPassword extends StatelessWidget {
  PasswordController passwordController = Get.put(PasswordController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.appBackground,
        appBar: AppBar(
          backgroundColor: MyColors.white,
          elevation: 0,
          leading: GestureDetector(
              onTap: () {
                passwordController.onPopScope();
              },
              child: Icon(Icons.arrow_back_ios, color: MyColors.black,)),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Padding(
            padding: const EdgeInsets.all(Dimens.size20),
            child: Container(
              child: Form(
                key: passwordController.emailFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.forgot_password,
                      style: textTheme.headline1,
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size25),
                    ),
                    Text(
                      Strings.text,
                      style: textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size30),
                    ),

                    GetBuilder<PasswordController>(
                      builder: (context) {
                        return CustomTextField(
                          text: Strings.example_email,
                          controller: passwordController.emailController,
                          length: 30,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: passwordController.emailController.text.length>=1 ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                          onChanged: (value){
                            passwordController.update();
                          },
                          inputFormatters: FilteringTextInputFormatter.deny(RegExp('[ ]')),

                        );
                      }
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size50),
                    ),
                    CustomButton(
                        height: getHeight(Dimens.size40),
                        width: getWidth(374),
                        text: Strings.Continue,
                        onPressed: () {
                          passwordController.onForgotBtn();
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
}
