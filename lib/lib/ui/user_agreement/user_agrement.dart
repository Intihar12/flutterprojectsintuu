import 'package:antrakuserinc/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../controllers/useragrement/user_agreement.dart';
import '../auth/email_verification.dart';
import '../auth/login/login.dart';
import '../values/dimens.dart';
import '../values/my_colors.dart';
import '../values/size_config.dart';
import '../widgets/custom_button.dart';

class UserAgreement extends StatelessWidget {
  int? pdid;
  UserAgreement({Key? key, this.pdid}) : super(key: key);
  UserAgreementController controller = Get.put(UserAgreementController());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
        height: getHeight(Dimens.size130),
        width: getWidth(mediaQuery.width),
        child: Obx(
          () => Column(
            children: [
              SizedBox(
                height: getHeight(Dimens.size10),
              ),
              Row(
                children: [
                  Checkbox(
                      value: controller.showButton.value,
                      onChanged: (value) {
                        controller.showButton.value = value!;
                        controller.update();
                      }),
                  SizedBox(
                    width: getWidth(Dimens.size10),
                  ),
                  Text("Check inbox to proceed"),
                ],
              ),
              SizedBox(
                height: getHeight(Dimens.size5),
              ),
              controller.showButton.value == true
                  ? CustomButton(
                      height: getHeight(Dimens.size40),
                      width: getWidth(Dimens.size374),
                      text: "Accept agreement",
                      onPressed: () {
                        pdid == 2
                            ? Get.offAll(() => EmailVerification())
                            : Get.offAll(() => HomePage());
                      })
                  : CustomButton(
                      color: MyColors.grey.withOpacity(0.5),
                      textColor: MyColors.white,
                      height: getHeight(Dimens.size40),
                      width: getWidth(Dimens.size374),
                      text: "Accept agreement",
                      onPressed: () {}),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("User Agreement"),
      ),
      body: WebView(
        initialUrl: "https://antrakdelivery.com/user_agreement",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          controller.controller.complete(webViewController);
        },
      ),
    );
  }
}
