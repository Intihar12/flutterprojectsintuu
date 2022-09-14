import 'package:antrakuserinc/controllers/select_vehicle_controller/select_vehicle_controller.dart';
import 'package:antrakuserinc/data/constants/constants.dart';
import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:antrakuserinc/ui/send_parcel_and_payment/order_summary/order_summary.dart';
import 'package:antrakuserinc/ui/send_parcel_and_payment/receiver_details/receiver_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controllers/parcel_controller/parcel_controller.dart';
import '../../values/my_fonts.dart';
import '../../values/size_config.dart';
import '../../values/strings.dart';
import '../../values/values.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class OtherDetails extends GetView<SelectVehicleController> {
  ParcelController parcelController = Get.put(ParcelController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(Strings.otherDetails),
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                controller.onPopScope();
              },
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getHeight(Dimens.size30),
                  ),
                  Text(
                    Strings.selectVehicle,
                    style: textTheme.headline4!
                        .copyWith(color: MyColors.primaryColor),
                  ),
                  Text(
                    Strings.selectVehicleText,
                    style: textTheme.caption!
                        .copyWith(
                        fontSize: getFont(12)
                    ),
                  ),
                  SizedBox(
                    height: getHeight(Dimens.size10),
                  ),
                  controller.obx(
                      (data) => data!.response!.length==0 ?Container(
                          height: getHeight(Dimens.size140),
                          child: Center(child: Text(
                            Strings.vehicleNotAvailable,
                            style: textTheme.caption!
                                .copyWith(
                                fontSize: getFont(12),
                              color: MyColors.red500
                            ),
                          ),) ):
                          Container(
                          height: getHeight(Dimens.size140),
                          child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: data.response!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 392 / (834 / 1.3),
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 10),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  SingleToneValue.instance.vehicleState = index;
                                  SingleToneValue.instance.vehicleId =
                                      data.response![index].id.toString();
                                  controller.update();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: SingleToneValue
                                                    .instance.vehicleState ==
                                                index
                                            ? MyColors.secondaryColor
                                            : MyColors.white,
                                        width: 1.5),
                                    borderRadius: BorderRadius.circular(5),
                                    color: MyColors.addressCon,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FadeInImage.assetNetwork(
                                        height: getHeight(Dimens.size80),
                                        width: getWidth(Dimens.size80),
                                        placeholder: MyImgs.onLoading,
                                        image:
                                            "${Constants.imagesBaseUrl}${data.response![index].image}",
                                        imageErrorBuilder:
                                            (context, e, stackTrace) =>
                                                Image.asset(
                                          MyImgs.errorImage,
                                          height: getHeight(Dimens.size80),
                                          width: getWidth(Dimens.size80),
                                        ),
                                      ),
                                      SizedBox(
                                        height: getHeight(Dimens.size10),
                                      ),
                                      Text(
                                        "${data.response![index].name}",
                                        style: textTheme.bodyText1!.copyWith(
                                            fontSize: getFont(14),
                                            color: MyColors.primaryColor),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )),
                      onLoading: Shimmer.fromColors(
                          baseColor: MyColors.grey.withOpacity(0.08),
                          highlightColor: MyColors.white,
                          child: Container(
                              height: getHeight(Dimens.size140),
                              child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: 2,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.6,
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 10),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: getHeight(Dimens.size140),
                                    width: getWidth(Dimens.size140),
                                    color:
                                        MyColors.tertiaryColor.withOpacity(0.2),
                                  );
                                },
                              )))),
                  SizedBox(
                    height: getHeight(Dimens.size30),
                  ),
                  Text(
                    Strings.addNotes,
                    style: textTheme.headline4!
                        .copyWith(color: MyColors.primaryColor),
                  ),
                  SizedBox(
                    height: getHeight(Dimens.size10),
                  ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 15),
                margin: EdgeInsets.symmetric(vertical: 5),
                height: getHeight(Dimens.size120) ,
                width: mediaQuery.width ,
                decoration: BoxDecoration(
                  //  color: MyColors.appBackground,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: MyColors.greyFont, width: 0.2)),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 500,
                  autofocus: false,
                  cursorHeight: 25,
                  maxLines: 6,
                  controller: controller.noteController,
                  style: textTheme.bodyText2!.copyWith(),
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: Strings.addComment,
                    hintStyle: TextStyle(
                      color: MyColors.greyFont ,
                      fontFamily: MyFonts.ubuntu,
                      fontWeight: FontWeight.normal,
                      fontSize: Dimens.size14,
                    ),
                    contentPadding: const EdgeInsets.only(left: 8, ),

                    focusColor: MyColors.green50,
                  ),
                ),
              ),

                  SizedBox(
                    height: getHeight(Dimens.size30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: getWidth(Dimens.size230),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.loadOffload,
                              style: textTheme.headline3!
                                  .copyWith(color: MyColors.primaryColor),
                            ),
                            Text(
                              "${SingleToneValue.instance.loadText}",
                              style: textTheme.bodyText2!.copyWith(
                                  color: MyColors.grey72, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Switch(
                            activeColor: MyColors.primaryColor,
                            onChanged: (bool value) {
                              controller.loadOffload.value = value;
                              SingleToneValue.instance.loadUnload = value;
                            },
                            value: controller.loadOffload.value,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
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
                  text: Strings.reviewParcel,
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
