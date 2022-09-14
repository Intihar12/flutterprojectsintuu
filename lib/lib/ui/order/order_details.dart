import 'package:antrakuserinc/controllers/Order_detail_controller/order_detail_controller.dart';
import 'package:antrakuserinc/data/constants/constants.dart';
import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:antrakuserinc/ui/rating_tip/rating_tip.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/my_imgs.dart';
import 'package:antrakuserinc/ui/values/strings.dart';
import 'package:antrakuserinc/ui/widgets/expandable_text_library.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../values/size_config.dart';

class OrderDetails extends GetView<OrderDetailController> {
  OrderDetails({Key? key}) : super(key: key);
  ScrollController scrollController = ScrollController();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Order Details"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: double.infinity,
            color: MyColors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      Strings.orderDetails,
                      style: textTheme.headline1!
                          .copyWith(color: MyColors.primaryColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Order #",
                          style: textTheme.bodyText2,
                        ),
                        Text(
                          "${Strings.ant}${SingleToneValue.instance.orderId}",
                          style: textTheme.headline5,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GetBuilder<OrderDetailController>(
                      builder: (controller) => Text(
                        "${Strings.orderstatus} : ${controller.orderStatus}",
                        style: textTheme.bodyText2!
                            .copyWith(color: MyColors.secondaryColor),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.requestDownload(
                            "${SingleToneValue.instance.orderId}");
                      },
                      child: Text(
                        Strings.download,
                        style: textTheme.bodyText2!
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
            child: controller.obx(
              (data) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getHeight(Dimens.size10),
                  ),
                  GetBuilder<OrderDetailController>(builder: (context) {
                    return int.parse("${data!.response!.bookingStatusId}") > 2
                        ? Container(
                            padding: EdgeInsets.all(Dimens.size20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimens.size5),
                              color: MyColors.addressCon,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: getHeight(Dimens.size40),
                                  width: getWidth(Dimens.size40),
                                  child: FadeInImage.assetNetwork(
                                    // fit: BoxFit.cover,
                                    placeholder: MyImgs.onLoading,
                                    height: getHeight(Dimens.size50),
                                    image:
                                        "${Constants.imagesBaseUrl}${data.response!.driverImage}",
                                    imageErrorBuilder:
                                        (context, e, stackTrace) => Image.asset(
                                      MyImgs.errorImage,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: getWidth(Dimens.size20),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data.response!.driverName}",
                                      style: textTheme.headline4,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (int.parse(
                                                    "${data.response!.bookingStatusId}") ==
                                                6 &&
                                            data.response!.rating == false) {
                                          Get.off(() => RatingTip());
                                        } else if (data.response!.rating ==
                                            true) {
                                          Fluttertoast.showToast(
                                            msg:
                                                "You are already rated the driver", // message
                                            toastLength:
                                                Toast.LENGTH_LONG, // length
                                            gravity: ToastGravity.CENTER,
                                            backgroundColor: MyColors.red500,
                                            textColor: MyColors.white,
                                            // location// duration
                                          );
                                        } else {
                                          Fluttertoast.showToast(
                                            msg:
                                                "You can rate driver after delivery is completed", // message
                                            toastLength:
                                                Toast.LENGTH_LONG, // length
                                            gravity: ToastGravity.CENTER,
                                            backgroundColor: MyColors.red500,
                                            textColor: MyColors.white,
                                            // location// duration
                                          );
                                        }
                                      },
                                      child: Text(
                                        Strings.feedback,
                                        style: textTheme.headline5!.copyWith(
                                            color: MyColors.secondaryColor,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Text("");
                  }),
                  SizedBox(
                    height: getHeight(Dimens.size10),
                  ),
                  Text(
                    Strings.pickup,
                    style: textTheme.headline3!
                        .copyWith(color: MyColors.primaryColor),
                  ),
                  Row(
                    children: [
                      Container(
                        height: getHeight(Dimens.size140),
                        width: getWidth(Dimens.size80),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name :",
                              style: textTheme.subtitle1!.copyWith(
                                  color: MyColors.black.withOpacity(0.4)),
                            ),
                            // Text(
                            //   "Email :",
                            //   style: textTheme.subtitle1!
                            //       .copyWith(color: MyColors.black.withOpacity(0.4)),
                            // ),
                            Text(
                              "Phone No :",
                              style: textTheme.subtitle1!.copyWith(
                                  color: MyColors.black.withOpacity(0.4)),
                            ),
                            Text(
                              "Address :",
                              style: textTheme.subtitle1!.copyWith(
                                  color: MyColors.black.withOpacity(0.4)),
                            ),
                            Text(
                              "Schedule:",
                              style: textTheme.subtitle1!.copyWith(
                                  color: MyColors.black.withOpacity(0.4)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: getHeight(Dimens.size140),
                        width: getWidth(Dimens.size300),
                        //   color: MyColors.red500,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${data!.response!.senderName}",
                              style: textTheme.headline5,
                            ),
                            // Text(
                            //   "ahsanahmad43@gmail.com",
                            //   style: textTheme.headline5,
                            // ),
                            Text(
                              "${data.response!.senderPhoneNum}",
                              style: textTheme.headline5,
                            ),
                            ExpandableText(
                              "${data.response!.pickupAddress}, ${data.response!.pickupCity}, ${data.response!.pickupState}, ${data.response!.pickupZip}",
                              style: textTheme.headline5,
                              expandText: 'show more',
                              collapseText: 'show less',
                              collapseOnTextTap: true,
                              maxLines: 1,
                              linkColor: Colors.blue,
                              animation: true,
                            ),
                            // Text(
                            //   "${data.response!.pickupAddress}, ${data.response!.pickupCity}, ${data.response!.pickupState}, ${data.response!.pickupZip}",
                            //   style: textTheme.headline5,
                            //   overflow: TextOverflow.ellipsis,
                            //   softWrap: true,
                            //   maxLines: 1,
                            // ),
                            Text(
                              "${data.response!.pickupTime}",
                              style: textTheme.headline5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: getWidth(Dimens.size70),
                        child: Text(
                          "Notes:",
                          style: textTheme.subtitle1!
                              .copyWith(color: MyColors.black.withOpacity(0.4)),
                        ),
                      ),
                      SizedBox(
                        width: getWidth(Dimens.size250),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ExpandableText(
                              "${data.response!.note}",
                              style: textTheme.headline5,
                              expandText: 'show more',
                              collapseText: 'show less',
                              collapseOnTextTap: true,
                              maxLines: 1,
                              linkColor: Colors.blue,
                              animation: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    Strings.dropoff,
                    style: textTheme.headline3!
                        .copyWith(color: MyColors.primaryColor),
                  ),
                  Row(
                    children: [
                      Container(
                        height: getHeight(Dimens.size130),
                        width: getWidth(Dimens.size80),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name :",
                              style: textTheme.subtitle1!.copyWith(
                                  color: MyColors.black.withOpacity(0.4)),
                            ),
                            // Text(
                            //   "Email :",
                            //   style: textTheme.subtitle1!
                            //       .copyWith(color: MyColors.black.withOpacity(0.4)),
                            // ),
                            Text(
                              "Phone No :",
                              style: textTheme.subtitle1!.copyWith(
                                  color: MyColors.black.withOpacity(0.4)),
                            ),
                            Text(
                              "Address :",
                              style: textTheme.subtitle1!.copyWith(
                                  color: MyColors.black.withOpacity(0.4)),
                            ),
                            Text(
                              "Distance :",
                              style: textTheme.subtitle1!.copyWith(
                                  color: MyColors.black.withOpacity(0.4)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: getHeight(Dimens.size130),
                        width: getWidth(Dimens.size300),
                        //  color: MyColors.red500,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${data.response!.recieverName}",
                              style: textTheme.headline5,
                            ),

                            Text(
                              "${data.response!.recieverPhoneNum}",
                              style: textTheme.headline5,
                            ),
                            ExpandableText(
                              "${data.response!.dropoffAddress}, ${data.response!.dropoffCity}, ${data.response!.dropoffState}, ${data.response!.dropoffZip}",
                              style: textTheme.headline5,
                              expandText: 'show more',
                              collapseText: 'show less',
                              collapseOnTextTap: true,
                              maxLines: 1,
                              linkColor: Colors.blue,
                              animation: true,
                            ),
                            // Text(
                            //   "${data.response!.dropoffAddress}, ${data.response!.dropoffCity}, ${data.response!.dropoffState}, ${data.response!.dropoffZip}",
                            //   style: textTheme.headline5,
                            //   overflow: TextOverflow.ellipsis,
                            //   softWrap: true,
                            //   maxLines: 1,
                            // ),
                            Text(
                              "${data.response!.distance} miles",
                              style: textTheme.headline5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    Strings.packageDetails,
                    style: textTheme.headline3!
                        .copyWith(color: MyColors.primaryColor),
                  ),
                  SizedBox(
                    height: getHeight(Dimens.size15),
                  ),
                  Container(
                    width: getWidth(mediaQuery.width),
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.response!.packages!.length,
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (context, index) => SizedBox(
                        height: getHeight(Dimens.size10),
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColors.addressCon),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: getWidth(Dimens.size70),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Package ${index + 1}  ",
                                          style: textTheme.headline6,
                                        ),
                                        Text(
                                          "Dimesions",
                                          style: textTheme.subtitle1!.copyWith(
                                              color: MyColors.black
                                                  .withOpacity(0.4)),
                                        ),
                                        Text(
                                          "Category",
                                          style: textTheme.subtitle1!.copyWith(
                                              color: MyColors.black
                                                  .withOpacity(0.4)),
                                        ),
                                        Text(
                                          "Weight",
                                          style: textTheme.subtitle1!.copyWith(
                                              color: MyColors.black
                                                  .withOpacity(0.4)),
                                        ),
                                        Text(
                                          "Worth ",
                                          style: textTheme.subtitle1!.copyWith(
                                              color: MyColors.black
                                                  .withOpacity(0.4)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "(\$${data.response!.packages![index].total})",
                                          style: textTheme.subtitle1,
                                        ),
                                        Text(
                                          "${data.response!.packages![index].dimensions} ${data.response!.packages![index].unit}",
                                          style: textTheme.subtitle1,
                                        ),
                                        Text(
                                          "${data.response!.packages![index].category}",
                                          style: textTheme.subtitle1,
                                        ),
                                        Text(
                                          "${data.response!.packages![index].weight} lbs",
                                          style: textTheme.subtitle1,
                                        ),
                                        Text(
                                          "\$${data.response!.packages![index].worth}",
                                          style: textTheme.subtitle1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: getHeight(Dimens.size5),
                  ),
                ],
              ),
              onLoading: Shimmer.fromColors(
                baseColor: MyColors.grey.withOpacity(0.08),
                highlightColor: MyColors.white,
                child: ShimarAffect(),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: controller.obx(
        (data) => Container(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
            children: [
              Divider(
                color: MyColors.black,
                thickness: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Load Unload:",
                          style: textTheme.bodyText1!
                              .copyWith(color: MyColors.primaryColor),
                        ),
                        Text(
                          "Discount:",
                          style: textTheme.bodyText1!
                              .copyWith(color: MyColors.primaryColor),
                        ),
                        Text(
                          Strings.totalAmount,
                          style: textTheme.headline3!
                              .copyWith(color: MyColors.primaryColor),
                        ),
                      ],
                    ),
                    GetBuilder<OrderDetailController>(
                      builder: (controller) => Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            controller.loadUnloadStatus == "true"
                                ? "\$${controller.loadUnloadPrice.toStringAsFixed(2)}"
                                : "\$0",
                            style: textTheme.bodyText1!
                                .copyWith(color: MyColors.primaryColor),
                          ),
                          Text(
                            "\$${controller.discount}",
                            style: textTheme.bodyText1!
                                .copyWith(color: MyColors.primaryColor),
                          ),
                          Text(
                            "\$${controller.totalAmount}",
                            style: textTheme.headline3!
                                .copyWith(color: MyColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onLoading: Shimmer.fromColors(
          baseColor: MyColors.grey.withOpacity(0.08),
          highlightColor: MyColors.white,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
            children: [
              Divider(
                color: MyColors.black,
                thickness: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Load Unload:",
                          style: textTheme.bodyText1!
                              .copyWith(color: MyColors.primaryColor),
                        ),
                        Text(
                          "Discount:",
                          style: textTheme.bodyText1!
                              .copyWith(color: MyColors.primaryColor),
                        ),
                        Text(
                          Strings.totalAmount,
                          style: textTheme.headline3!
                              .copyWith(color: MyColors.primaryColor),
                        ),
                      ],
                    ),
                    GetBuilder<OrderDetailController>(
                      builder: (controller) => Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$0",
                            style: textTheme.bodyText1!
                                .copyWith(color: MyColors.primaryColor),
                          ),
                          Text(
                            "\$130",
                            style: textTheme.bodyText1!
                                .copyWith(color: MyColors.primaryColor),
                          ),
                          Text(
                            "\$200",
                            style: textTheme.headline3!
                                .copyWith(color: MyColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShimarAffect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: getHeight(Dimens.size10),
        ),
        Container(
            width: getWidth(mediaQuery.width),
            height: getHeight(Dimens.size135),
            padding: EdgeInsets.all(Dimens.size20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimens.size5),
              color: MyColors.addressCon,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: MyColors.addressCon,
                      radius: 20,
                      child: ClipOval(
                        child: Image.asset(
                          MyImgs.boy,
                          height: getHeight(Dimens.size60),
                          width: getWidth(Dimens.size40),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getWidth(Dimens.size10),
                    ),
                    Text(
                      "${SingleToneValue.instance.driverName}",
                      style: textTheme.headline4,
                    ),
                  ],
                ),
                SizedBox(
                  height: getHeight(Dimens.size10),
                ),
                GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(
                      msg:
                          "You can rate driver after delivery is completed", // message
                      toastLength: Toast.LENGTH_LONG, // length
                      gravity: ToastGravity.CENTER,
                      backgroundColor: MyColors.red500,
                      textColor: MyColors.white,
                      // location// duration
                    );
                  },
                  child: Text(
                    Strings.feedback,
                    style: textTheme.headline5!.copyWith(
                        color: MyColors.secondaryColor,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            )),
        SizedBox(
          height: getHeight(Dimens.size10),
        ),
        Text(
          Strings.pickup,
          style: textTheme.headline3!.copyWith(color: MyColors.primaryColor),
        ),
        Row(
          children: [
            Container(
              height: getHeight(Dimens.size140),
              width: getWidth(Dimens.size70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name :",
                    style: textTheme.subtitle1!
                        .copyWith(color: MyColors.black.withOpacity(0.4)),
                  ),
                  // Text(
                  //   "Email :",
                  //   style: textTheme.subtitle1!
                  //       .copyWith(color: MyColors.black.withOpacity(0.4)),
                  // ),
                  Text(
                    "Phone No :",
                    style: textTheme.subtitle1!
                        .copyWith(color: MyColors.black.withOpacity(0.4)),
                  ),
                  Text(
                    "Address :",
                    style: textTheme.subtitle1!
                        .copyWith(color: MyColors.black.withOpacity(0.4)),
                  ),
                  Text(
                    "Schedule:",
                    style: textTheme.subtitle1!
                        .copyWith(color: MyColors.black.withOpacity(0.4)),
                  ),
                  Text(
                    "Notes:",
                    style: textTheme.subtitle1!
                        .copyWith(color: MyColors.black.withOpacity(0.4)),
                  ),
                ],
              ),
            ),
            Container(
              height: getHeight(Dimens.size140),
              width: getWidth(Dimens.size250),
              //   color: MyColors.red500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "",
                    style: textTheme.headline5,
                  ),
                  // Text(
                  //   "ahsanahmad43@gmail.com",
                  //   style: textTheme.headline5,
                  // ),
                  Text(
                    "",
                    style: textTheme.headline5,
                  ),
                  Text(
                    "",
                    style: textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 1,
                  ),
                  Text(
                    "",
                    style: textTheme.headline5,
                  ),
                  Text(
                    "",
                    style: textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
        Text(
          Strings.dropoff,
          style: textTheme.headline3!.copyWith(color: MyColors.primaryColor),
        ),
        Row(
          children: [
            Container(
              height: getHeight(Dimens.size90),
              width: getWidth(Dimens.size70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name :",
                    style: textTheme.subtitle1!
                        .copyWith(color: MyColors.black.withOpacity(0.4)),
                  ),
                  // Text(
                  //   "Email :",
                  //   style: textTheme.subtitle1!
                  //       .copyWith(color: MyColors.black.withOpacity(0.4)),
                  // ),
                  Text(
                    "Phone No :",
                    style: textTheme.subtitle1!
                        .copyWith(color: MyColors.black.withOpacity(0.4)),
                  ),
                  Text(
                    "Address :",
                    style: textTheme.subtitle1!
                        .copyWith(color: MyColors.black.withOpacity(0.4)),
                  ),
                ],
              ),
            ),
            Container(
              height: getHeight(Dimens.size90),
              width: getWidth(Dimens.size250),
              //  color: MyColors.red500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "",
                    style: textTheme.headline5,
                  ),
                  // Text(
                  //   "ahsanahmad43@gmail.com",
                  //   style: textTheme.headline5,
                  // ),
                  Text(
                    "",
                    style: textTheme.headline5,
                  ),
                  Text(
                    "",
                    style: textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
        Text(
          Strings.packageDetails,
          style: textTheme.headline3!.copyWith(color: MyColors.primaryColor),
        ),
        SizedBox(
          height: getHeight(Dimens.size15),
        ),
        Container(
          width: getWidth(mediaQuery.width),
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            scrollDirection: Axis.vertical,
            separatorBuilder: (context, index) => SizedBox(
              height: getHeight(Dimens.size10),
            ),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.addressCon),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Package ${index + 1}  ",
                          style: textTheme.headline6,
                        ),
                        // Text(
                        //   "  (\$150)",
                        //   style: textTheme.headline4,
                        // ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: getHeight(Dimens.size80),
                          width: getWidth(Dimens.size70),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   "Size",
                              //   style: textTheme.subtitle1!.copyWith(
                              //       color:
                              //           MyColors.black.withOpacity(0.4)),
                              // ),
                              Text(
                                "Dimesions",
                                style: textTheme.subtitle1!.copyWith(
                                    color: MyColors.black.withOpacity(0.4)),
                              ),
                              Text(
                                "Category",
                                style: textTheme.subtitle1!.copyWith(
                                    color: MyColors.black.withOpacity(0.4)),
                              ),
                              Text(
                                "Worth ",
                                style: textTheme.subtitle1!.copyWith(
                                    color: MyColors.black.withOpacity(0.4)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: getHeight(Dimens.size80),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                " cm",
                                style: textTheme.subtitle1,
                              ),
                              Text(
                                "",
                                style: textTheme.subtitle1,
                              ),
                              Text(
                                "\$",
                                style: textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: getHeight(Dimens.size5),
        ),
      ],
    );
  }
}
