import 'package:antrakuserinc/controllers/order_history_controller/order_history_controller.dart';
import 'package:antrakuserinc/data/singleton/singleton.dart';

import 'package:antrakuserinc/ui/order/order_details.dart';
import 'package:antrakuserinc/ui/values/strings.dart';
import 'package:antrakuserinc/ui/widgets/bottom_nav_bar.dart';
import 'package:date_picker_timeline/extra/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../values/dimens.dart';
import '../values/my_colors.dart';
import '../values/my_imgs.dart';
import '../values/size_config.dart';

class OrderHistory extends GetView<OrderHistoryController> {
  OrderHistory({Key? key}) : super(key: key);
  final orderHistoryController = Get.put(OrderHistoryController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Order History"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: Dimens.size10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "From",
                    style: textTheme.headline6,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate:
                            DateTime.now().subtract(Duration(days: 15)),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        if (value != null) {
                          var addDateString = orderHistoryController
                              .dateFormatter
                              .format(value);
                          orderHistoryController.updateDate(addDateString);
                        }
                      });
                    },
                    child: Container(
                      height: mediaQuery.height * 0.06,
                      width: mediaQuery.width * 0.3,
                      decoration: BoxDecoration(
                          color: MyColors.orderHistory,
                          borderRadius: BorderRadius.circular(Dimens.size10),
                          border:
                              Border.all(color: MyColors.white, width: 0.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: Dimens.size5,
                          ),
                          Obx(
                            () => Text(
                              "${orderHistoryController.addDate.value}",
                              style: TextStyle(
                                  fontSize: Dimens.size14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Icon(Icons.arrow_drop_down, size: Dimens.size25),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "To",
                    style: textTheme.headline6,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now().add(Duration(days: 15)),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now().add(Duration(days: 15)),
                      ).then((value) {
                        if (value != null) {
                          var addDateString = orderHistoryController
                              .dateFormatter
                              .format(value);
                          orderHistoryController.updateDate2(addDateString);
                        }
                      });
                    },
                    child: Container(
                      height: mediaQuery.height * 0.06,
                      width: mediaQuery.width * 0.3,
                      decoration: BoxDecoration(
                          color: MyColors.orderHistory,
                          borderRadius: BorderRadius.circular(Dimens.size10),
                          border:
                              Border.all(color: MyColors.white, width: 0.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: Dimens.size5,
                          ),
                          Obx(
                            () => Text(
                              "${orderHistoryController.addDate2.value}",
                              style: TextStyle(
                                  fontSize: Dimens.size14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Icon(Icons.arrow_drop_down, size: Dimens.size25),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: Dimens.size10,
          ),
          controller.obx(
            (data) => data!.response!.length == 0
                ? Container(
                    height: getHeight(Dimens.size500),
                    width: getWidth(mediaQuery.width),
                    child: Center(child: Text("No order on this date")))
                : Container(
                    height: getHeight(Dimens.size550),
                    width: getWidth(mediaQuery.width),
                    // height: mediaQuery.height * 0.75,
                    // width: mediaQuery.width,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          vertical: Dimens.size15, horizontal: Dimens.size15),
                      itemCount: data.response!.length,
                      separatorBuilder: (context, index) => SizedBox(
                        height: Dimens.size10,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            SingleToneValue.instance.orderId =
                                data.response![index].orderNumber.toString();
                            Get.to(() => OrderDetails());
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimens.size10,
                                vertical: Dimens.size10),
                            width: getWidth(mediaQuery.width),
                            // height: mediaQuery.height * 0.22,
                            // width: mediaQuery.width,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimens.size10),
                                color: MyColors.orderHistory),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Order #",
                                          style: textTheme.bodyText2!
                                              .copyWith(fontSize: getFont(14)),
                                        ),
                                        Text(
                                          "${Strings.ant}${data.response![index].orderNumber}",
                                          style: textTheme.headline5!
                                              .copyWith(fontSize: getFont(14)),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${data.response![index].orderDate}",
                                      style: textTheme.bodyText2!
                                          .copyWith(fontSize: getFont(14)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: getHeight(Dimens.size10),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: getHeight(Dimens.size50),
                                          child: Text(
                                            "Pickup",
                                            style: textTheme.bodyText2!
                                                .copyWith(
                                                    fontSize: getFont(14)),
                                          ),
                                        ),
                                        Container(
                                          height: getHeight(Dimens.size50),
                                          child: Text(
                                            "Drop-Off",
                                            style: textTheme.bodyText2!
                                                .copyWith(
                                                    fontSize: getFont(14)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: Dimens.size10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: getHeight(Dimens.size50),
                                          width: getWidth(Dimens.size240),
                                          //    color: MyColors.red500,
                                          child: Text(
                                            "${data.response![index].pickupAddress}, ${data.response![index].pickupCity}, "
                                            "${data.response![index].pickupState}, ${data.response![index].pickupZip}",
                                            style: textTheme.headline5!
                                                .copyWith(
                                                    fontSize: getFont(14)),
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            maxLines: 2,
                                          ),
                                        ),
                                        Container(
                                          height: getHeight(Dimens.size50),
                                          width: getWidth(Dimens.size240),
                                          //    color: MyColors.red500,
                                          child: Text(
                                            "${data.response![index].dropoffAddress}, ${data.response![index].dropoffCity}, "
                                            "${data.response![index].dropoffState}, ${data.response![index].dropoffZip}",
                                            style: textTheme.headline5!
                                                .copyWith(
                                                    fontSize: getFont(14)),
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "\$${data.response![index].amount}",
                                      style: textTheme.headline3!.copyWith(
                                          color: MyColors.primaryColor,
                                          fontSize: getFont(16),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            onLoading: Shimmer.fromColors(
                baseColor: MyColors.grey.withOpacity(0.08),
                highlightColor: MyColors.white,
                child: Container(
                  height: getHeight(Dimens.size550),
                  width: getWidth(mediaQuery.width),
                  // height: mediaQuery.height * 0.75,
                  // width: mediaQuery.width,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                        vertical: Dimens.size15, horizontal: Dimens.size15),
                    itemCount: 6,
                    separatorBuilder: (context, index) => SizedBox(
                      height: Dimens.size10,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        height: getHeight(Dimens.size190),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.tertiaryColor.withOpacity(0.2)),
                      );
                    },
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
