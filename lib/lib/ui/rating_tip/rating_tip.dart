import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:antrakuserinc/ui/home/home_page.dart';
import 'package:antrakuserinc/ui/values/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';

import '../../controllers/parcel_controller/parcel_controller.dart';
import '../order/order_details.dart';
import '../track_on_map/track_on_map.dart';
import '../values/dimens.dart';
import '../values/my_colors.dart';
import '../values/my_imgs.dart';
import '../values/strings.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class RatingTip extends StatelessWidget {
  final ratingController = Get.put(ParcelController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Experience"),
        leading: GestureDetector(
            onTap: () {
              return onBack();
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: WillPopScope(
        onWillPop: () {
          return onBack();
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Dimens.size20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: getHeight(Dimens.size190),
                    width: double.infinity,
                    color: MyColors.lightBlue.withOpacity(0.1),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: Dimens.size35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            Strings.rateHeadline,
                            style: textTheme.headline2!
                                .copyWith(color: MyColors.black),
                          ),
                          Text(Strings.rateDriver, style: textTheme.subtitle2),
                          RatingBar.builder(
                            itemSize: 30,
                            minRating: 1,
                            initialRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              SingleToneValue.instance.rating =
                                  rating.toString();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(Dimens.size50),
                  ),
                  Text(
                    Strings.rateHeadline,
                    style: textTheme.headline2!.copyWith(color: MyColors.black),
                  ),
                  SizedBox(
                    height: getHeight(Dimens.size20),
                  ),
                  GetBuilder<ParcelController>(builder: (context) {
                    return Container(
                      height: getHeight(Dimens.size50),
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: ratingController.tipList.length,
                        separatorBuilder: (context, index) => SizedBox(
                          width: getWidth(Dimens.size10),
                        ),
                        itemBuilder: (context, index) {
                          return TipBtn(
                              borderColor: ratingController.check == index
                                  ? MyColors.secondaryColor
                                  : MyColors.black,
                              text: ratingController.tipList[index],
                              onTap: () {
                                if (index == 4) {
                                  SingleToneValue.instance.tip =    ratingController.tipController.text;
                                  ratingController.check = index;
                                  if (ratingController.textFeild.value ==
                                      true) {
                                    ratingController.textFeild.value = false;
                                  } else {
                                    ratingController.textFeild.value = true;
                                  }
                                } else {
                                  ratingController.textFeild.value = false;
                                  ratingController.check = index;
                                  SingleToneValue.instance.tip =
                                      ratingController.tipPrice[index];
                                }

                                ratingController.update();
                              });
                        },
                      ),
                    );
                  }),
                  SizedBox(
                    height: getHeight(Dimens.size20),
                  ),
                  Obx(
                    () => Visibility(
                      visible: ratingController.textFeild.value,
                      child: CustomTextField(
                          controller: ratingController.tipController,
                          text: Strings.rateOtherAmount,
                          onChanged: (value){
                            SingleToneValue.instance.tip=value;
                            ratingController.update();
                          },
                          length: 50,
                          keyboardType: TextInputType.number,
                          inputFormatters:
                              FilteringTextInputFormatter.digitsOnly),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(Dimens.size50),
                  ),
                  CustomButton(
                      height: getHeight(Dimens.size40),
                      width: getWidth(374),
                      text: Strings.rateBtn,
                      onPressed: () {
                        ratingController.onAddRatingButton();
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  onBack() {
    if(SingleToneValue.instance.rideCompleted == "true"){
     Get.off(HomePage());
    }else {
      Get.off(() => OrderDetails());
    }
  }
}

class TipBtn extends StatelessWidget {
  final String text;
  final Function() onTap;
  final Color? borderColor;

  TipBtn({
    Key? key,
    required this.text,
    required this.onTap,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: getHeight(Dimens.size30),
        width: getWidth(Dimens.size70),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: borderColor ?? MyColors.addressCon, width: 1.5)),
        child: Center(
          child: Text(
            text,
            style: textTheme.headline4,
          ),
        ),
      ),
    );
  }
}
