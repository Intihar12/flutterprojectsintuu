import 'package:antrakuserinc/controllers/auth_controller/auth_controller.dart';
import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/size_config.dart';
import 'package:antrakuserinc/ui/values/strings.dart';
import 'package:antrakuserinc/ui/widgets/custom_button.dart';
import 'package:antrakuserinc/ui/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../password_screens/change_forgot_password.dart';
import '../widgets/time_countdown.dart';

class EmailVerification extends StatelessWidget {
  @override
  final authController = Get.put(AuthController());
  final  CountDownController timerController = CountDownController();


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
                authController.onVerifyPopScope();
              },
              child: Icon(Icons.arrow_back_ios, color: MyColors.black,)),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.size20),
              child: Container(
                child: Form(
                  key: authController.otpFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: getHeight(Dimens.size150),
                      ),
                      Text(
                        Strings.email_verification,
                        style: textTheme.headline1,
                      ),
                      SizedBox(
                        height: getHeight(Dimens.size25),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          Strings.emailtext,
                          style: textTheme.bodyText1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: getHeight(Dimens.size30),
                      ),
                      CustomTextField(
                          controller: authController.otp,
                          validator: (value) {
                            return authController.validation.otpValue(value!);
                          },
                          text: Strings.resetOtp,
                          length: 4,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter),
                      SizedBox(
                        height: getHeight(Dimens.size10),
                      ),
                      GetBuilder<AuthController>(
                        builder: (context) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: getWidth(double.infinity),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Visibility(
                                      visible: authController.resendOtp,
                                      child: GestureDetector(
                                        onTap: (){
                                          authController.otpResendApi();
                                        },
                                        child: Text(
                                          Strings.resendOTP,
                                          style: textTheme.caption!.copyWith(color: MyColors.primaryColor,
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ) ,
                              Visibility(
                                visible: !authController.resendOtp,
                                child: CircularCountDownTimer(
                                  duration: 30,
                                  initialDuration: 0,
                                  controller: timerController,
                                  width: getHeight(40),
                                  height: getWidth(40),
                                  ringColor: MyColors.primaryColor,
                                  fillColor: MyColors.secondaryColor,

                                  backgroundColor: MyColors.greyFont,

                                  strokeWidth: 5.0,
                                  strokeCap: StrokeCap.round,
                                  textStyle: TextStyle(
                                      fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                                  textFormat: CountdownTextFormat.S,
                                  isReverse: true,
                                  isReverseAnimation: true,
                                  isTimerTextShown: true,
                                    autoStart: true,

                                  onComplete: () {
                                    authController.resendOtp=true;
                                    authController.update();
                                  },
                                ),
                              ),
                            ],
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
                            authController.verifyButton();
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
