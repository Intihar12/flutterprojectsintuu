import 'package:antrakuserinc/controllers/parcel_controller/parcel_controller.dart';
import 'package:antrakuserinc/data/constants/constants.dart';
import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/my_fonts.dart';
import 'package:antrakuserinc/ui/values/my_imgs.dart';
import 'package:antrakuserinc/ui/values/size_config.dart';
import 'package:antrakuserinc/ui/values/strings.dart';
import 'package:antrakuserinc/ui/widgets/add_button.dart';
import 'package:antrakuserinc/ui/widgets/custom_button.dart';
import 'package:antrakuserinc/ui/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class SendParcel extends GetView<ParcelController> {
  var parcelController = Get.put(ParcelController());
  FocusNode textSecondFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return WillPopScope(
      onWillPop: () {
        return parcelController.onParcelPopScope();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(Strings.send_parcel1),
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                parcelController.onParcelPopScope();
              },
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GetBuilder<ParcelController>(builder: (control) {
                return Form(
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: parcelController.sendParcelFormkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.parcelDetails,
                        style: textTheme.headline3!.copyWith(
                            color: Colors.grey, fontFamily: MyFonts.nulshok),
                      ),
                      SizedBox(
                        height: getHeight(Dimens.size12),
                      ),
                      Text(
                        Strings.whatSending,
                        style: textTheme.headline3!.copyWith(
                            color: MyColors.primaryColor,
                            fontSize: getFont(18)),
                      ),
                      SizedBox(
                        height: getHeight(Dimens.size12),
                      ),
                      controller.obx(
                          (data) => Container(
                              height: getHeight(Dimens.size90),
                              child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    data!.response![0].categories!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.92,
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 10),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (data.response![0].categories![index]
                                              .adult18Plus ==
                                          true) {
                                        showModalBottomSheet(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                      Dimens.size10,
                                                    ),
                                                    topRight: Radius.circular(
                                                        Dimens.size10))),
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: Dimens.size25),
                                                height:
                                                    getHeight(Dimens.size200),
                                                width: getWidth(
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width),
                                                decoration: BoxDecoration(
                                                    // color: MyColors.red500,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                              Dimens.size10,
                                                            ),
                                                            topRight: Radius
                                                                .circular(Dimens
                                                                    .size10))),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    // SizedBox(
                                                    //   height: getHeight(
                                                    //       Dimens.size20),
                                                    // ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          MyImgs.adult,
                                                          height: getHeight(
                                                              Dimens.size30),
                                                          width: getWidth(
                                                              Dimens.size30),
                                                        ),
                                                        SizedBox(
                                                          width: getWidth(
                                                              Dimens.size10),
                                                        ),
                                                        Text(
                                                          Strings.confirmAge,
                                                          style: textTheme
                                                              .headline2,
                                                        )
                                                      ],
                                                    ),
                                                    Text(
                                                      Strings.ageLine,
                                                      style:
                                                          textTheme.headline5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        // CustomButton(
                                                        //     height: getHeight(
                                                        //         Dimens.size40),
                                                        //     width: getWidth(
                                                        //         Dimens.size100),
                                                        //     text: Strings.no,
                                                        //     onPressed: () {
                                                        //       Get.back();
                                                        //     }),
                                                        // SizedBox(
                                                        //   width: getWidth(
                                                        //       Dimens.size15),
                                                        // ),
                                                        CustomButton(
                                                            height: getHeight(
                                                                Dimens.size40),
                                                            width: getWidth(
                                                                Dimens.size100),
                                                            text:
                                                                Strings.confirm,
                                                            onPressed: () {
                                                              Get.back();
                                                            }),
                                                        SizedBox(
                                                          width: getWidth(
                                                              Dimens.size15),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      }
                                      SingleToneValue.instance.sId = index;
                                      parcelController.catId = data
                                          .response![0].categories![index].id
                                          .toString();
                                      parcelController.catName = data
                                          .response![0].categories![index].name
                                          .toString();

                                      controller.update();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                SingleToneValue.instance.sId ==
                                                        index
                                                    ? MyColors.secondaryColor
                                                    : MyColors.white,
                                            width: 1.5),
                                        borderRadius: BorderRadius.circular(10),
                                        color: MyColors.tertiaryColor,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          FadeInImage.assetNetwork(
                                            height: getHeight(Dimens.size60),
                                            width: getWidth(Dimens.size70),
                                            placeholder: MyImgs.onLoading,
                                            image:
                                                "${Constants.imagesBaseUrl}${data.response![0].categories![index].image}",
                                            imageErrorBuilder: (context, e,
                                                    stackTrace) =>
                                                Image.asset(MyImgs.errorImage,
                                                    height: getHeight(
                                                        Dimens.size30),
                                                    width: getWidth(
                                                        Dimens.size15)),
                                          ),
                                          // SizedBox(
                                          //   height: getHeight(Dimens.size10),
                                          // ),
                                          Text(
                                            "${data.response![0].categories![index].name}",
                                            style: textTheme.bodyText2!
                                                .copyWith(
                                                    fontSize: getFont(12)),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )),
                          onError: (error) => Text(error!),
                          onLoading: Shimmer.fromColors(
                            baseColor: MyColors.grey.withOpacity(0.08),
                            highlightColor: MyColors.white,
                            child: Container(
                                height: getHeight(Dimens.size70),
                                child: GridView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 4,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 392 / (834 / 2),
                                          crossAxisCount: 1,
                                          mainAxisSpacing: 10),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: MyColors.tertiaryColor
                                            .withOpacity(0.2),
                                      ),
                                    );
                                  },
                                )),
                          )),
                      SizedBox(
                        height: getHeight(Dimens.size12),
                      ),
                      Text(
                        Strings.whatWeight,
                        style: textTheme.headline3!.copyWith(
                            color: MyColors.primaryColor,
                            fontSize: getFont(18)),
                      ),
                      SizedBox(
                        height: getHeight(Dimens.size12),
                      ),
                      CustomTextField(
                        text: Strings.zero,
                        length: 10,
                        autovalidateMode:
                            controller.widthController.text.length >= 1
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                        onChanged: (value) {
                          controller.update();
                        },
                        onFieldSubmitted: (String value) {
                          FocusScope.of(context)
                              .requestFocus(textSecondFocusNode);
                        },
                        textInputAction: TextInputAction.next,
                        controller: parcelController.weightController,
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: true, signed: false),
                        inputFormatters: FilteringTextInputFormatter.allow(
                            RegExp(r"[0-9.]")),
                        suffixtext: Strings.lbs,
                      ),
                      SizedBox(
                        height: getHeight(Dimens.size12),
                      ),
                      GetBuilder<ParcelController>(builder: (context) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Strings.whatDimension,
                                      style: textTheme.headline3!.copyWith(
                                          color: MyColors.primaryColor,
                                          fontSize: getFont(18)),
                                    ),
                                    controller.unitDimens == false
                                        ? Text(
                                            "${Strings.chooseMeassurecm}",
                                            style: textTheme.bodyText2!
                                                .copyWith(
                                                    color: MyColors.grey72,
                                                    fontSize: 12),
                                          )
                                        : Text(
                                            "${Strings.chooseMeassurein}",
                                            style: textTheme.bodyText2!
                                                .copyWith(
                                                    color: MyColors.grey72,
                                                    fontSize: 12),
                                          ),
                                  ],
                                ),
                                Obx(
                                  () => Switch(
                                    activeColor: MyColors.primaryColor,
                                    onChanged: (bool value) {
                                      parcelController.unitDimens.value = value;
                                      controller.update();
                                      if (parcelController.unitDimens.value ==
                                          true) {
                                        parcelController.unitName = 'in';
                                        print("${parcelController.unitName}");
                                      } else {
                                        parcelController.unitName = 'cm';
                                        print("${parcelController.unitName}");
                                      }
                                    },
                                    value: parcelController.unitDimens.value,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: getHeight(Dimens.size12),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: getWidth(Dimens.size100),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.unitDimens == false
                                            ? "${Strings.length} (cm)"
                                            : "${Strings.length} (inches)",
                                        style: textTheme.caption!.copyWith(
                                            color: MyColors.primaryColor),
                                      ),
                                      SizedBox(
                                        height: getHeight(Dimens.size5),
                                      ),
                                      CustomTextField(
                                        text: Strings.zeroOnly,
                                        controller:
                                            parcelController.lengthController,
                                        autovalidateMode: controller
                                                    .lengthController
                                                    .text
                                                    .length >=
                                                1
                                            ? AutovalidateMode.onUserInteraction
                                            : AutovalidateMode.disabled,
                                        focusNode: textSecondFocusNode,
                                        onChanged: (value) {
                                          controller.update();
                                        },
                                        length: 10,
                                        keyboardType: TextInputType.number,
                                        inputFormatters:
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                        suffixtext:
                                            controller.unitDimens == false
                                                ? "cm"
                                                : "in",
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: getWidth(Dimens.size100),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.unitDimens == false
                                            ? "${Strings.height} (cm)"
                                            : "${Strings.height} (inches)",
                                        style: textTheme.caption!.copyWith(
                                            color: MyColors.primaryColor),
                                      ),
                                      SizedBox(
                                        height: getHeight(Dimens.size5),
                                      ),
                                      CustomTextField(
                                        text: Strings.zeroOnly,
                                        controller:
                                            parcelController.heightController,
                                        autovalidateMode: controller
                                                    .heightController
                                                    .text
                                                    .length >=
                                                1
                                            ? AutovalidateMode.onUserInteraction
                                            : AutovalidateMode.disabled,
                                        onChanged: (value) {
                                          controller.update();
                                        },
                                        length: 10,
                                        keyboardType: TextInputType.number,
                                        inputFormatters:
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                        suffixtext:
                                            controller.unitDimens == false
                                                ? "cm"
                                                : "in",
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: getWidth(Dimens.size100),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.unitDimens == false
                                            ? "${Strings.width} (cm)"
                                            : "${Strings.width} (inches)",
                                        style: textTheme.caption!.copyWith(
                                            color: MyColors.primaryColor),
                                      ),
                                      SizedBox(
                                        height: getHeight(Dimens.size5),
                                      ),
                                      CustomTextField(
                                        text: Strings.zeroOnly,
                                        controller:
                                            parcelController.widthController,
                                        autovalidateMode: controller
                                                    .widthController
                                                    .text
                                                    .length >=
                                                1
                                            ? AutovalidateMode.onUserInteraction
                                            : AutovalidateMode.disabled,
                                        onChanged: (value) {
                                          controller.update();
                                        },
                                        length: 10,
                                        keyboardType: TextInputType.number,
                                        inputFormatters:
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                        suffixtext:
                                            controller.unitDimens == false
                                                ? "cm"
                                                : "in",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),

                      SizedBox(
                        height: getHeight(Dimens.size12),
                      ),
                      Text(
                        Strings.estWorth,
                        style: textTheme.headline3!.copyWith(
                            color: MyColors.primaryColor,
                            fontSize: getFont(18)),
                      ),
                      // Text(
                      //   Strings.estWorth1,
                      //   style: textTheme.bodyText2!
                      //       .copyWith(color: MyColors.grey72, fontSize: 12),
                      // ),
                      SizedBox(
                        height: getHeight(Dimens.size12),
                      ),
                      CustomTextField(
                        text: Strings.zero,
                        controller: parcelController.worthController,
                        autovalidateMode:
                            controller.worthController.text.length >= 1
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                        onChanged: (value) {
                          if (parcelController
                                  .worthController.text.isNotEmpty &&
                              double.parse(
                                      parcelController.worthController.text) <
                                  500) {
                            parcelController.insurance.value = true;
                            parcelController.update();
                          } else {
                            parcelController.insurance.value = false;
                            parcelController.update();
                          }
                          controller.update();
                        },
                        length: 10,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: true, signed: false),
                        inputFormatters: FilteringTextInputFormatter.allow(
                            RegExp(r"[0-9.]")),
                        suffixtext: Strings.dollar,
                      ),

                      SizedBox(
                        height: getHeight(Dimens.size15),
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
                                  Strings.insurance,
                                  style: textTheme.headline3!.copyWith(
                                      color: MyColors.primaryColor,
                                      fontSize: getFont(18)),
                                ),
                                GetBuilder<ParcelController>(
                                    builder: (context) {
                                  return Text(
                                    "${SingleToneValue.instance.insuranceFee}",
                                    style: textTheme.bodyText2!.copyWith(
                                        color: MyColors.grey72, fontSize: 12),
                                  );
                                }),
                              ],
                            ),
                          ),
                          Obx(
                            () => Switch(
                              activeColor: MyColors.primaryColor,
                              onChanged: (bool value) {
                                if (parcelController
                                        .worthController.text.isNotEmpty &&
                                    double.parse(parcelController
                                            .worthController.text) >
                                        500) {
                                  parcelController.insurance.value = value;
                                  if (parcelController.insurance.value ==
                                      true) {
                                    showAlert(context);
                                  }
                                }
                              },
                              value: parcelController.insurance.value,
                            ),
                          )
                        ],
                      ),

                      SizedBox(
                        height: getHeight(Dimens.size20),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Wrap(
            children: [
              AddButton(
                  height: getHeight(Dimens.size40),
                  width: getWidth(Dimens.size330),
                  text: Strings.addPackage,
                  onPressed: () {
                    parcelController.addPackageBtn();
                  }),
              SizedBox(
                height: getHeight(Dimens.size12),
              ),
              CustomButton(
                  height: getHeight(Dimens.size40),
                  width: getWidth(Dimens.size330),
                  text: Strings.submitContinue,
                  onPressed: () {
                    parcelController.onSubmitBtn();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  showAlert(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: getHeight(Dimens.size300),
              width: getWidth(Dimens.size350),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.white),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Text(
                      Strings.insurancePopup,
                      style: textTheme.headline4,
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size25),
                    ),
                    Text(
                      '${SingleToneValue.instance.insuranceText}',
                      style: textTheme.bodyText2!
                          .copyWith(color: MyColors.grey72, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size25),
                    ),
                    Spacer(),
                    CustomButton(
                        height: getHeight(Dimens.size40),
                        width: getWidth(Dimens.size250),
                        text: Strings.confirm,
                        onPressed: () {
                          Get.back();
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
