import 'package:antrakuserinc/controllers/parcel_controller/parcel_controller.dart';
import 'package:antrakuserinc/controllers/restricted_controller/restricted_controller.dart';
import 'package:antrakuserinc/data/constants/constants.dart';
import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:antrakuserinc/ui/send_parcel_and_payment/other_details/other_details.dart';
import 'package:antrakuserinc/ui/send_parcel_and_payment/restricted_items/restricted_items.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/strings.dart';
import 'package:antrakuserinc/ui/widgets/custom_button.dart';
import 'package:antrakuserinc/ui/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../payment/saved_card_screen.dart';
import '../../values/size_config.dart';
import '../../widgets/expandable_text_library.dart';

class OrderSummary extends StatelessWidget {
  ParcelController parcelController = Get.put(ParcelController());

  RestrictedController restrictedController = Get.find();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return WillPopScope(
      onWillPop: () {
        return onPopScope();
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text("Order Details"),
            leading: GestureDetector(
                onTap: () {
                  onPopScope();
                },
                child: Icon(Icons.arrow_back_ios)),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: double.infinity,
                color: MyColors.white,
                child: Row(
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
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: getHeight(Dimens.size520),
                  child: Scrollbar(
                    controller: scrollController,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Dimens.size15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: getHeight(Dimens.size15),
                            ),
                            Text(
                              Strings.review,
                              style: textTheme.headline1!
                                  .copyWith(color: MyColors.black),
                            ),
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
                                  width: getWidth(Dimens.size70),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Address :",
                                        style: textTheme.subtitle1!.copyWith(
                                            color: MyColors.black
                                                .withOpacity(0.4)),
                                      ),
                                      Text(
                                        "Schedule:",
                                        style: textTheme.subtitle1!.copyWith(
                                            color: MyColors.black
                                                .withOpacity(0.4)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: getWidth(Dimens.size250),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${SingleToneValue.instance.sAddress}",
                                        style: textTheme.subtitle1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        "${SingleToneValue.instance.date} : ${SingleToneValue.instance.time}",
                                        style: textTheme.subtitle1,
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
                                    style: textTheme.subtitle1!.copyWith(
                                        color: MyColors.black.withOpacity(0.4)),
                                  ),
                                ),
                                SizedBox(
                                  width: getWidth(Dimens.size250),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ExpandableText(
                                        "${SingleToneValue.instance.note}",
                                        expandText: 'show more',
                                        collapseText: 'show less',
                                        collapseOnTextTap: true,
                                        maxLines: 1,
                                        linkColor: Colors.blue,
                                        style: textTheme.subtitle1,
                                        animation: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getHeight(Dimens.size10),
                            ),
                            Text(
                              Strings.dropoff,
                              style: textTheme.headline3!
                                  .copyWith(color: MyColors.primaryColor),
                            ),
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
                                        "Name :",
                                        style: textTheme.subtitle1!.copyWith(
                                            color: MyColors.black
                                                .withOpacity(0.4)),
                                      ),
                                      Text(
                                        "Phone No :",
                                        style: textTheme.subtitle1!.copyWith(
                                            color: MyColors.black
                                                .withOpacity(0.4)),
                                      ),
                                      Text(
                                        "Address :",
                                        style: textTheme.subtitle1!.copyWith(
                                            color: MyColors.black
                                                .withOpacity(0.4)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: getWidth(Dimens.size250),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${SingleToneValue.instance.rName}",
                                        style: textTheme.subtitle1,
                                      ),
                                      Text(
                                        "${SingleToneValue.instance.rPhone1}",
                                        style: textTheme.subtitle1,
                                      ),
                                      Text(
                                        "${SingleToneValue.instance.rAddress}",
                                        style: textTheme.subtitle1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getHeight(Dimens.size10),
                            ),
                            Text(
                              Strings.packageDetails,
                              style: textTheme.headline3!
                                  .copyWith(color: MyColors.primaryColor),
                            ),
                            SizedBox(
                              height: getHeight(Dimens.size15),
                            ),
                            GetBuilder<ParcelController>(
                              builder: (controller) => Container(
                                width: getWidth(mediaQuery.width),
                                child: ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: SingleToneValue
                                      .instance.addPackage.length,
                                  scrollDirection: Axis.vertical,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: getHeight(Dimens.size10),
                                  ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: MyColors.addressCon),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: getWidth(Dimens.size70),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Package ${index + 1}",
                                                      style:
                                                          textTheme.headline6,
                                                    ),
                                                    Text(
                                                      "Weight",
                                                      style: textTheme
                                                          .subtitle1!
                                                          .copyWith(
                                                              fontSize:
                                                                  getFont(12),
                                                              color: MyColors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.4)),
                                                    ),
                                                    Text(
                                                      "Dimensions",
                                                      style: textTheme
                                                          .subtitle1!
                                                          .copyWith(
                                                              fontSize:
                                                                  getFont(12),
                                                              color: MyColors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.4)),
                                                    ),
                                                    Text(
                                                      "Category",
                                                      style: textTheme
                                                          .subtitle1!
                                                          .copyWith(
                                                              fontSize:
                                                                  getFont(12),
                                                              color: MyColors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.4)),
                                                    ),
                                                    Text(
                                                      "Insurance",
                                                      style: textTheme
                                                          .subtitle1!
                                                          .copyWith(
                                                              fontSize:
                                                                  getFont(12),
                                                              color: MyColors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.4)),
                                                    ),
                                                    Text(
                                                      "Worth ",
                                                      style: textTheme
                                                          .subtitle1!
                                                          .copyWith(
                                                              fontSize:
                                                                  getFont(12),
                                                              color: MyColors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.4)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: getWidth(Dimens.size20),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "(\$ ${SingleToneValue.instance.packagePrice[index]})  ",
                                                    style: textTheme.headline6,
                                                  ),
                                                  Text(
                                                    "${SingleToneValue.instance.addPackage[index]['weight']} lbs",
                                                    style: textTheme.subtitle1!
                                                        .copyWith(
                                                            fontSize:
                                                                getFont(12)),
                                                  ),
                                                  Text(
                                                    "${SingleToneValue.instance.addPackage[index]['height'] + SingleToneValue.instance.addPackage[index]['unit']} x "
                                                    "${SingleToneValue.instance.addPackage[index]['length'] + SingleToneValue.instance.addPackage[index]['unit']} x "
                                                    "${SingleToneValue.instance.addPackage[index]['width'] + SingleToneValue.instance.addPackage[index]['unit']} ",
                                                    style: textTheme.subtitle1!
                                                        .copyWith(
                                                            fontSize:
                                                                getFont(12)),
                                                  ),
                                                  Text(
                                                    "${SingleToneValue.instance.addPackage[index]['categoryName']}",
                                                    style: textTheme.subtitle1!
                                                        .copyWith(
                                                            fontSize:
                                                                getFont(12)),
                                                  ),
                                                  Text(
                                                    SingleToneValue.instance
                                                                        .addPackage[
                                                                    index]
                                                                ['insurance'] ==
                                                            false
                                                        ? "No"
                                                        : "Yes",
                                                    style: textTheme.subtitle1!
                                                        .copyWith(
                                                            fontSize:
                                                                getFont(12)),
                                                  ),
                                                  Text(
                                                    "\$${SingleToneValue.instance.addPackage[index]['estWorth']}",
                                                    style: textTheme.subtitle1!
                                                        .copyWith(
                                                            fontSize:
                                                                getFont(12)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              parcelController.deletePkgBtn(
                                                  index,
                                                  SingleToneValue
                                                      .instance.orderId
                                                      .toString(),
                                                  SingleToneValue.instance
                                                      .packageIds[index]
                                                      .toString(),
                                                  SingleToneValue.instance
                                                      .loadUnloadAmount);
                                            },
                                            child: Icon(
                                              Icons.delete_forever,
                                              color: MyColors.red500,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getHeight(Dimens.size5),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: getWidth(Dimens.size200),
                                  child: Form(
                                    key: parcelController.coupenFormkey,
                                    child: CustomTextField(
                                        text: Strings.promo,
                                        length: 20,
                                        controller:
                                            parcelController.couponController,
                                        keyboardType: TextInputType.text,
                                        inputFormatters:
                                            FilteringTextInputFormatter
                                                .singleLineFormatter),
                                  ),
                                ),
                                Spacer(),
                                CustomButton(
                                    color: MyColors.tertiaryColor,
                                    textColor: MyColors.black,
                                    borderColor: MyColors.tertiaryColor,
                                    height: getHeight(Dimens.size40),
                                    width: getWidth(Dimens.size100),
                                    text: Strings.apply,
                                    onPressed: () {
                                      parcelController.couponBtn();
                                    })
                              ],
                            ),
                            SizedBox(
                              height: getHeight(Dimens.size30),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar:
              GetBuilder<ParcelController>(builder: (parcelController) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Wrap(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Discount:",
                            style: textTheme.bodyText1!
                                .copyWith(color: MyColors.primaryColor),
                          ),
                          Text(
                            "Distance:",
                            style: textTheme.bodyText1!
                                .copyWith(color: MyColors.primaryColor),
                          ),
                          Text(
                            "Offloading:",
                            style: textTheme.bodyText1!
                                .copyWith(color: MyColors.primaryColor),
                          ),
                          Text(
                            "Offloading Charges:",
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${SingleToneValue.instance.discount}",
                            style: textTheme.subtitle2!
                                .copyWith(color: MyColors.primaryColor),
                          ),
                          Text(
                            "${SingleToneValue.instance.distance} miles",
                            style: textTheme.subtitle2!
                                .copyWith(color: MyColors.primaryColor),
                          ),
                          Text(
                            SingleToneValue.instance.loadUnload == false
                                ? "No"
                                : "Yes",
                            style: textTheme.subtitle2!
                                .copyWith(color: MyColors.primaryColor),
                          ),
                          Text(
                            SingleToneValue.instance.loadUnloadAmount,
                            style: textTheme.subtitle2!
                                .copyWith(color: MyColors.primaryColor),
                          ),
                          Text(
                            "\$${SingleToneValue.instance.amount}",
                            style: textTheme.headline3!
                                .copyWith(color: MyColors.primaryColor),
                          ),
                        ],
                      )
                    ],
                  ),
                  CustomButton(
                      height: getHeight(Dimens.size40),
                      width: getWidth(Dimens.size250),
                      text: Strings.payment,
                      onPressed: () {
                        print("${SingleToneValue.instance.addPackage}");
                        print(
                            "${SingleToneValue.instance.packageIds.toString()}");
                        _showbottomSheet(context);
                      }),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  onPopScope() {
    parcelController.couponController.clear();
    SingleToneValue.instance.updateApiId = 1;
    Get.off(OtherDetails());
  }

  _showbottomSheet(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(30),
            height: getHeight(Dimens.size350),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Prohibited Items',
                  style: textTheme.headline3!.copyWith(color: MyColors.black),
                ),
                SizedBox(
                  height: getHeight(Dimens.size15),
                ),
                Text(
                  '${SingleToneValue.instance.rItems.toString().replaceAll("[", "").replaceAll("]", "")}',
                  style: textTheme.bodyText2!.copyWith(color: MyColors.black),
                ),
                Spacer(),
                CustomButton(
                    textColor: MyColors.black.withOpacity(0.6),
                    color: MyColors.addressCon,
                    height: getHeight(Dimens.size40),
                    width: getWidth(Dimens.size200),
                    text: Strings.seeAll,
                    borderColor: MyColors.addressCon,
                    onPressed: () {
                      Get.to(RestrictedItems());
                    }),
                SizedBox(
                  height: getHeight(Dimens.size10),
                ),
                CustomButton(
                    height: getHeight(Dimens.size40),
                    width: getWidth(Dimens.size200),
                    text: Strings.agree,
                    onPressed: () {
                      //  Get.to(SavedCards());
                      Get.offAll(SavedCards(pgID: 2));
                    })
              ],
            ),
          );
        });
  }
}
