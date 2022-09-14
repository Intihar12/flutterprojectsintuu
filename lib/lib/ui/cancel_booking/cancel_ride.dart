
import 'package:antrakuserinc/controllers/cancel_ride_controller/cancel_ride_controller.dart';
import 'package:antrakuserinc/controllers/home_controller/home_controller.dart';
import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/strings.dart';
import 'package:antrakuserinc/ui/widgets/custom_button.dart';
import 'package:antrakuserinc/ui/widgets/custom_textfield.dart';
import 'package:date_picker_timeline/extra/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../values/size_config.dart';

class CancelRide extends GetView<CancelRideController> {
  String orderID;
  CancelRide({required this.orderID});

  var rideController = Get.put(CancelRideController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: (){
        return rideController.onPopScope();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.white,
          elevation: 0,
          leading: GestureDetector(
              onTap: () {
                rideController.onPopScope();
              },
              child: Icon(Icons.arrow_back_ios, color: MyColors.black,)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  Strings.cancelReason,
                  style:
                      textTheme.headline3!.copyWith(color: MyColors.primaryColor),
                ),
                controller.obx(
                    (data)=> Container(
                      height: getHeight(Dimens.size400),
                      width: getWidth(mediaQuery.width),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: data!.response!.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(
                              height: getHeight(Dimens.size10),
                            ),
                        itemBuilder: (context, index) {
                          return  Obx(() {
                            return RadioListTile(
                              activeColor: MyColors.black,
                              contentPadding: EdgeInsets.zero,
                              title:  Text('${data.response![index].reasonText}'),
                              value: index,
                              groupValue: rideController.groupvalue.value,
                              onChanged: (value) {
                                rideController.groupvalue.value = value as int;
                                SingleToneValue.instance.cancelReason=data.response![index].reasonText.toString();
                              },
                            );
                          });
                        },
                      ),
                    ),
                  onLoading: Shimmer.fromColors(
                      baseColor: MyColors.grey.withOpacity(0.2),
                      highlightColor: MyColors.white,
                      child: Container(
                        height: getHeight(Dimens.size400),
                        width: getWidth(mediaQuery.width),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: 6,
                          separatorBuilder: (context, index) =>
                              SizedBox(
                                height: getHeight(Dimens.size10),
                              ),
                          itemBuilder: (context, index) {
                            return  Obx(() {
                              return RadioListTile(
                                activeColor: MyColors.black,
                                contentPadding: EdgeInsets.zero,
                                title:  Text(''),
                                value: index,
                                groupValue: rideController.groupvalue.value,
                                onChanged: (value) {
                                },
                              );
                            });
                          },
                        ),
                      ),),
                ),

                SizedBox(
                  height: getHeight(Dimens.size10),
                ),
                Text(
                  Strings.moreDetails,
                  style:
                      textTheme.headline3!.copyWith(color: MyColors.primaryColor),
                ),
                CustomTextField(
                    text: Strings.addCommentc,
                    length: 200,
                    maxlines: 4,
                    controller: rideController.noteController,
                    height: getHeight(Dimens.size120),
                    keyboardType: TextInputType.text,
                    inputFormatters:
                        FilteringTextInputFormatter.singleLineFormatter),
                SizedBox(
                  height: getHeight(Dimens.size40),
                ),
                CustomButton(
                    height: getHeight(Dimens.size45),
                    width: getWidth(Dimens.size250),
                    text: Strings.submitBtn,
                    onPressed: () {
                      rideController.cancelBtn(orderID);
                    }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
