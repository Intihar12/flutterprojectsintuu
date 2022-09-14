import 'package:antrakuserinc/controllers/payment_controller/payment_controller.dart';
import 'package:antrakuserinc/data/constants/constants.dart';
import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:antrakuserinc/ui/payment/add_new_card.dart';
import 'package:antrakuserinc/ui/profile/profile_drawer.dart';
import 'package:antrakuserinc/ui/send_parcel_and_payment/order_summary/order_summary.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/my_imgs.dart';
import 'package:antrakuserinc/ui/values/strings.dart';
import 'package:antrakuserinc/ui/widgets/add_button.dart';
import 'package:antrakuserinc/ui/widgets/custom_button.dart';
import 'package:date_picker_timeline/extra/dimen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../values/size_config.dart';
import '../widgets/progress_bar.dart';

class SavedCards extends GetView<PaymentController> {
  int pgID;
  SavedCards({Key? key, required this.pgID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return WillPopScope(
      onWillPop: () {
        return onBack(pgID);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Cards List"),
          leading: GestureDetector(
              onTap: () {
                pgID == 1
                    ? Get.off(() => ProfileDrawer())
                    : Get.off(() => OrderSummary());
              },
              child: Icon(Icons.arrow_back_ios)),
          // actions: [
          //   GestureDetector(
          //     onTap: () async {
          //       await controller.getCards();
          //     },
          //     child: Icon(
          //       Icons.refresh_outlined,
          //       color: Colors.white,
          //       size: Dimens.size25,
          //     ),
          //   ),
          //   SizedBox(
          //     width: Dimens.size20,
          //   ),
          // ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getHeight(Dimens.size30),
              ),
              Text(
                Strings.savedCards,
                style:
                    textTheme.headline3!.copyWith(color: MyColors.primaryColor),
              ),
              SizedBox(
                height: getHeight(Dimens.size20),
              ),
              controller.obx(
                (data) => data!.response!.length != 0
                    ? Container(
                        height: getHeight(500),
                        width: getWidth(mediaQuery.width),
                        child: RefreshIndicator(
                          onRefresh: () {
                            return controller.getCards();
                          },
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimens.size10,
                                vertical: Dimens.size15),
                            itemCount: data.response!.length,
                            separatorBuilder: (context, index) => SizedBox(
                              height: getHeight(10),
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.btnColor=0;
                                  pgID == 2
                                      ? dialog(
                                          context: context,
                                          bID:
                                              SingleToneValue.instance.orderId!,
                                          pmID: data.response![index].pmId!)
                                      : pgID;
                                },
                                child: Dismissible(
                                  secondaryBackground: Container(
                                    color: MyColors.red500,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.delete,
                                              color: MyColors.white),
                                          Text('Move to trash',
                                              style: TextStyle(
                                                  color: MyColors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  background: Container(
                                    color: MyColors.red500,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.delete,
                                              color: MyColors.white),
                                          Text('Move to trash',
                                              style: TextStyle(
                                                  color: MyColors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  key: UniqueKey(),
                                  onDismissed:
                                      (DismissDirection direction) async {
                                    Get.dialog(ProgressBar(),
                                        barrierDismissible: false);
                                    await controller.deleteCard(
                                        pmID: data.response![index].pmId!);
                                  },
                                  child: Material(
                                    elevation: 4,
                                    borderRadius:
                                        BorderRadius.circular(Dimens.size5),
                                    child: Container(
                                      height: getHeight(Dimens.size65),
                                      width: getWidth(Dimens.size370),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimens.size5),
                                          color: MyColors.tertiaryColor),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimens.size15),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: getHeight(Dimens.size30),
                                              width: getWidth(Dimens.size50),
                                              decoration: BoxDecoration(
                                                color: MyColors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimens.size5),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(5.0),
                                                child: FadeInImage.assetNetwork(
                                                  height: Dimens.size15,
                                                  width: Dimens.size30,
                                                  placeholder: MyImgs.onLoading,
                                                  image:
                                                      "${Constants.imagesBaseUrl}${data.response![index].image}",
                                                  imageErrorBuilder: (context,
                                                          e, stackTrace) =>
                                                      Image.asset(
                                                          MyImgs.errorImage,
                                                          height: Dimens.size30,
                                                          width: Dimens.size15),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: getWidth(15),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  data.response![index].brand!
                                                      .capitalizeFirst!,
                                                  style: textTheme.headline5!
                                                      .copyWith(
                                                          color: MyColors
                                                              .primaryColor),
                                                ),
                                                Text(
                                                  "${Strings.saveaccountHint} ${data.response![index].last4Digits}",
                                                  style: textTheme.bodyText1!
                                                      .copyWith(
                                                          color: MyColors
                                                              .primaryColor),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: MyColors.primaryColor,
                                              size: Dimens.size15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Container(
                        height: getHeight(500),
                        width: getWidth(mediaQuery.width),
                        child: Center(
                          child: Text("Please add some card first!"),
                        ),
                      ),
                onEmpty: (Container(
                  height: getHeight(Dimens.size500),
                  width: getWidth(mediaQuery.width),
                  child: Center(
                    child: Text("Please add some card first!"),
                  ),
                )),
                onLoading: Shimmer.fromColors(
                    baseColor: MyColors.grey.withOpacity(0.08),
                    highlightColor: MyColors.white,
                    child: Container(
                      height: getHeight(500),
                      width: getWidth(mediaQuery.width),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimens.size10, vertical: Dimens.size15),
                        itemCount: 6,
                        separatorBuilder: (context, index) => SizedBox(
                          height: getHeight(10),
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            height: getHeight(Dimens.size65),
                            width: getWidth(Dimens.size370),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.tertiaryColor.withOpacity(0.2)),
                          );
                        },
                      ),
                    )),
              ),
              SizedBox(
                height: getHeight(30),
              ),
              AddButton(
                  height: getHeight(Dimens.size45),
                  width: getWidth(Dimens.size350),
                  text: Strings.addCard,
                  onPressed: () {
                    Get.offAll(AddNewCard(
                      pdID: pgID,
                    ));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  dialog({
    required BuildContext context,
    required String bID,
    required String pmID,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(Dimens.size10),
              height: getHeight(Dimens.size150),
              width: getWidth(Dimens.size100),
              child: Column(
                children: [
                  Text(Strings.paymentYes),
                  SizedBox(
                    height: getHeight(Dimens.size10),
                  ),
                   GetBuilder<PaymentController>(
                     builder: (payController) {
                       return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomButton(
                              height: getHeight(30),
                              width: getWidth(40),
                              fontSize: getFont(12),
                              borderColor: MyColors.primaryColor,

                              color: controller.btnColor==1 ? MyColors.primaryColor : MyColors.white,
                              text: "Yes",
                              onPressed: (){
                                controller.onCardPaymentButton(
                                    bID: bID,
                                    pmID: pmID,
                                    cID: SingleToneValue.instance.coupon.toString());
                                controller.btnColor=1;

                                controller.update();
                              },
                            ),
                            SizedBox(
                              width: getWidth(Dimens.size35),
                            ),
                            CustomButton(
                              height: getHeight(30),
                              width: getWidth(40),
                              borderColor: MyColors.primaryColor,
                              color: controller.btnColor==2 ? MyColors.primaryColor : MyColors.white,
                              text: "No",
                              fontSize: getFont(12),
                              onPressed: (){
                                Get.back();
                                controller.btnColor=2;
                                controller.update();

                              },
                            ),
                          ],
                        );
                     }
                   ),

                ],
              ),
            ),
          );
        });
  }

  onBack(int pd) {
    pd == 1
        ? Get.offAll(() => ProfileDrawer())
        : Get.offAll(() => OrderSummary());
  }
}
