import 'package:antrakuserinc/ui/saved_address/save_address_profile.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/map_controller/map_controller.dart';
import '../../data/singleton/singleton.dart';
import '../values/my_imgs.dart';
import '../values/size_config.dart';
import '../widgets/custom_button.dart';
import 'add_new_address_saved_details.dart';

class AddNewAddressSaved extends StatefulWidget {
  const AddNewAddressSaved({Key? key}) : super(key: key);

  @override
  _AddNewAddressSavedState createState() => _AddNewAddressSavedState();
}

final locationController = Get.put(LocationController());

class _AddNewAddressSavedState extends State<AddNewAddressSaved> {
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
        body: GetBuilder(builder: (LocationController locationController) {
          return Stack(
            children: [
              Container(
                height: getHeight(mediaQuery.height),
                width: getWidth(Dimens.size414),
                child: GoogleMap(
                  onTap: (LatLng latLng) {
                    // for remove list on click on map
                    FocusScope.of(context).requestFocus(FocusNode());
                    locationController.callApi(' ');
                    locationController.update();
                  },
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(SingleToneValue.instance.latc,
                        SingleToneValue.instance.lngc),
                    zoom: 16.151926040649414,
                  ),
                  onCameraMove: (CameraPosition position) {
                    SingleToneValue.instance.latc = position.target.latitude;
                    SingleToneValue.instance.lngc = position.target.longitude;
                    print("lat+ ${locationController.lat}");
                    print("lng+${locationController.lng}");
                  },
                  onMapCreated: (GoogleMapController controller) {
                    locationController.onMapCreated(controller);
                  },
                  onCameraIdle: () {
                    locationController.getCustomLocation(
                        SingleToneValue.instance.latc,
                        SingleToneValue.instance.lngc);
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
              Positioned(
                top: getHeight(Dimens.size70),
                left: getWidth(Dimens.size15),
                right: getWidth(Dimens.size15),
                child: Container(
                  width: getWidth(mediaQuery.width),
                  height: getHeight(Dimens.size50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.size5),
                      color: MyColors.white),
                  child: TextFormField(
                    controller: locationController.locationTextController,
                    onChanged: (value) {
                      locationController.updateText(value);
                    },
                    style: TextStyle(
                      color: MyColors.black,
                      fontFamily: 'ubuntu',
                      fontSize: Dimens.size16,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            locationController.locationTextController.text =
                                ' ';
                            locationController.callApi(' ');
                          },
                          child: Icon(Icons.clear_outlined)),
                      hintText: Strings.searchMap,
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Dimens.size14,
                        color: MyColors.black,
                        fontFamily: 'ubuntu',
                      ),
                      contentPadding: EdgeInsets.all(Dimens.size10),
                      prefixIcon: GestureDetector(
                          onTap: () {
                            Get.off(() => SavedAddressProfile());
                          },
                          child: Icon(Icons.arrow_back_ios_outlined)),
                    ),
                  ),
                ),
              ),
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
                          locationController.customLocation.value,
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
                      Get.off(() => AddNewAddressSavedDetails());
                    }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Dimens.size120),
                child: Wrap(children: [
                  locationController.searchPlaces != null
                      ? locationController.getUpdatePlaces(
                          context, locationController.searchPlaces!)
                      : const Text(''),
                ]),
              ),
            ],
          );
        }),
      ),
    );
  }

  onBack() {
    Get.offAll(() => SavedAddressProfile());
  }
}
