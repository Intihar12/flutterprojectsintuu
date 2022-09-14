import 'package:antrakuserinc/controllers/track_order_controller/track_order_controller.dart';
import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:antrakuserinc/ui/order/order_details.dart';

import 'package:antrakuserinc/ui/values/size_config.dart';
import 'package:date_picker_timeline/extra/dimen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../chat/order_chat_screen.dart';
import '../track_on_map/track_on_map.dart';
import '../values/dimens.dart';
import '../values/my_colors.dart';
import '../values/my_imgs.dart';
import '../values/strings.dart';
import '../widgets/custom_button.dart';

class OrderTrack extends GetView<TrackOrderController> {
  String status;
  String pickAddress;
  String dropAddress;
  OrderTrack(
      {required this.status,
      required this.pickAddress,
      required this.dropAddress});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    int _index = 0;
    return SafeArea(
        child: WillPopScope(
      onWillPop: () {
        return controller.onPopScope();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Order Tracking"),
          elevation: 0,
          leading: GestureDetector(
              onTap: () {
                controller.onPopScope();
              },
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return controller.trackOrder(SingleToneValue.instance.orderId);
          },
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(Dimens.size20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.orderStatus,
                          style: textTheme.headline2,
                        ),
                        Row(
                          children: [
                            Text(
                              Strings.order,
                              style: textTheme.subtitle2,
                            ),
                            Text(
                              "${Strings.ant}${SingleToneValue.instance.orderId}",
                              style: textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size10),
                    ),
                    Text(
                      "${Strings.progress} : $status",
                      style: textTheme.caption!
                          .copyWith(color: MyColors.yellow, fontSize: 15),
                    ),
                    SizedBox(
                      width: getWidth(Dimens.size20),
                    ),
                    Text(
                      "Security Code : ${SingleToneValue.instance.securityNo}",
                      style: textTheme.caption!
                          .copyWith(color: MyColors.primaryColor, fontSize: 15),
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size10),
                    ),
                    Text(
                      pickAddress,
                      style: textTheme.headline3!.copyWith(fontSize: 16),
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size20),
                    ),
                    controller.obx(
                      (data) => Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: getHeight(Dimens.size300),
                            width: Dimens.size60,
                            //color: MyColors.yellow,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: getHeight(250),
                                  width: Dimens.size2,
                                  color: Get.theme.primaryColor,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: getHeight(Dimens.size30),
                                      width: Dimens.size30,
                                      decoration: BoxDecoration(
                                        color: data!.response!.length > 0 &&
                                                data.response![0].id != null
                                            ? Get.theme.primaryColor
                                            : MyColors.white,
                                        border: Border.all(
                                          color: data.response!.length > 0 &&
                                                  data.response![0].id != null
                                              ? Get.theme.primaryColor
                                              : MyColors.red500,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: data.response!.length > 0 &&
                                                data.response![0].id != null
                                            ? Image.asset(
                                                MyImgs.tick,
                                                height: Dimens.size30,
                                                width: Dimens.size30,
                                              )
                                            : null,
                                      ),
                                    ),
                                    Container(
                                      height: getHeight(Dimens.size30),
                                      width: Dimens.size30,
                                      decoration: BoxDecoration(
                                        color: data.response!.length > 1 &&
                                                data.response![1].id != null
                                            ? Get.theme.primaryColor
                                            : MyColors.white,
                                        border: Border.all(
                                          color: data.response!.length > 1 &&
                                                  data.response![1].id != null
                                              ? Get.theme.primaryColor
                                              : MyColors.red500,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: data.response!.length > 1 &&
                                                data.response![1].id != null
                                            ? Image.asset(
                                                MyImgs.tick,
                                                height: Dimens.size30,
                                                width: Dimens.size30,
                                              )
                                            : null,
                                      ),
                                    ),
                                    Container(
                                      height: getHeight(Dimens.size30),
                                      width: Dimens.size30,
                                      decoration: BoxDecoration(
                                        color: data.response!.length > 2 &&
                                                data.response![2].id != null
                                            ? Get.theme.primaryColor
                                            : MyColors.white,
                                        border: Border.all(
                                          color: data.response!.length > 2 &&
                                                  data.response![2].id != null
                                              ? Get.theme.primaryColor
                                              : MyColors.red500,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: data.response!.length > 2 &&
                                                data.response![2].id != null
                                            ? Image.asset(
                                                MyImgs.tick,
                                                height: Dimens.size30,
                                                width: Dimens.size30,
                                              )
                                            : null,
                                      ),
                                    ),
                                    Container(
                                      height: getHeight(Dimens.size30),
                                      width: Dimens.size30,
                                      decoration: BoxDecoration(
                                        color: data.response!.length > 3 &&
                                                data.response![3].id != null
                                            ? Get.theme.primaryColor
                                            : MyColors.white,
                                        border: Border.all(
                                          color: data.response!.length > 3 &&
                                                  data.response![3].id != null
                                              ? Get.theme.primaryColor
                                              : MyColors.red500,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: data.response!.length > 3 &&
                                                data.response![3].id != null
                                            ? Image.asset(
                                                MyImgs.tick,
                                                height: Dimens.size30,
                                                width: Dimens.size30,
                                              )
                                            : null,
                                      ),
                                    ),
                                    Container(
                                      height: getHeight(Dimens.size30),
                                      width: Dimens.size30,
                                      decoration: BoxDecoration(
                                        color: data.response!.length > 4 &&
                                                data.response![4].id != null
                                            ? Get.theme.primaryColor
                                            : MyColors.white,
                                        border: Border.all(
                                          color: data.response!.length > 4 &&
                                                  data.response![4].id != null
                                              ? Get.theme.primaryColor
                                              : MyColors.red500,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: data.response!.length > 4 &&
                                                data.response![4].id != null
                                            ? Image.asset(
                                                MyImgs.tick,
                                                height: Dimens.size30,
                                                width: Dimens.size30,
                                              )
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Dimens.size20,
                          ),
                          Container(
                            height: getHeight(Dimens.size300),
                            width: Dimens.size180,
                            color: MyColors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Strings.status1,
                                      style: textTheme.bodyText1,
                                    ),
                                    data.response!.length > 0 &&
                                            data.response![0].id != null
                                        ? Text(
                                            "${data.response![0].time}",
                                            style: textTheme.caption,
                                          )
                                        : Text(""),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Strings.status2,
                                      style: textTheme.bodyText1,
                                    ),
                                    data.response!.length > 1 &&
                                            data.response![1].id != null
                                        ? Text(
                                            "${data.response![1].time}",
                                            style: textTheme.caption,
                                          )
                                        : Text(""),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Strings.status3,
                                      style: textTheme.bodyText1,
                                    ),
                                    data.response!.length > 2 &&
                                            data.response![2].id != null
                                        ? Text(
                                            "${data.response![2].time}",
                                            style: textTheme.caption,
                                          )
                                        : Text(""),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Strings.status4,
                                      style: textTheme.bodyText1,
                                    ),
                                    data.response!.length > 3 &&
                                            data.response![3].id != null
                                        ? Text(
                                            "${data.response![3].time}",
                                            style: textTheme.caption,
                                          )
                                        : Text(""),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Strings.status5,
                                      style: textTheme.bodyText1,
                                    ),
                                    data.response!.length > 4 &&
                                            data.response![4].id != null
                                        ? Text(
                                            "${data.response![4].time}",
                                            style: textTheme.caption,
                                          )
                                        : Text(""),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      onLoading: Shimmer.fromColors(
                        baseColor: MyColors.grey.withOpacity(0.08),
                        highlightColor: MyColors.white,
                        child: ShimarOnTrack(),
                      ),
                      onError: (error) => Text(error!),
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size20),
                    ),
                    Text(
                      dropAddress,
                      style: textTheme.headline3!.copyWith(fontSize: 16),
                    ),
                    controller.obx(
                      (data) => Column(
                        children: [
                          SizedBox(
                            height: getHeight(Dimens.size40),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.makePhoneCall(
                                      SingleToneValue.instance.driverPhone!);
                                },
                                child: Container(
                                  height: getHeight(Dimens.size40),
                                  width: getWidth(Dimens.size170),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: MyColors.secondaryColor,
                                          width: 0.5),
                                      borderRadius:
                                          BorderRadius.circular(Dimens.size5),
                                      color: MyColors.white),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        MyImgs.phone,
                                        height: getHeight(Dimens.size20),
                                        width: getWidth(Dimens.size20),
                                      ),
                                      SizedBox(
                                        width: getWidth(Dimens.size10),
                                      ),
                                      Text(Strings.call,
                                          style: textTheme.headline6!.copyWith(
                                              color: MyColors.secondaryColor))
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => OrderChatPage(
                                        orderID: SingleToneValue
                                            .instance.orderId
                                            .toString(),
                                        requestId: int.parse(SingleToneValue
                                            .instance.orderId
                                            .toString()),
                                        theirName: SingleToneValue
                                            .instance.driverName
                                            .toString(),
                                      ));
                                },
                                child: Container(
                                  height: getHeight(Dimens.size40),
                                  width: getWidth(Dimens.size170),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: MyColors.secondaryColor,
                                          width: 0.5),
                                      borderRadius:
                                          BorderRadius.circular(Dimens.size5),
                                      color: MyColors.white),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        MyImgs.sms,
                                        height: getHeight(Dimens.size20),
                                        width: getWidth(Dimens.size20),
                                      ),
                                      SizedBox(
                                        width: getWidth(Dimens.size10),
                                      ),
                                      Text(Strings.msg,
                                          style: textTheme.headline4!.copyWith(
                                              color: MyColors.secondaryColor))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getHeight(Dimens.size20),
                          ),
                          CustomButton(
                              height: getHeight(Dimens.size40),
                              width: getWidth(374),
                              text: Strings.mapTrackBtn,
                              onPressed: () {
                                Get.to(TrackonMap());
                              }),
                          SizedBox(
                            height: getHeight(Dimens.size10),
                          ),
                          CustomButton(
                              height: getHeight(Dimens.size40),
                              width: getWidth(374),
                              color: MyColors.transparent,
                              textColor: MyColors.black,
                              text: Strings.detailBtn,
                              onPressed: () {
                                Get.to(OrderDetails());
                              }),
                        ],
                      ),
                      onLoading: Shimmer.fromColors(
                        baseColor: MyColors.grey.withOpacity(0.08),
                        highlightColor: MyColors.white,
                        child: Column(
                          children: [
                            SizedBox(
                              height: getHeight(Dimens.size40),
                            ),
                            CustomButton(
                                height: getHeight(Dimens.size40),
                                width: getWidth(374),
                                text: Strings.mapTrackBtn,
                                onPressed: () {}),
                            SizedBox(
                              height: getHeight(Dimens.size10),
                            ),
                            CustomButton(
                                height: getHeight(Dimens.size40),
                                width: getWidth(374),
                                color: MyColors.transparent,
                                textColor: MyColors.black,
                                text: Strings.detailBtn,
                                onPressed: () {}),
                          ],
                        ),
                      ),
                      onError: (error) => Text("Something Went Wrong!"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class ShimarOnTrack extends StatelessWidget {
  const ShimarOnTrack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: getHeight(Dimens.size300),
              width: Dimens.size60,
              //color: MyColors.yellow,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: getHeight(250),
                    width: Dimens.size2,
                    color: Get.theme.primaryColor,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: getHeight(Dimens.size30),
                        width: Dimens.size30,
                        decoration: BoxDecoration(
                          color: Get.theme.primaryColor,
                          border: Border.all(
                            color: Get.theme.primaryColor,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        height: getHeight(Dimens.size30),
                        width: Dimens.size30,
                        decoration: BoxDecoration(
                          color: Get.theme.primaryColor,
                          border: Border.all(
                            color: Get.theme.primaryColor,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        height: getHeight(Dimens.size30),
                        width: Dimens.size30,
                        decoration: BoxDecoration(
                          color: Get.theme.primaryColor,
                          border: Border.all(
                            color: Get.theme.primaryColor,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        height: getHeight(Dimens.size30),
                        width: Dimens.size30,
                        decoration: BoxDecoration(
                          color: Get.theme.primaryColor,
                          border: Border.all(
                            color: Get.theme.primaryColor,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        height: getHeight(Dimens.size30),
                        width: Dimens.size30,
                        decoration: BoxDecoration(
                          color: Get.theme.primaryColor,
                          border: Border.all(
                            color: Get.theme.primaryColor,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Dimens.size20,
            ),
            Container(
              height: getHeight(Dimens.size300),
              width: Dimens.size180,
              //color: MyColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.status1,
                    style: textTheme.bodyText1,
                  ),
                  Text(
                    Strings.status2,
                    style: textTheme.bodyText1,
                  ),
                  Text(
                    Strings.status3,
                    style: textTheme.bodyText1,
                  ),
                  Text(
                    Strings.status4,
                    style: textTheme.bodyText1,
                  ),
                  Text(
                    Strings.status5,
                    style: textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
