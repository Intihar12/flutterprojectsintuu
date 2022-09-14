import 'package:antrakuserinc/ui/send_parcel_and_payment/pickup/pickup_details.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/my_imgs.dart';
import 'package:antrakuserinc/ui/values/size_config.dart';
import 'package:antrakuserinc/ui/widgets/custom_button.dart';
import 'package:antrakuserinc/ui/widgets/custom_textfield.dart';
import 'package:antrakuserinc/ui/widgets/phone_picker.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:date_picker_timeline/extra/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../../controllers/pickup_controller/pickup_controller.dart';
import '../../../data/singleton/singleton.dart';
import '../../test_map/test_map.dart';
import '../../values/strings.dart';
import '../receiver_details/receiver_details.dart';

class PickupAddress extends StatelessWidget {
  final pickupController = Get.put(PickupController());
  GlobalKey<FormState> addAddressKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return onPop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(Strings.pickupAddress),
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                return onPop();
              },
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            pickupController.mapVisible.value = true;
          },
          child: Form(
            key: addAddressKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GetBuilder<PickupController>(builder: (a) {
                return Stack(
                  children: [
                    Obx(
                      () => SingleChildScrollView(
                        child: Padding(
                          padding: pickupController.mapVisible.value == true
                              ? EdgeInsets.only(top: getHeight(360))
                              : EdgeInsets.only(top: 80),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: getHeight(Dimens.size400),
                              width: getWidth(double.infinity),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: getHeight(Dimens.size16),
                                  ),
                                  // Obx(
                                  //   () => Container(
                                  //     padding: EdgeInsets.all(Dimens.size10),
                                  //     margin: EdgeInsets.symmetric(vertical: 5),
                                  //     height: getHeight(Dimens.size40),
                                  //     width: mediaQuery.width,
                                  //     decoration: BoxDecoration(
                                  //       //  color: MyColors.appBackground,
                                  //       borderRadius: BorderRadius.circular(5),
                                  //       border: Border.all(
                                  //           color: MyColors.black, width: 0.5),
                                  //     ),
                                  //     child: Text(
                                  //       pickupController.customLocation.value,
                                  //       overflow: TextOverflow.ellipsis,
                                  //       softWrap: true,
                                  //       maxLines: 1,
                                  //       style: textTheme.bodyText2!
                                  //           .copyWith(fontSize: getFont(12)),
                                  //       textAlign: TextAlign.start,
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: getHeight(Dimens.size10),
                                  // ),
                                  CustomTextField(
                                      onTap: () {
                                        // FocusScope.of(context)
                                        //     .requestFocus(FocusNode());
                                        pickupController.mapVisible.value =
                                            false;
                                      },
                                      controller: pickupController.title,
                                      text: Strings.addTitle,
                                      length: 20,
                                      keyboardType: TextInputType.text,
                                      inputFormatters:
                                          FilteringTextInputFormatter
                                              .singleLineFormatter),
                                  SizedBox(
                                    height: getHeight(Dimens.size16),
                                  ),
                                  Obx(
                                    () => CustomTextField(
                                        onTap: () {
                                          // FocusScope.of(context)
                                          //     .requestFocus(FocusNode());
                                          pickupController.mapVisible.value =
                                              false;
                                        },
                                        controller:
                                            pickupController.exactAddress.value,
                                        text: "Street",
                                        length: 20,
                                        keyboardType: TextInputType.text,
                                        inputFormatters:
                                            FilteringTextInputFormatter
                                                .singleLineFormatter),
                                  ),
                                  SizedBox(
                                    height: getHeight(Dimens.size16),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomTextField(
                                          onTap: () {
                                            // FocusScope.of(context)
                                            //     .requestFocus(FocusNode());
                                            pickupController.mapVisible.value =
                                                false;
                                          },
                                          controller: pickupController.building,
                                          width: getWidth(Dimens.size180),
                                          text: Strings.building,
                                          length: 20,
                                          keyboardType: TextInputType.text,
                                          inputFormatters:
                                              FilteringTextInputFormatter
                                                  .singleLineFormatter),
                                      Obx(
                                        () => CustomTextField(
                                            onTap: () {
                                              // FocusScope.of(context)
                                              //     .requestFocus(FocusNode());
                                              pickupController
                                                  .mapVisible.value = false;
                                            },
                                            controller:
                                                pickupController.city.value,
                                            width: getWidth(Dimens.size180),
                                            text: Strings.city,
                                            length: 30,
                                            keyboardType: TextInputType.text,
                                            inputFormatters:
                                                FilteringTextInputFormatter
                                                    .singleLineFormatter),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: getHeight(Dimens.size16),
                                  ),
                                  Obx(
                                    () => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomTextField(
                                            onTap: () {
                                              // FocusScope.of(context)
                                              //     .requestFocus(FocusNode());
                                              pickupController
                                                  .mapVisible.value = false;
                                            },
                                            controller: pickupController
                                                .stateName.value,
                                            width: getWidth(Dimens.size180),
                                            text: Strings.state,
                                            length: 30,
                                            keyboardType: TextInputType.text,
                                            inputFormatters:
                                                FilteringTextInputFormatter
                                                    .singleLineFormatter),
                                        CustomTextField(
                                            onTap: () {
                                              // FocusScope.of(context)
                                              //     .requestFocus(FocusNode());
                                              pickupController
                                                  .mapVisible.value = false;
                                            },
                                            controller:
                                                pickupController.zip.value,
                                            width: getWidth(Dimens.size180),
                                            text: Strings.zip,
                                            length: 20,
                                            keyboardType: TextInputType.text,
                                            inputFormatters:
                                                FilteringTextInputFormatter
                                                    .singleLineFormatter),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: getHeight(Dimens.size16),
                                  ),
                                  PhonePicker(
                                      onTap: () {
                                        // FocusScope.of(context)
                                        //     .requestFocus(FocusNode());
                                        pickupController.mapVisible.value =
                                            false;
                                      },
                                      countryCode: pickupController.code,
                                      controller: pickupController.phone),
                                  SizedBox(
                                    height: getHeight(Dimens.size10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 80),
                    //   child: SizedBox(
                    //     height: getHeight(Dimens.size250),
                    //     width: getWidth(Dimens.size350),
                    //     child: Stack(
                    //       children: [
                    //         GoogleMap(
                    //           onTap: (LatLng latLng) {
                    //             // for remove list on click on map
                    //             FocusScope.of(context)
                    //                 .requestFocus(FocusNode());
                    //             // pickupController.update();
                    //           },
                    //           scrollGesturesEnabled: false,
                    //
                    //           zoomGesturesEnabled: false,
                    //           zoomControlsEnabled: false,
                    //           mapType: MapType.normal,
                    //           initialCameraPosition: CameraPosition(
                    //             target: LatLng(SingleToneValue.instance.pickLat,
                    //                 SingleToneValue.instance.pickLng),
                    //             zoom: 16.151926040649414,
                    //           ),
                    //           // onCameraMove: (CameraPosition position) {
                    //           //   SingleToneValue.instance.pickLat =
                    //           //       position.target.latitude;
                    //           //   SingleToneValue.instance.pickLng =
                    //           //       position.target.longitude;
                    //           // },
                    //           onMapCreated: (GoogleMapController controller) {
                    //             pickupController.onMapCreated(controller);
                    //           },
                    //           // onCameraIdle: () {
                    //           //   pickupController.getCustomLocation(
                    //           //       SingleToneValue.instance.pickLat,
                    //           //       SingleToneValue.instance.pickLng);
                    //           // },
                    //         ),
                    //         Center(
                    //             child: Padding(
                    //                 padding: EdgeInsets.only(bottom: 16.0),
                    //                 child: Image.asset(
                    //                   MyImgs.mapPin,
                    //                   height: Dimens.size35,
                    //                 ))),
                    //         Align(
                    //           alignment: Alignment.bottomCenter,
                    //           child: GestureDetector(
                    //             onTap: () async {},
                    //             child: SizedBox(
                    //               height: getHeight(Dimens.size40),
                    //               width: getWidth(Dimens.size180),
                    //               child: Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: CustomButton(
                    //                     height: getHeight(Dimens.size40),
                    //                     width: getWidth(Dimens.size180),
                    //                     text: Strings.viewMap,
                    //                     fontSize: getFont(Dimens.size10),
                    //                     onPressed: () {
                    //                       Get.to(() => SimpleMap());
                    //                     }),
                    //               ),
                    //             ),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Obx(
                      () => Visibility(
                        visible: pickupController.mapVisible.value,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: SizedBox(
                            height: getHeight(Dimens.size250),
                            width: getWidth(Dimens.size374),
                            child: Stack(
                              children: [
                                GoogleMap(
                                  onTap: (LatLng latLng) {
                                    // for remove list on click on map
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    // pickupController.update();
                                  },
                                  scrollGesturesEnabled: false,
                                  zoomGesturesEnabled: false,
                                  zoomControlsEnabled: false,
                                  mapType: MapType.normal,
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                        SingleToneValue.instance.pickLat,
                                        SingleToneValue.instance.pickLng),
                                    zoom: 16.151926040649414,
                                  ),
                                  // onCameraMove: (CameraPosition position) {
                                  //   SingleToneValue.instance.pickLat =
                                  //       position.target.latitude;
                                  //   SingleToneValue.instance.pickLng =
                                  //       position.target.longitude;
                                  // },
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    pickupController.onMapCreated(controller);
                                  },
                                  // onCameraIdle: () {
                                  //   pickupController.getCustomLocation(
                                  //       SingleToneValue.instance.pickLat,
                                  //       SingleToneValue.instance.pickLng);
                                  // },
                                ),
                                Center(
                                    child: Padding(
                                        padding: EdgeInsets.only(bottom: 16.0),
                                        child: Image.asset(
                                          MyImgs.mapPin,
                                          height: Dimens.size35,
                                        ))),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: GestureDetector(
                                    onTap: () async {},
                                    child: SizedBox(
                                      height: getHeight(Dimens.size40),
                                      width: getWidth(Dimens.size180),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CustomButton(
                                            height: getHeight(Dimens.size40),
                                            width: getWidth(Dimens.size180),
                                            text: Strings.viewMap,
                                            fontSize: getFont(Dimens.size10),
                                            onPressed: () {
                                              Get.to(() => SimpleMap());
                                            }),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(Dimens.size5),
                      child: Container(
                        width: getWidth(mediaQuery.width),
                        height: getHeight(Dimens.size50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimens.size5),
                            color: MyColors.white),
                        child: TextFormField(
                          controller: pickupController.locationTextController,
                          onChanged: (value) {
                            pickupController.updateText(value);
                          },
                          style: TextStyle(
                            color: MyColors.black,
                            fontFamily: 'ubuntu',
                            fontSize: Dimens.size16,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  pickupController.locationTextController
                                      .clear();
                                  pickupController.callApi(' ');
                                },
                                child: Icon(Icons.clear_outlined)),
                            hintText: Strings.searchMap,
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: Dimens.size14,
                              color: MyColors.greyFont,
                              fontFamily: 'ubuntu',
                            ),
                            // contentPadding: EdgeInsets.all(Dimens.size10),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimens.size50),
                      child: Wrap(children: [
                        pickupController.searchPlaces != null
                            ? pickupController.getUpdatePlaces(
                                context, pickupController.searchPlaces!)
                            : const Text(''),
                      ]),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
        bottomNavigationBar: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: CustomButton(
                  height: getHeight(Dimens.size45),
                  width: getWidth(Dimens.size330),
                  text: Strings.submit,
                  onPressed: () {
                    final isValid = addAddressKey.currentState!.validate();
                    if (!isValid) {
                      return;
                    } else {
                      pickupController.onPickUpaddAddress();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  onPop() {
    Get.off(() => PickupDetails());
  }
}
