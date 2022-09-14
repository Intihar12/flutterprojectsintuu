import 'package:antrakuserinc/controllers/pickup_controller/pickup_controller.dart';
import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/size_config.dart';
import 'package:antrakuserinc/ui/widgets/add_button.dart';
import 'package:antrakuserinc/ui/widgets/address_widget.dart';
import 'package:antrakuserinc/ui/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../values/my_fonts.dart';
import '../../values/values.dart';
import '../../widgets/custom_button.dart';
import '../receiver_details/receiver_details.dart';
import 'add_pickup_address.dart';

class PickupDetails extends GetView<PickupController> {
  final PickupController pickupController = Get.find();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return WillPopScope(
      onWillPop: () {
        return controller.onPopScope();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(Strings.pickupDetails),
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                controller.onPopScope();
              },
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.pickupDetails,
                  style: textTheme.headline3!.copyWith(
                      color: Colors.grey, fontFamily: MyFonts.nulshok),
                ),
                SizedBox(
                  height: getHeight(Dimens.size15),
                ),
                Text(
                  Strings.pickupAddress,
                  style: textTheme.headline4!
                      .copyWith(color: MyColors.primaryColor),
                ),
                SizedBox(
                  height: getHeight(Dimens.size10),
                ),
                controller.obx(
                    (data) => data.response.length != 0
                        ? GetBuilder<PickupController>(builder: (context) {
                            return Container(
                                height: getHeight(Dimens.size160),
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.response.length,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.5,
                                          crossAxisCount: 1,
                                          mainAxisSpacing: 10),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: MyColors.addressCon,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: SingleToneValue.instance.pAddressSate ==index
                                                ? MyColors.secondaryColor
                                                : MyColors.white,
                                          )),
                                      child: AddressWidget(
                                        title: data.response[index].title,
                                        exactAddress:
                                            data.response[index].exactAddress,
                                        phone: data.response[index].phoneNum,
                                        aptNum: data.response[index].aptNum,
                                        aptName: data.response[index].building,
                                        city: data.response[index].city,
                                        state: data.response[index].state,
                                        zipCode: data.response[index].zip,
                                        onTap: () {
                                          SingleToneValue
                                                  .instance.pickupAddressId =
                                              data.response[index].id
                                                  .toString();
                                          // SingleToneValue.instance.length=data.response.length;
                                          // SingleToneValue.instance.newLength=data.response.length;

                                          if (SingleToneValue
                                                  .instance.pickupAddressId ==
                                              SingleToneValue
                                                  .instance.dropAddressId) {
                                            Get.defaultDialog(
                                                title: "Caution",
                                                middleText:
                                                    "Pickup and receiver address cannot be same.",
                                                titleStyle: Get
                                                    .textTheme.subtitle2!
                                                    .copyWith(
                                                        color: MyColors.red500,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                onConfirm: () {
                                                  Get.back();
                                                });
                                          } else {
                                            SingleToneValue
                                                .instance.pAddressSate = index;
                                            SingleToneValue
                                                    .instance.pickupAddressId =
                                                data.response[index].id
                                                    .toString();
                                            SingleToneValue.instance.sPhone =
                                                data.response[index].phoneNum;
                                            SingleToneValue.instance.sAddress =
                                                data.response[index]
                                                    .exactAddress;
                                            controller.update();
                                          }
                                        },
                                      ),
                                    );
                                  },
                                ));
                          })
                        : Center(
                            child: Text(
                              Strings.noAddress,
                              style: textTheme.bodyText2!
                                  .copyWith(color: MyColors.grey72),
                            ),
                          ),
                    onLoading: Shimmer.fromColors(
                        baseColor: MyColors.grey.withOpacity(0.08),
                        highlightColor: MyColors.white,
                        child: Container(
                            height: getHeight(Dimens.size160),
                            child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 2,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.5,
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 10),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: getHeight(Dimens.size150),
                                  width: getWidth(Dimens.size140),
                                  color:
                                      MyColors.tertiaryColor.withOpacity(0.2),
                                );
                              },
                            )))),
                SizedBox(
                  height: getHeight(Dimens.size20),
                ),
                AddButton(
                    height: getHeight(Dimens.size40),
                    width: getWidth(Dimens.size330),
                    text: Strings.addAddress,
                    onPressed: () {
                      SingleToneValue.instance.pAddressSate = -1;
                      SingleToneValue.instance.pickupAddressId = "-1";
                      Get.off(PickupAddress());
                    }),
                SizedBox(
                  height: getHeight(Dimens.size20),
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                  height: getHeight(Dimens.size40),
                  width: getWidth(Dimens.size300),
                  text: Strings.submitContinue,
                  onPressed: () {
                    controller.onButton();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
