import 'package:antrakuserinc/controllers/profile_controller/profile_controller.dart';
import 'package:antrakuserinc/ui/profile/profile_drawer.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/strings.dart';
import 'package:antrakuserinc/ui/widgets/country_picker_for_edit_profile.dart';
import 'package:antrakuserinc/ui/widgets/custom_button.dart';
import 'package:antrakuserinc/ui/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../values/size_config.dart';
import '../widgets/phone_picker.dart';

class EditProfile extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return WillPopScope(
      onWillPop: () {
        return onBack();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(Strings.editProfile),
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                Get.off(() => ProfileDrawer());
              },
              child: Icon(Icons.arrow_back_ios)),
          actions: [
            Center(
                child: GestureDetector(
              onTap: () {
                controller.isEdit.value = false;
                controller.f1.value.requestFocus();
              },
              child: Obx(() {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: controller.isEdit.value
                      ? Text(Strings.edit)
                      : Container(),
                );
              }),
            ))
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getHeight(Dimens.size30),
                    ),
                    Text(
                      Strings.firstName,
                      style: textTheme.bodyText2!
                          .copyWith(color: MyColors.black.withOpacity(0.5)),
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size5),
                    ),
                    Obx(() {
                      return CustomTextField(
                          focusNode: controller.f1.value,
                          Readonly: controller.isEdit.value,
                          text: '',
                          controller: controller.fnameController,
                          length: 30,
                          keyboardType: TextInputType.text,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter);
                    }),
                    SizedBox(
                      height: getHeight(Dimens.size15),
                    ),
                    Text(
                      Strings.lastName,
                      style: textTheme.bodyText2!
                          .copyWith(color: MyColors.black.withOpacity(0.5)),
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size5),
                    ),
                    Obx(() {
                      return CustomTextField(
                          Readonly: controller.isEdit.value,
                          controller: controller.lnameController,
                          text: '',
                          length: 30,
                          keyboardType: TextInputType.text,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter);
                    }),
                    SizedBox(
                      height: getHeight(Dimens.size15),
                    ),
                    Text(
                      Strings.singPhone,
                      style: textTheme.bodyText2!
                          .copyWith(color: MyColors.black.withOpacity(0.5)),
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size5),
                    ),
                    controller.obx(
                      (data) {
                        return CountryPickerForEdit(
                            Readonly: controller.isEdit.value,
                            countryCode: data.response[0].countryCode,
                            controller: controller.phoneController);
                      },
                      onLoading: Shimmer.fromColors(
                          baseColor: MyColors.grey.withOpacity(0.08),
                          highlightColor: MyColors.white,
                          child: Container(
                            height: getHeight(Dimens.size40),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.tertiaryColor.withOpacity(0.2)),
                          )),
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size15),
                    ),
                    Text(
                      Strings.email,
                      style: textTheme.bodyText2!
                          .copyWith(color: MyColors.black.withOpacity(0.5)),
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size15),
                    ),
                    CustomTextField(
                        Readonly: true,
                        controller: controller.emailController,
                        text: '',
                        length: 30,
                        keyboardType: TextInputType.text,
                        inputFormatters:
                            FilteringTextInputFormatter.singleLineFormatter),
                    SizedBox(
                      height: getHeight(Dimens.size40),
                    ),
                    Obx(() {
                      return Container(
                        child: controller.isEdit.value
                            ? Container()
                            : CustomButton(
                                height: getHeight(Dimens.size40),
                                width: getWidth(Dimens.size300),
                                text: Strings.save,
                                onPressed: () {
                                  controller.updateButton();
                                }),
                      );
                    })
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
    Get.offAll(() => ProfileDrawer());
  }
}
