import 'package:antrakuserinc/controllers/home_controller/home_controller.dart';
import 'package:antrakuserinc/data/constants/constants.dart';
import 'package:antrakuserinc/ui/order_track/order_track.dart';
import 'package:antrakuserinc/controllers/map_controller/map_controller.dart';
import 'package:antrakuserinc/ui/values/size_config.dart';
import 'package:antrakuserinc/ui/widgets/bottom_nav_bar.dart';
import 'package:antrakuserinc/ui/widgets/custom_button.dart';
import 'package:antrakuserinc/ui/widgets/order_with_status.dart';
import 'package:antrakuserinc/ui/widgets/order_without_status.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../controllers/restricted_controller/restricted_controller.dart';
import '../../data/singleton/singleton.dart';
import '../send_parcel_and_payment/send_parcel/send_parcel.dart';
import '../values/values.dart';

class HomePage extends GetView<HomeController> {
//  HomeController homeController = Get.put(HomeController());
  LocationController locationController = Get.find();
  ScrollController scrollController = ScrollController();
  RestrictedController restrictedController = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // controller.time24.value =    '${controller.selectedTime.hour}:${controller.selectedTime.minute}';

    controller.time12.value = controller.selectedTime.format(context);
    SingleToneValue.instance.time = controller.time12.value.toString();
    controller.date = DateFormat('MM/dd/yyyy').format(controller.selectedDate);
    SingleToneValue.instance.date = controller.date;
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getHeight(Dimens.size50),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: MyColors.primaryColor,
                  ),
                  Obx(
                    () => Text(
                      locationController.address.value,
                      style:
                          textTheme.bodyText2!.copyWith(color: MyColors.grey),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 1,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: getHeight(Dimens.size5),
              ),
              Text(
                'Hi ${GetStorage().read("name").toString().capitalizeFirst},',
                style: textTheme.headline1!.copyWith(
                  color: MyColors.primaryColor,
                  fontSize: getFont(24),
                ),
              ),
              controller.obx(
                (data) => SizedBox(
                  width: getWidth(Dimens.size230),
                  child: Text(
                    data!.response![0].displayText!,
                    style: textTheme.bodyText2!.copyWith(
                      color: MyColors.primaryColor,
                      fontSize: getFont(14),
                    ),
                  ),
                ),
                onLoading: SizedBox(
                  height: getHeight(Dimens.size50),
                  width: getWidth(Dimens.size230),
                ),
                onError: (error) => Text(error!),
              ),
              SizedBox(
                height: getHeight(Dimens.size20),
              ),
              controller.obx(
                (data) => Container(
                    height: getHeight(Dimens.size165),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MyColors.tertiaryColor),
                    child: Stack(
                      children: [
                        Container(
                            height: getHeight(Dimens.size165),
                            width: double.infinity,
                            child: CarouselSlider(
                                options: CarouselOptions(
                                    viewportFraction: 1.0,
                                    aspectRatio: 1,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                    autoPlay: true,
                                    onPageChanged: (index, reason) {
                                      controller.current = index;
                                      controller.update();
                                    }),
                                items: data!.response![0].displayImage!
                                    .map(
                                      (item) => Container(
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: FadeInImage.assetNetwork(
                                            fit: BoxFit.fitWidth,
                                            placeholder: MyImgs.onLoading,
                                            image:
                                                "${Constants.imagesBaseUrl}${data.response![0].displayImage![controller.current]}",
                                            imageErrorBuilder:
                                                (context, e, stackTrace) =>
                                                    Image.asset(
                                              MyImgs.errorImage,
                                              //   fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList())),
                        Positioned.fill(
                          bottom: 10,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  data.response![0].displayImage!.map((url) {
                                int index = data.response![0].displayImage!
                                    .indexOf(url);
                                return Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: controller.current == index
                                        ? Colors.white60
                                        : Color.fromRGBO(0, 0, 0, 0.4),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    )),
                onLoading: Shimmer.fromColors(
                    baseColor: MyColors.grey.withOpacity(0.2),
                    highlightColor: MyColors.white,
                    child: Container(
                      height: getHeight(Dimens.size165),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColors.tertiaryColor.withOpacity(0.3)),
                    )),
                onError: (error) => Container(
                    height: getHeight(Dimens.size165),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MyColors.tertiaryColor.withOpacity(0.3)),
                    child: Center(
                        child: Text(
                      error!,
                      style:
                          textTheme.subtitle1!.copyWith(color: MyColors.red500),
                    ))),
              ),
              SizedBox(
                height: getHeight(Dimens.size20),
              ),
              Text(
                'What would you like to send?',
                style: textTheme.headline3!.copyWith(
                  color: MyColors.primaryColor,
                  fontSize: getFont(18),
                ),
              ),
              SizedBox(
                height: getHeight(Dimens.size20),
              ),
              GestureDetector(
                onTap: () {
                  controller.clearData();
                  restrictedController.getRItems();

                  controller.selectedTime = TimeOfDay.now();
                  controller.selectedDate = DateTime.now();
                  controller.time24.value =
                      '${controller.selectedTime.hour}:${controller.selectedTime.minute}';
                  SingleToneValue.instance.time =
                      '${controller.selectedTime.hour}:${controller.selectedTime.minute}';
                  controller.time12.value =
                      controller.selectedTime.format(context);
                  _showBottomSheet(context);
                },
                child: Container(
                  padding: EdgeInsets.all(Dimens.size15),
                  decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Image.asset(
                        MyImgs.package,
                        width: getWidth(Dimens.size40),
                        height: getHeight(Dimens.size40),
                      ),
                      SizedBox(
                        width: getWidth(Dimens.size20),
                      ),
                      Text(
                        "Send my package",
                        style: textTheme.headline3!
                            .copyWith(color: MyColors.white),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(Dimens.size10),
              ),
              controller.obx(
                (data) => data!.response![0].activeBookings!.length != 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.currentOrders,
                            style: textTheme.headline3!.copyWith(
                              color: MyColors.primaryColor,
                              fontSize: getFont(18),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(Dimens.size10),
                          ),
                          Container(
                            height: getHeight(Dimens.size200),
                            width: getWidth(Dimens.size414),
                            child: RefreshIndicator(
                              onRefresh: () {
                                controller.update();
                                return controller.getHomeData();
                              },
                              child: Scrollbar(
                                controller: scrollController,
                                child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  controller: scrollController,
                                  physics: BouncingScrollPhysics(),
                                  itemCount:
                                      data.response![0].activeBookings!.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: getHeight(Dimens.size10),
                                  ),
                                  itemBuilder: (context, index) {
                                    return
                                        // return data
                                        //             .response![0]
                                        //             .activeBookings![index]
                                        //             .bookingStatusId! <
                                        //         4
                                        //     ? OrderWithoutStatus(
                                        //         orderId: data.response![0]
                                        //             .activeBookings![index].orderNum
                                        //             .toString(),
                                        //         status: data
                                        //             .response![0]
                                        //             .activeBookings![index]
                                        //             .bookingStatus
                                        //             .toString(),
                                        //         statusId: data
                                        //             .response![0]
                                        //             .activeBookings![index]
                                        //             .bookingStatusId!,
                                        //         pickDate:  data
                                        //             .response![0]
                                        //             .activeBookings![index].pickupTime.toString(),
                                        //         securityNo: data
                                        //             .response![0]
                                        //             .activeBookings![index]
                                        //             .securityKey
                                        //             .toString(),
                                        //       )
                                        //     :
                                        GestureDetector(
                                            onTap: () {
                                              SingleToneValue.instance.orderId =
                                                  data
                                                      .response![0]
                                                      .activeBookings![index]
                                                      .orderNum
                                                      .toString();
                                              SingleToneValue
                                                      .instance.securityNo =
                                                  data
                                                      .response![0]
                                                      .activeBookings![index]
                                                      .securityKey
                                                      .toString();
                                              if (data
                                                      .response![0]
                                                      .activeBookings![index]
                                                      .bookingStatusId! >
                                                  1) {
                                                Get.to(OrderTrack(
                                                  status: data
                                                      .response![0]
                                                      .activeBookings![index]
                                                      .bookingStatus
                                                      .toString(),
                                                  pickAddress: data
                                                      .response![0]
                                                      .activeBookings![index]
                                                      .pickupAddress
                                                      .toString(),
                                                  dropAddress: data
                                                      .response![0]
                                                      .activeBookings![index]
                                                      .dropoffAddress
                                                      .toString(),
                                                ));
                                              } else {
                                                Fluttertoast.showToast(
                                                  msg:
                                                      'Your order is not accepted yet!', // message
                                                  toastLength: Toast
                                                      .LENGTH_LONG, // length
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor:
                                                      MyColors.red500,
                                                  textColor: MyColors.white,
                                                  // location// duration
                                                );
                                              }
                                            },
                                            child: OrderWithStatus(
                                              orderID: data
                                                  .response![0]
                                                  .activeBookings![index]
                                                  .orderNum
                                                  .toString(),
                                              status: data
                                                  .response![0]
                                                  .activeBookings![index]
                                                  .bookingStatus!,
                                              statusId: data
                                                  .response![0]
                                                  .activeBookings![index]
                                                  .bookingStatusId!,
                                              securityNo: data
                                                  .response![0]
                                                  .activeBookings![index]
                                                  .securityKey
                                                  .toString(),
                                            ));
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Text(""),
                onLoading: Shimmer.fromColors(
                    baseColor: MyColors.grey.withOpacity(0.2),
                    highlightColor: MyColors.white,
                    child: Container(
                      height: getHeight(Dimens.size200),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColors.tertiaryColor.withOpacity(0.3)),
                    )),
                onError: (error) => Container(
                    height: getHeight(Dimens.size200),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MyColors.tertiaryColor.withOpacity(0.3)),
                    child: Center(
                        child: Text(
                      error!,
                      style:
                          textTheme.subtitle1!.copyWith(color: MyColors.red500),
                    ))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: getHeight(Dimens.size360),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.pickDate,
                    style: textTheme.headline3!.copyWith(
                        color: MyColors.primaryColor, fontSize: getFont(16)),
                  ),
                  SizedBox(
                    height: getHeight(Dimens.size15),
                  ),
                  DatePicker(DateTime.now(),
                      controller: controller.date_controller,
                      initialSelectedDate: DateTime.now(),
                      daysCount: 7,
                      selectionColor: MyColors.primaryColor,
                      selectedTextColor: MyColors.white,
                      dateTextStyle:
                          textTheme.bodyText2!.copyWith(fontSize: getFont(12)),
                      onDateChange: (picked) {
                    controller.selectedDate = picked;

                    controller.date = DateFormat('MM/dd/yyyy')
                        .format(controller.selectedDate);
                    SingleToneValue.instance.date = controller.date;
                    print(controller.date);
                  }),
                  SizedBox(
                    height: getHeight(Dimens.size10),
                  ),
                  Text(
                    Strings.pickTime,
                    style: textTheme.headline3!.copyWith(
                        color: MyColors.primaryColor, fontSize: getFont(16)),
                  ),
                  SizedBox(
                    height: getHeight(Dimens.size10),
                  ),
                  Obx(() => GestureDetector(
                        onTap: () {
                          _selectTime(context);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: MyColors.black),
                            color: MyColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: getHeight(Dimens.size50),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.time12.value,
                                  style: textTheme.headline4,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: MyColors.black.withOpacity(0.6),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: getHeight(Dimens.size10),
                  ),
                  Center(
                    child: CustomButton(
                        height: getHeight(Dimens.size40),
                        width: getHeight(Dimens.size350),
                        text: 'Confirm',
                        onPressed: () {
                          print("time : ${SingleToneValue.instance.time}");
                          Get.off(SendParcel());
                        }),
                  )
                ],
              ),
            ),
          );
        });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: controller.selectedTime,
        builder: (context, childWidget) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: childWidget!);
        });
    if (controller.selectedDate.day == DateTime.now().day) {
      if (timeOfDay != null &&
          timeOfDay != controller.selectedTime &&
          controller.selectedTime.hour <= timeOfDay.hour &&
          controller.selectedTime.minute <= timeOfDay.minute) {
        controller.selectedTime = timeOfDay;
        //controller.time24.value =   '${controller.selectedTime.hour}:${controller.selectedTime.minute}';
        //SingleToneValue.instance.time =   '${controller.selectedTime.hour}:${controller.selectedTime.minute}';
        controller.time12.value = controller.selectedTime.format(context);
        SingleToneValue.instance.time =
            '${controller.selectedTime.format(context)}';
      } else {
        Fluttertoast.showToast(
          msg: "You can't select previous time", // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.CENTER,
          backgroundColor: MyColors.red500,
          textColor: MyColors.white,
          // location// duration
        );
      }
    } else {
      if (timeOfDay != null && timeOfDay != controller.selectedTime) {
        controller.selectedTime = timeOfDay;
        // controller.time24.value =   '${controller.selectedTime.hour}:${controller.selectedTime.minute}';
        SingleToneValue.instance.time =
            '${controller.selectedTime.hour}:${controller.selectedTime.minute}';
        controller.time12.value = controller.selectedTime.format(context);
      }
    }
  }
}
