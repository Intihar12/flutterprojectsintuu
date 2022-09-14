import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:antrakuserinc/ui/home/home_page.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/my_imgs.dart';
import 'package:antrakuserinc/ui/values/size_config.dart';
import 'package:antrakuserinc/ui/values/strings.dart';
import 'package:antrakuserinc/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderConfirmed extends StatelessWidget {
  const OrderConfirmed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
                height: getHeight(Dimens.size150),
                width: getWidth(Dimens.size150),
                child: Image.asset(MyImgs.orderconfirm)),
          ),
          SizedBox(
            height: getHeight(Dimens.size10),
          ),
          Text(
            Strings.orderConfirmed,
            style: textTheme.headline1!.copyWith(color: MyColors.primaryColor),
          ),
          SizedBox(
            height: getHeight(Dimens.size10),
          ),
          SizedBox(
            width: getWidth(Dimens.size300),
            child: Text(
              "${Strings.ant}${Strings.orderConfirmedDes} ${SingleToneValue.instance.orderId}",
              style: textTheme.bodyText2!.copyWith(color: MyColors.grey72),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: getHeight(Dimens.size10),
          ),
          SizedBox(
            width: getWidth(Dimens.size300),
            child: CustomButton(
                height: getHeight(Dimens.size45),
                width: getWidth(Dimens.size300),
                text: Strings.done,
                onPressed: () {
                  Get.offAll(HomePage());
                }),
          )
        ],
      ),
    );
  }
}
