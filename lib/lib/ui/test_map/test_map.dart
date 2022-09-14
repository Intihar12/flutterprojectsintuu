import 'package:antrakuserinc/controllers/pickup_controller/pickup_controller.dart';
import 'package:antrakuserinc/ui/send_parcel_and_payment/pickup/add_pickup_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/map_controller/map_controller.dart';
import '../../data/singleton/singleton.dart';
import '../values/dimens.dart';
import '../values/my_colors.dart';
import '../values/my_imgs.dart';
import '../values/size_config.dart';
import '../values/strings.dart';
import '../widgets/custom_button.dart';

class SimpleMap extends StatefulWidget {
  const SimpleMap({Key? key}) : super(key: key);

  @override
  _SimpleMapState createState() => _SimpleMapState();
}

class _SimpleMapState extends State<SimpleMap> {
  final PickupController pick = Get.find();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return WillPopScope(
      onWillPop: () {
        return onBack();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                return onBack();
              },
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: GetBuilder(builder: (PickupController pickupController) {
          return Stack(
            children: [
              Container(
                height: getHeight(mediaQuery.height),
                width: getWidth(mediaQuery.width),
                child: GoogleMap(
                  onTap: (LatLng latLng) {
                    // for remove list on click on map
                    FocusScope.of(context).requestFocus(FocusNode());
                    pickupController.callApi(' ');
                    pickupController.update();
                  },
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(SingleToneValue.instance.pickLat,
                        SingleToneValue.instance.pickLng),
                    zoom: 16.151926040649414,
                  ),
                  onCameraMove: (CameraPosition position) {
                    SingleToneValue.instance.pickLat = position.target.latitude;
                    SingleToneValue.instance.pickLng =
                        position.target.longitude;
                  },
                  onMapCreated: (GoogleMapController controller) {
                    pickupController.onMapCreated(controller);
                  },
                  onCameraIdle: () {
                    pickupController.getCustomLocation(
                      SingleToneValue.instance.pickLat,
                      SingleToneValue.instance.pickLng,
                    );
                  },
                ),
              ),
              Center(
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Image.asset(
                        MyImgs.mapPin,
                        height: Dimens.size35,
                      ))),
              // Positioned(
              //   top: getHeight(Dimens.size70),
              //   left: getWidth(Dimens.size15),
              //   right: getWidth(Dimens.size15),
              //   child: Container(
              //     width: getWidth(mediaQuery.width),
              //     height: getHeight(Dimens.size50),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(Dimens.size5),
              //         color: MyColors.white),
              //     child: TextFormField(
              //       controller: pickupController.locationTextController,
              //       onChanged: (value) {
              //         pickupController.updateText(value);
              //       },
              //       style: TextStyle(
              //         color: MyColors.black,
              //         fontFamily: 'ubuntu',
              //         fontSize: Dimens.size16,
              //         fontWeight: FontWeight.w500,
              //       ),
              //       decoration: InputDecoration(
              //         border: InputBorder.none,
              //         suffixIcon: GestureDetector(
              //             onTap: () {
              //               pickupController.locationTextController.text = ' ';
              //               pickupController.callApi(' ');
              //             },
              //             child: Icon(Icons.clear_outlined)),
              //         hintText: Strings.searchMap,
              //         hintStyle: TextStyle(
              //           fontWeight: FontWeight.w500,
              //           fontSize: Dimens.size14,
              //           color: MyColors.black,
              //           fontFamily: 'ubuntu',
              //         ),
              //         contentPadding: EdgeInsets.all(Dimens.size10),
              //         prefixIcon: GestureDetector(
              //             onTap: () {
              //               Get.offAll(() => PickupAddress());
              //             },
              //             child: Icon(Icons.arrow_back_ios_outlined)),
              //       ),
              //     ),
              //   ),
              // ),

              Positioned(
                bottom: getHeight(Dimens.size100),
                left: getWidth(Dimens.size15),
                right: getWidth(Dimens.size15),
                child: Obx(
                  () => GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimens.size8),
                      height: getHeight(Dimens.size60),
                      width: getWidth(mediaQuery.width),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimens.size5),
                          color: MyColors.white),
                      child: Center(
                        child: Text(
                          pickupController.customLocationDisplay.value,
                          style: textTheme.bodyText2!
                              .copyWith(color: MyColors.primaryColor),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: getHeight(Dimens.size30),
                left: getWidth(Dimens.size15),
                right: getWidth(Dimens.size15),
                child: CustomButton(
                    height: getHeight(Dimens.size50),
                    width: getWidth(mediaQuery.width),
                    text: Strings.confirm,
                    onPressed: () {
                      pickupController.locationTextController.clear();
                      Get.back();
                      //Get.to(() => PickupAddress());
                      // Get.off(() => AddNewAddressSavedDetails());
                    }),
              ),
              Positioned(
                bottom: getHeight(Dimens.size180),
                right: getWidth(Dimens.size15),
                child: GestureDetector(
                  onTap: () async {
                    await pickupController.goToCurrentLocation();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(Dimens.size10),
                    child: Container(
                      height: getHeight(Dimens.size40),
                      width: getWidth(Dimens.size40),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: MyColors.primaryColor),
                      child: Icon(
                        Icons.location_on,
                        color: MyColors.secondaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: Dimens.size120),
              //   child: Wrap(children: [
              //     pickupController.searchPlaces != null
              //         ? pickupController.getUpdatePlaces(
              //             context, pickupController.searchPlaces!)
              //         : const Text(''),
              //   ]),
              // ),
              // Positioned(
              //   top: getHeight(Dimens.size40),
              //   left: getWidth(Dimens.size40),
              //   child: GestureDetector(
              //     onTap: () {
              //
              //     },
              //     child: Container(
              //       height: getHeight(Dimens.size50),
              //       width: getWidth(Dimens.size50),
              //       decoration: BoxDecoration(
              //           shape: BoxShape.circle, color: MyColors.primaryColor),
              //       child: Center(
              //         child: Icon(
              //           Icons.arrow_back_ios,
              //           color: MyColors.secondaryColor,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          );
        }),
      ),
    );
  }

  onBack() {
    Get.off(() => PickupAddress());
  }
}
