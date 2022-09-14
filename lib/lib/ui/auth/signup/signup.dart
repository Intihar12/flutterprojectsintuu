import 'package:antrakuserinc/controllers/auth_controller/auth_controller.dart';
import 'package:antrakuserinc/ui/auth/login/login.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/my_imgs.dart';
import 'package:antrakuserinc/ui/values/size_config.dart';
import 'package:antrakuserinc/ui/widgets/custom_textfield.dart';
import 'package:antrakuserinc/ui/widgets/phone_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/singleton/singleton.dart';
import '../../home/home_page.dart';
import '../../values/strings.dart';
import '../../widgets/custom_button.dart';

class SignUp extends StatelessWidget {
  final bool? readOnly;
  SignUp({Key? key, this.readOnly}) : super(key: key);

  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.appBackground,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(Dimens.size20),
            child: Form(
              key: authController.registerFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: getHeight(Dimens.size30)),
                  Text(
                    Strings.signUp,
                    style: textTheme.headline1,
                  ),
                  SizedBox(height: getHeight(Dimens.size30)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.fName,
                                style: textTheme.subtitle2!
                                    .copyWith(fontSize: getFont(12)),
                              ),
                              SizedBox(height: getHeight(Dimens.size5)),
                              CustomTextField(
                                  height: getHeight(Dimens.size40),
                                  onChanged: (value) {
                                    authController.update();
                                  },
                                  validator: (value) {
                                    return authController.validation
                                        .nameValidation(value!);
                                  },
                                  controller: authController.firstName,
                                  text: Strings.fNametxt,
                                  length: 50,
                                  width: getWidth(Dimens.size150),
                                  keyboardType: TextInputType.emailAddress,
                                  inputFormatters: FilteringTextInputFormatter
                                      .singleLineFormatter),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.sName,
                                style: textTheme.subtitle2!
                                    .copyWith(fontSize: getFont(12)),
                              ),
                              SizedBox(height: getHeight(Dimens.size5)),
                              CustomTextField(
                                  validator: (value) {
                                    return authController.validation
                                        .lastNameValidation(value!);
                                  },
                                  controller: authController.lastName,
                                  text: Strings.sNametxt,
                                  length: 50,
                                  width: getWidth(Dimens.size150),
                                  keyboardType: TextInputType.emailAddress,
                                  inputFormatters: FilteringTextInputFormatter
                                      .singleLineFormatter),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: getHeight(Dimens.size20)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.email,
                            style: textTheme.subtitle2!
                                .copyWith(fontSize: getFont(12)),
                          ),
                          SizedBox(height: getHeight(Dimens.size5)),
                          GetBuilder<AuthController>(builder: (context) {
                            return CustomTextField(
                              Readonly: readOnly,
                              controller: authController.email,
                              text: Strings.signEmail,
                              length: 50,
                              autovalidateMode:
                                  authController.email.text.length >= 1
                                      ? AutovalidateMode.onUserInteraction
                                      : AutovalidateMode.disabled,
                              onChanged: (value) {
                                authController.update();
                              },
                              keyboardType: TextInputType.emailAddress,
                              inputFormatters: FilteringTextInputFormatter.deny(
                                  RegExp('[ ]')),
                            );
                          }),
                        ],
                      ),
                      SizedBox(height: getHeight(Dimens.size20)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.singPhone,
                            style: textTheme.subtitle2!
                                .copyWith(fontSize: getFont(12)),
                          ),
                          SizedBox(height: getHeight(Dimens.size5)),
                          PhonePicker(
                              countryCode: '+1',
                              controller: authController.phone),
                        ],
                      ),
                      SizedBox(height: getHeight(Dimens.size20)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.singPass,
                            style: textTheme.subtitle2!
                                .copyWith(fontSize: getFont(12)),
                          ),
                          SizedBox(height: getHeight(Dimens.size5)),
                          CustomTextField(
                              obscureText: true,
                              sufficon: 1,
                              validator: (value) {
                                return authController.validation
                                    .passwordValidation(value!);
                              },
                              controller: authController.password,
                              text: '********',
                              length: 50,
                              keyboardType: TextInputType.emailAddress,
                              inputFormatters: FilteringTextInputFormatter
                                  .singleLineFormatter),
                        ],
                      ),
                      SizedBox(height: getHeight(Dimens.size20)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.signCpass,
                            style: textTheme.subtitle2!
                                .copyWith(fontSize: getFont(12)),
                          ),
                          SizedBox(height: getHeight(Dimens.size5)),
                          CustomTextField(
                              obscureText: true,
                              sufficon: 1,
                              controller: authController.confirmpassword,
                              text: '********',
                              textInputAction: TextInputAction.done,
                              length: 50,
                              keyboardType: TextInputType.emailAddress,
                              inputFormatters: FilteringTextInputFormatter
                                  .singleLineFormatter),
                        ],
                      ),
                      SizedBox(height: getHeight(Dimens.size30)),
                      CustomButton(
                          height: getHeight(Dimens.size40),
                          width: getWidth(374),
                          text: Strings.createNewAccount,
                          onPressed: () {
                            readOnly == true
                                ? authController.emailCheckRegister(
                                    authController.email.text, '1')
                                : authController.emailCheckRegister(
                                    authController.email.text, '0');

                            // Get.to(() => HomePage());
                          }),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          /*Text(Strings.or,
                              style: textTheme.subtitle2!
                                  .copyWith(fontWeight: FontWeight.w500)),
                          SizedBox(height: getHeight(Dimens.size25)),*/
                          /*GoogleButton(
                              // onTap: () {},
                              ),*/
                          SizedBox(height: getHeight(Dimens.size15)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(Strings.have_an_account,
                                  style: textTheme.caption),
                              GestureDetector(
                                  onTap: () {
                                    Get.offAll(() => Login());
                                  },
                                  child: Text(Strings.signInnow,
                                      style: textTheme.subtitle1!.copyWith(
                                          color: MyColors.darkBlue,
                                          fontWeight: FontWeight.w400))),
                              SizedBox(height: getHeight(Dimens.size30)),
                              Text(Strings.now, style: textTheme.caption),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
