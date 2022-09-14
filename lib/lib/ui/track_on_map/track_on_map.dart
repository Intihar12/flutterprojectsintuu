import 'package:antrakuserinc/controllers/track_order_controller/track_order_controller.dart';
import 'package:antrakuserinc/ui/chat/order_chat_screen.dart';
import 'package:antrakuserinc/ui/values/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/driver_tracking_controller/driver_tracking_controller.dart';
import '../../data/constants/constants.dart';
import '../../data/singleton/singleton.dart';
import '../values/dimens.dart';
import '../values/my_colors.dart';
import '../values/my_imgs.dart';
import '../values/strings.dart';
import '../widgets/custom_button.dart';

class TrackonMap extends GetView<DriverTrackingController> {
  LatLng _kMapCenter = LatLng(31.427789, 74.239181);

  final TrackOrderController driverController = TrackOrderController();
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    CameraPosition _kInitialPosition = CameraPosition(
      target: _kMapCenter,
      zoom: 14,
      //  tilt: 80,
      bearing: 30,
    );
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: MyColors.black, size: 25),
      ),
      body: Stack(
        children: [
          controller.obx(
            (value) => Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: getHeight(570),
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  compassEnabled: false,
                  initialCameraPosition: CameraPosition(
                      target:
                          LatLng(controller.lat.value, controller.lng.value),
                      zoom: 14),
                  onMapCreated: controller.onMapCreated,
                  markers: controller.Markers,
                ),
              ),
            ),
            // onLoading: Container(
            //   height: getHeight(570),
            //   width: getWidth(mediaQuery.width),
            //   child: GoogleMap(
            //     zoomControlsEnabled: false,
            //     myLocationButtonEnabled: false,
            //     compassEnabled: false,
            //     initialCameraPosition: CameraPosition(
            //         target:
            //             LatLng(controller.lat.value, controller.lng.value),
            //         zoom: 14),
            //     onMapCreated: controller.onMapCreated,
            //     markers: controller.Markers,
            //   ),
            // ),
            onLoading: Container(
              height: getHeight(570),
              width: getWidth(mediaQuery.width),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: getHeight(Dimens.size330),
              width: mediaQuery.width,
              decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimens.size30),
                      topLeft: Radius.circular(Dimens.size30))),
              child: Padding(
                padding: EdgeInsets.only(
                    top: Dimens.size10,
                    left: Dimens.size20,
                    right: Dimens.size20,
                    bottom: Dimens.size20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SingleToneValue.instance.driverStatusID == 2
                            ? Text(
                                "${Strings.status01}",
                                style: textTheme.headline4!.copyWith(
                                  color: MyColors.primaryColor,
                                ),
                              )
                            : SingleToneValue.instance.driverStatusID == 3
                                ? Text(
                                    "${Strings.status02}",
                                    style: textTheme.headline4!.copyWith(
                                      color: MyColors.primaryColor,
                                    ),
                                  )
                                : SingleToneValue.instance.driverStatusID == 4
                                    ? Text(
                                        "${Strings.status03}",
                                        style: textTheme.headline4!.copyWith(
                                          color: MyColors.primaryColor,
                                        ),
                                      )
                                    : Text(
                                        "${Strings.status04}",
                                        style: textTheme.headline4!.copyWith(
                                          color: MyColors.primaryColor,
                                        ),
                                      ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleToneValue.instance.driverStatusID == 2
                            ? Text(
                                "${Strings.estTimeT}",
                              )
                            : SingleToneValue.instance.driverStatusID == 3
                                ? Text(
                                    "${Strings.estTimeT}",
                                  )
                                : Text(
                                    Strings.estTime,
                                    style: textTheme.caption,
                                  ),
                        Text(
                          "${SingleToneValue.instance.estTime}",
                          style: textTheme.bodyText1,
                        ),
                      ],
                    ),
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
                      height: getHeight(Dimens.size60),
                      width: mediaQuery.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimens.size10),
                        // color: MyColors.blue10.withOpacity(0.1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FadeInImage.assetNetwork(
                            // fit: BoxFit.cover,
                            placeholder: MyImgs.onLoading,
                            image:
                                "${Constants.imagesBaseUrl}${SingleToneValue.instance.driverImage}",
                            imageErrorBuilder: (context, e, stackTrace) =>
                                Image.asset(
                              MyImgs.errorImage,
                              //   fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: getWidth(Dimens.size10),
                          ),
                          Expanded(
                              child: Text(
                            "${SingleToneValue.instance.driverName}",
                            style: textTheme.headline4,
                            maxLines: 1,
                            softWrap: true,
                          )),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${SingleToneValue.instance.carNum}",
                                style: textTheme.caption,
                              ),
                              Text(
                                "${SingleToneValue.instance.carName}",
                                style: textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconBtn(
                        text: Strings.callBtn,
                        image: MyImgs.phone,
                        onTap: () {
                          driverController.makePhoneCall(
                              SingleToneValue.instance.driverPhone!);
                        }),
                    IconBtn(
                        text: Strings.smsBtn,
                        image: MyImgs.sms,
                        onTap: () {
                          Get.to(OrderChatPage(
                            orderID:
                                SingleToneValue.instance.orderId.toString(),
                            requestId: int.parse(
                                SingleToneValue.instance.orderId.toString()),
                            theirName:
                                SingleToneValue.instance.driverName.toString(),
                          ));
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class IconBtn extends StatelessWidget {
  final Color? borderColor;
  final Color? textColor;
  final String text;
  final String image;
  final Function() onTap;

  const IconBtn(
      {this.textColor,
      this.borderColor,
      required this.text,
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: getHeight(Dimens.size40),
        width: double.infinity,
        decoration: BoxDecoration(
            color: MyColors.primaryColor,
            border: Border.all(
                color:
                    borderColor == null ? MyColors.primaryColor : borderColor!),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //   color: MyColors.green100,
              width: getWidth(Dimens.size130),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    image,
                    height: getHeight(Dimens.size24),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: getWidth(Dimens.size30),
            ),
            Text(
              text,
              style: textColor == null
                  ? textTheme.headline4!
                      .copyWith(color: MyColors.secondaryColor)
                  : textTheme.headline3!.copyWith(color: textColor),
            )
          ],
        ),
      ),
    );
  }
}
