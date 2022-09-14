import 'package:antrakuserinc/controllers/payment_controller/payment_controller.dart';
import 'package:antrakuserinc/ui/payment/saved_card_screen.dart';
import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/strings.dart';
import 'package:date_picker_timeline/extra/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../values/my_fonts.dart';
import '../values/size_config.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/formatter.dart';

class AddNewCard extends StatelessWidget {
  int pdID;
  AddNewCard({Key? key, required this.pdID}) : super(key: key);

  final paymentController = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return WillPopScope(
      onWillPop: () {
        return onBack(pdID);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Payment"),
          leading: GestureDetector(
              onTap: () {
                Get.off(() => SavedCards(
                      pgID: pdID,
                    ));
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
                key: paymentController.cardFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getHeight(Dimens.size50),
                    ),
                    Center(
                      child: Text(
                        Strings.addCardDetails,
                        style: textTheme.headline1!
                            .copyWith(color: MyColors.primaryColor),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size20),
                    ),
                    // Text(
                    //   Strings.cardHolderName,
                    //   style: textTheme.headline3!
                    //       .copyWith(color: MyColors.primaryColor),
                    // ),
                    // SizedBox(
                    //   height: getHeight(Dimens.size5),
                    // ),
                    // CustomTextField(
                    //     controller: paymentController.name,
                    //     text: Strings.cardHolderHint,
                    //     length: 50,
                    //     keyboardType: TextInputType.emailAddress,
                    //     inputFormatters:
                    //         FilteringTextInputFormatter.singleLineFormatter),
                    SizedBox(
                      height: getHeight(Dimens.size25),
                    ),
                    Text(
                      Strings.accountNumber,
                      style: textTheme.headline3!
                          .copyWith(color: MyColors.primaryColor),
                    ),
                    SizedBox(
                      height: getHeight(Dimens.size5),
                    ),
                    CustomTextField(
                        validator: (value) {
                          return paymentController.validation.cardNo(value!);
                        },
                        controller: paymentController.number,
                        text: Strings.accountHint,
                        length: 16,
                        keyboardType: TextInputType.number,
                        inputFormatters:
                            FilteringTextInputFormatter.singleLineFormatter),
                    SizedBox(
                      height: getHeight(Dimens.size25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.expiry,
                              style: textTheme.headline3!
                                  .copyWith(color: MyColors.primaryColor),
                            ),
                            SizedBox(
                              height: getHeight(Dimens.size5),
                            ),
                            Container(
                              height: getHeight(Dimens.size40),
                              width: getWidth(Dimens.size150),
                              padding: EdgeInsets.only(left: 10, right: 15),
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  //  color: MyColors.appBackground,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: MyColors.greyFont, width: 1)),
                              child: TextFormField(
                                validator: (value) {
                                  return paymentController.validation
                                      .expiry(value!);
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: paymentController.expire,
                                // maxLines: 5,
                                maxLength: 5,
                                style: textTheme.bodyText2,
                                keyboardType: TextInputType.number,
                                cursorHeight: 25,
                                decoration: const InputDecoration(
                                  counterText: '',
                                  hintStyle: TextStyle(
                                    color: MyColors.greyFont,
                                    fontFamily: MyFonts.ubuntu,
                                    fontWeight: FontWeight.normal,
                                    fontSize: Dimens.size14,
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      left: 8, bottom: 12),
                                  border: InputBorder.none,
                                  hintText: Strings.expiryHint,
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(5),
                                  DateFormatter(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.cvv,
                              style: textTheme.headline3!
                                  .copyWith(color: MyColors.primaryColor),
                            ),
                            SizedBox(
                              height: getHeight(Dimens.size5),
                            ),
                            CustomTextField(
                                validator: (value) {
                                  return paymentController.validation
                                      .cvv(value!);
                                },
                                controller: paymentController.cvv,
                                width: getWidth(Dimens.size150),
                                text: Strings.cvv,
                                length: 4,
                                keyboardType: TextInputType.number,
                                inputFormatters: FilteringTextInputFormatter
                                    .singleLineFormatter),
                          ],
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: getHeight(Dimens.size25),
                    // ),
                    // pdID == 2
                    //     ? Obx(
                    //         () => Row(
                    //           children: [
                    //             Checkbox(
                    //                 value: paymentController.cardValue.value,
                    //                 onChanged: (value) {
                    //                   paymentController.cardValue.value =
                    //                       value!;
                    //                 }),
                    //             Text(
                    //               Strings.paymentCheck,
                    //               style: textTheme.subtitle1!
                    //                   .copyWith(color: MyColors.primaryColor),
                    //             )
                    //           ],
                    //         ),
                    //       )
                    //     : Text(""),
                    SizedBox(
                      height: getHeight(Dimens.size25),
                    ),
                    CustomButton(
                        height: getHeight(Dimens.size40),
                        width: getWidth(mediaQuery.width),
                        text:
                            pdID == 1 ? Strings.newcardSave : Strings.cardSave,
                        onPressed: () {
                          pdID == 1
                              ? paymentController.onProfileSaveCard()
                              : paymentController.onSaveCardOrder();
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

  onBack(int id) {
    Get.off(() => SavedCards(pgID: id));
  }
}
