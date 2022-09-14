import 'package:antrakuserinc/controllers/map_controller/map_controller.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/widgets/country_picker.dart';
import 'package:antrakuserinc/ui/widgets/phone_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controllers/address_controller/address_controller.dart';
import '../values/my_colors.dart';
import '../values/size_config.dart';
import '../values/strings.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'add_new_address_saved.dart';

class AddNewAddressSavedDetails extends StatelessWidget {
  AddNewAddressSavedDetails({Key? key}) : super(key: key);

  AddressController addressController = Get.find();
  LocationController location = Get.find();
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
          centerTitle: true,
          title: Text("Add Address Details"),
          leading: GestureDetector(
              onTap: () {
                Get.off(() => AddNewAddressSaved());
              },
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
              child: Form(
                key: addressController.addAddressFormKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: getHeight(Dimens.size20),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.addtitle,
                          style: textTheme.subtitle2!
                              .copyWith(fontSize: getFont(12)),
                        ),
                        SizedBox(
                          height: getHeight(Dimens.size5),
                        ),
                        CustomTextField(
                            controller: addressController.title,
                            text: Strings.addressTitle,
                            length: 50,
                            keyboardType: TextInputType.emailAddress,
                            inputFormatters:
                            FilteringTextInputFormatter.singleLineFormatter),
                      ],
                    ),

                    SizedBox(
                      height: getHeight(Dimens.size20),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.addStreet,
                          style: textTheme.subtitle2!
                              .copyWith(fontSize: getFont(12)),
                        ),
                        SizedBox(
                          height: getHeight(Dimens.size5),
                        ),
                         CustomTextField(
                              controller: addressController.street,
                              text: "Street",
                              length: 50,

                              keyboardType: TextInputType.emailAddress,
                              inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter),

                          //     Text(
                          //   location.customLocationTextField.value,
                          //   overflow: TextOverflow.ellipsis,
                          //   softWrap: true,
                          //   maxLines: 1,
                          //   style: textTheme.bodyText2!.copyWith(fontSize: getFont(14)),
                          //   textAlign: TextAlign.start,
                          // ),

                      ],
                    ),


                    SizedBox(
                      height: getHeight(Dimens.size20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.addFlat,
                              style: textTheme.subtitle2!
                                  .copyWith(fontSize: getFont(12)),
                            ),
                            SizedBox(
                              height: getHeight(Dimens.size5),
                            ),
                            CustomTextField(
                                controller: addressController.building,
                                width: getWidth(Dimens.size180),
                                text: Strings.building,
                                length: 50,
                                keyboardType: TextInputType.emailAddress,
                                inputFormatters: FilteringTextInputFormatter
                                    .singleLineFormatter),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.addCity,
                              style: textTheme.subtitle2!
                                  .copyWith(fontSize: getFont(12)),
                            ),
                            SizedBox(
                              height: getHeight(Dimens.size5),
                            ),
                            CustomTextField(
                                controller: addressController.city,
                                width: getWidth(Dimens.size180),
                                text: Strings.city,
                                length: 50,
                                keyboardType: TextInputType.emailAddress,
                                inputFormatters: FilteringTextInputFormatter
                                    .singleLineFormatter),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.addState,
                              style: textTheme.subtitle2!
                                  .copyWith(fontSize: getFont(12)),
                            ),
                            SizedBox(
                              height: getHeight(Dimens.size5),
                            ),
                            CustomTextField(
                                controller: addressController.stateName,
                                width: getWidth(Dimens.size180),
                                text: Strings.state,
                                length: 50,
                                keyboardType: TextInputType.emailAddress,
                                inputFormatters: FilteringTextInputFormatter
                                    .singleLineFormatter),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.addZip,
                              style: textTheme.subtitle2!
                                  .copyWith(fontSize: getFont(12)),
                            ),
                            SizedBox(
                              height: getHeight(Dimens.size5),
                            ),
                            CustomTextField(
                                controller: addressController.zip,
                                width: getWidth(Dimens.size180),
                                text: Strings.zipcode,
                                length: 50,
                                keyboardType: TextInputType.emailAddress,
                                inputFormatters: FilteringTextInputFormatter
                                    .singleLineFormatter),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size20),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.addPhone,
                          style: textTheme.subtitle2!
                              .copyWith(fontSize: getFont(12)),
                        ),
                        SizedBox(
                          height: getHeight(Dimens.size5),
                        ),
                        PhonePicker(
                            countryCode: addressController.code,
                            controller: addressController.phone),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size20),
                    ),
                    CustomButton(
                        height: getHeight(Dimens.size50),
                        width: getWidth(mediaQuery.width),
                        text: Strings.confirm,
                        onPressed: () {
                          addressController.onAddressProfileButton();
                          // Get.to(() => HomePage());
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onBack() {
    Get.offAll(() => AddNewAddressSaved());
  }
}
