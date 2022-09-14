
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/strings.dart';
import 'package:antrakuserinc/ui/widgets/custom_button.dart';
import 'package:antrakuserinc/ui/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/password_controller/password_controller.dart';
import '../values/dimens.dart';
import '../values/size_config.dart';

class ChangeForgotPassword extends StatelessWidget {
  String uId;
  String rId;
  ChangeForgotPassword({required this.uId, required this.rId});

  PasswordController passwordController = Get.put(PasswordController());


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return passwordController.onResetPopScope();
        },
        child: Scaffold(
          backgroundColor: MyColors.appBackground,
          appBar: AppBar(
            backgroundColor: MyColors.white,
            elevation: 0,
            leading: GestureDetector(
                onTap: () {
                  passwordController.onResetPopScope();
                },
                child: Icon(Icons.arrow_back_ios, color: MyColors.black,)),
          ),
          body: GestureDetector(
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Padding(
              padding: const EdgeInsets.all(Dimens.size20),
              child: Container(
                child: Form(
                  key: passwordController.resetFormkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Strings.resetPass, style: textTheme.headline1,),
                      SizedBox(height: getHeight(Dimens.size30),),
                      CustomTextField(
                          text: Strings.resetOtp,
                          controller: passwordController.otpController,
                          length: 50,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters:
                          FilteringTextInputFormatter.singleLineFormatter),
                      SizedBox(height: getHeight(Dimens.size20),),
                      CustomTextField(
                          text: Strings.enterNew,
                          controller: passwordController.newPassController,
                          length: 50,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters:
                          FilteringTextInputFormatter.singleLineFormatter),
                      SizedBox(height: getHeight(Dimens.size20),),
                      CustomTextField(
                          text: Strings.confirmNew,
                          length: 50,
                          controller: passwordController.confirmPassController,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters:
                          FilteringTextInputFormatter.singleLineFormatter),
                      SizedBox(height: getHeight(Dimens.size30),),
                      CustomButton(
                          height: getHeight(Dimens.size40),
                          width: getWidth(374),
                          text: Strings.Continue,
                          onPressed: () {
                            passwordController.onResetBtn(uId, rId);
                          }),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


