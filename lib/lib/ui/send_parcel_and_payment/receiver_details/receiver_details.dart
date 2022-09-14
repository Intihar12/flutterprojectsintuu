import 'package:antrakuserinc/controllers/receiver_controller/receiver_controller.dart';
import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:antrakuserinc/ui/auth/login/login.dart';
import 'package:antrakuserinc/ui/send_parcel_and_payment/other_details/other_details.dart';
import 'package:antrakuserinc/ui/send_parcel_and_payment/receiver_details/add_receiver_address.dart';
import 'package:antrakuserinc/ui/widgets/phone_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/size_config.dart';
import 'package:antrakuserinc/ui/widgets/address_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../controllers/pickup_controller/pickup_controller.dart';
import '../../values/my_fonts.dart';
import '../../values/strings.dart';
import '../../values/values.dart';
import '../../widgets/add_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../pickup/add_pickup_address.dart';
import '../pickup/pickup_details.dart';

class ReceiverDetails extends GetView<ReceiverController> {
  //final recieverController = Get.put(ReceiverController());
  final GlobalKey<FormState> rFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return WillPopScope(
      onWillPop: () {
        return onPopScope();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(Strings.recDetails),
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                onPopScope();
              },
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            print("tap");
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.recDetails,
                    style: textTheme.headline3!.copyWith(
                        color: Colors.grey, fontFamily: MyFonts.nulshok),
                  ),
                  SizedBox(
                    height: getHeight(Dimens.size15),
                  ),
                  Text(
                    Strings.recAddress,
                    style: textTheme.headline4!
                        .copyWith(color: MyColors.primaryColor),
                  ),
                  SizedBox(
                    height: getHeight(Dimens.size10),
                  ),
                  controller.obx(
                    (data) => data.response.length != 0
                        ? Container(
                            height: getHeight(Dimens.size160),
                            child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: data.response.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.5,
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 10),
                              itemBuilder: (BuildContext context, int index) {
                                return GetBuilder<ReceiverController>(
                                    builder: (context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: MyColors.addressCon,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: SingleToneValue.instance.dAddressState==index?
                                            MyColors.secondaryColor: MyColors.white,
                                          )
                                      ),
                                      child: AddressWidget(
                                        title: data.response[index].title,
                                        zipCode: data.response[index].zip,
                                        exactAddress: "${data.response[index].exactAddress} ",
                                        phone: data.response[index].phoneNum,
                                        aptNum: data.response[index].aptNum,
                                        aptName: data.response[index].building,
                                        city: data.response[index].city,
                                        state: data.response[index].state,

                                        onTap: () {
                                          SingleToneValue.instance.dropAddressId =  data.response[index].id.toString();
                                          SingleToneValue.instance.newLength=data.response.length;
                                          if(SingleToneValue.instance.dropAddressId==SingleToneValue.instance.pickupAddressId){
                                            Get.defaultDialog(
                                                title: "Caution",
                                                middleText: "Pickup and receiver address cannot be same.",
                                                titleStyle: Get.textTheme.subtitle2!
                                                    .copyWith(color: MyColors.red500, fontWeight: FontWeight.w500),
                                                onConfirm: () {
                                                  Get.back();
                                                });
                                          }
                                          else{
                                            SingleToneValue.instance.dAddressState =    index;
                                            SingleToneValue.instance.dropAddressId =   data.response[index].id.toString();
                                            SingleToneValue.instance.rPhone1 =    data.response[index].phoneNum;
                                            SingleToneValue.instance.rAddress =     data.response[index].exactAddress;

                                            controller.update();
                                          }
                                        },
                                      ),
                                    );
                                  }
                                );
                              },
                            ))
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
                                    height: getHeight(Dimens.size140),
                                    width: getWidth(Dimens.size140),
                                    color:
                                    MyColors.tertiaryColor.withOpacity(0.2),
                                  );
                                },
                              )))
                  ),
                  SizedBox(
                    height: getHeight(Dimens.size20),
                  ),
                  AddButton(
                      height: getHeight(Dimens.size40),
                      width: getWidth(Dimens.size330),
                      text: Strings.addAddress,
                      onPressed: () {
                        SingleToneValue.instance.dAddressState=-1;
                        SingleToneValue.instance.dropAddressId='-1';
                        Get.off(() => AddReceiverAddress());
                      }),
                  SizedBox(
                    height: getHeight(Dimens.size30),
                  ),
                  GetBuilder<ReceiverController>(
                    builder: (context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: rFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Strings.recFullname,
                                  style: textTheme.headline4!
                                      .copyWith(color: MyColors.primaryColor),
                                ),
                                CustomTextField(
                                    text: Strings.enterFullname,
                                    controller: controller.rName,
                                    length: 30,
                                    autovalidateMode: controller.rName.text.length>=1 ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                                    onChanged: (value){
                                      controller.update();
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    inputFormatters: FilteringTextInputFormatter
                                        .singleLineFormatter),
                                SizedBox(
                                  height: getHeight(Dimens.size20),
                                ),
                                Text(
                                  Strings.recEmail,
                                  style: textTheme.headline4!
                                      .copyWith(color: MyColors.primaryColor),
                                ),
                                CustomTextField(
                                  text: Strings.enterRecEmail,
                                  controller: controller.rEmail,
                                  length: 30,
                                  autovalidateMode: controller.rEmail.text.length>=1 ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                                  onChanged: (value){
                                    controller.update();
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  inputFormatters: FilteringTextInputFormatter.deny(RegExp('[ ]')),

                                ),
                              ],
                            ),
                          ),


                          SizedBox(
                            height: getHeight(Dimens.size20),
                          ),
                          Text(
                            Strings.recPhone,
                            style: textTheme.headline4!
                                .copyWith(color: MyColors.primaryColor),
                          ),
                          SizedBox(
                            height: getHeight(Dimens.size8),
                          ),
                          PhonePicker(
                              countryCode: controller.code,
                              controller: controller.phoneController),
                        ],
                      );
                    }
                  ),
                  SizedBox(
                    height: getHeight(Dimens.size30),
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
                  text: Strings.submitContinue,
                  onPressed: () {
                    if(rFormKey.currentState!.validate()){
                      controller.emailVealidate(controller.rEmail.text);
                    }

                  }),
            ),
          ],
        ),
      ),
    );
  }

  onPopScope() {
    // if(SingleToneValue.instance.length!=SingleToneValue.instance.newLength){
    //   SingleToneValue.instance.pAddressSate++;
    //   SingleToneValue.instance.length++;
    // }
    Get.offAll(PickupDetails());
  }
}
