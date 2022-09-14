import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../data/model/get_user_cards/get_user_card_modal.dart';
import '../../data/repository.dart';
import '../../data/singleton/singleton.dart';
import '../../data/validation.dart';
import '../../ui/payment/saved_card_screen.dart';
import '../../ui/send_parcel_and_payment/order_summary/order_confirmed.dart';
import '../../ui/values/my_colors.dart';
import '../../ui/widgets/progress_bar.dart';

class PaymentController extends GetxController
    with StateMixin<GetUserCardsModal> {
  var cardValue = false.obs;
  var btnColor = 0;
  final _repo = Repository();
  final validation = ValidationOfField();

  final GlobalKey<FormState> cardFormKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController expire = TextEditingController();
  TextEditingController cvv = TextEditingController();

  getCards() async {
    var flagConnected = false;
    final result = await InternetAddress.lookup('google.com').timeout(Duration(
      seconds: 5,
    ));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      // when connected
      flagConnected = true;

      if (flagConnected) {
        return _repo.getUserCardRepo().then((value) {
          if (value.responseCode == "1") {
            change(value, status: RxStatus.success());
          } else {
            change(value, status: RxStatus.empty());
          }
        }, onError: (e) {
          Get.snackbar(
            "Error",
            "Something Went Wrong",
            backgroundColor: MyColors.red500,
            colorText: MyColors.white,
          );
        });
      }
    } else {
      //when no internet
      Get.snackbar("Error", "Please check your internet connection!",
          backgroundColor: MyColors.red500, colorText: MyColors.white);
    }
  }

  addCard({
    required String cardNum,
    required String month,
    required String year,
    required String cvv,
  }) async {
    await _repo
        .addCardRepo(cardNum: cardNum, month: month, year: year, cvv: cvv)
        .then((value) {
      if (value.responseCode == "1") {
        clearData();
        Get.snackbar(
          "Message",
          value.responseMessage.toString(),
          backgroundColor: MyColors.green600,
          colorText: MyColors.white,
        );
        Get.offAll(() => SavedCards(
              pgID: 1,
            ));
      }
      // else {
      //   Get.snackbar(value.errors.toString(), value.errors.toString(),
      //     backgroundColor: MyColors.red500,
      //     colorText: MyColors.white,
      //   );
      // }
    }, onError: (e) {
      Get.snackbar(
        value!.errors.toString(),
        value!.errors.toString(),
        backgroundColor: MyColors.red500,
        colorText: MyColors.white,
      );
    }).whenComplete(() => getCards());
  }

  onProfileSaveCard() async {
    var flagConnected = false;
    final result = await InternetAddress.lookup('google.com').timeout(Duration(
      seconds: 5,
    ));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      String split = expire.text;
      print("date string $split");
      var a = split.split('/');
      String a1 = a.first;
      String a2 = a.last;
      print('first part:$a1');
      print('last part: $a2');
      // when connected
      flagConnected = true;

      if (flagConnected) {
        final isValid = cardFormKey.currentState!.validate();
        if (!isValid) {
          return;
        } else {
          Get.dialog(ProgressBar(), barrierDismissible: false);
          addCard(cardNum: number.text, month: a1, year: a2, cvv: cvv.text);
        }
      }
    } else {
      //when no internet
      Get.snackbar("Error", "Please check your internet connection!",
          backgroundColor: MyColors.red500, colorText: MyColors.white);
    }
  }

  onSaveCardOrder() async {
    var flagConnected = false;
    final result = await InternetAddress.lookup('google.com').timeout(Duration(
      seconds: 5,
    ));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      String split = expire.text;
      print("date string $split");
      var b = split.split('/');
      String b1 = b.first;
      String b2 = b.last;
      print('first part:$b1');
      print('last part: $b2');
      // when connected
      flagConnected = true;

      if (flagConnected) {
        final isValid = cardFormKey.currentState!.validate();
        if (!isValid) {
          return;
        } else {
          Get.dialog(ProgressBar(), barrierDismissible: false);
          addCardForPayment(
              cardNum: number.text,
              month: b1,
              year: b2,
              cID: SingleToneValue.instance.coupon,
              cvv: cvv.text,
              bID: SingleToneValue.instance.orderId!,
              status: true);
        }
      }
    } else {
      //when no internet
      Get.snackbar("Error", "Please check your internet connection!",
          backgroundColor: MyColors.red500, colorText: MyColors.white);
    }
  }

  addCardForPayment({
    required String cardNum,
    required String month,
    required String year,
    required String cvv,
    required String bID,
    required String cID,
    required bool status,
  }) async {
    await _repo
        .addCardForPaymentRepo(
            cardNum: cardNum,
            month: month,
            year: year,
            cvv: cvv,
            cID: cID,
            bID: bID,
            status: status)
        .then((value) {
      if (value.responseCode == "1") {
        Get.snackbar(
          "Message",
          value.responseMessage.toString(),
          backgroundColor: MyColors.green600,
          colorText: MyColors.white,
        );
        clearData();
        Get.offAll(() => OrderConfirmed());
      } else {
        Get.snackbar(
          value.errors.toString(),
          value.responseMessage.toString(),
          backgroundColor: MyColors.red500,
          colorText: MyColors.white,
        );
      }
    }).whenComplete(() => getCards());
  }

  deleteCard({required String pmID}) {
    _repo.deleteCardRepo(pmID: pmID).then((value) {
      if (value.responseCode == "1") {
        Fluttertoast.showToast(
          msg: value.responseMessage.toString(), // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.BOTTOM,
          backgroundColor: MyColors.green600,
          textColor: MyColors.white,
          // location// duration
        );
      } else {
        Fluttertoast.showToast(
          msg: value.errors.toString(), // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.BOTTOM,
          backgroundColor: MyColors.red500,
          textColor: MyColors.white,
          // location// duration
        );
      }
    }, onError: (e) {
      Get.snackbar(
        "Error",
        "Something went wrong",
        backgroundColor: MyColors.red500,
        colorText: MyColors.white,
      );
    }).whenComplete(() => getCards());
  }

  clearData() {
    name.clear();
    cvv.clear();
    number.clear();
    expire.clear();
    SingleToneValue.instance.coupon = "";
  }

  paymentBySavedCard({
    required String bID,
    required String pmID,
    required String cID,
  }) {
    _repo.paymentBySavedCardsRepo(bID: bID, pmID: pmID, cID: cID).then((value) {
      if (value.responseCode == "1") {
        SingleToneValue.instance.coupon = "";
        Get.snackbar(
          "Message",
          value.responseMessage.toString(),
          backgroundColor: MyColors.green600,
          colorText: MyColors.white,
        );
        Get.offAll(() => OrderConfirmed());
      } else {
        Get.snackbar(
          value.errors.toString(),
          value.responseMessage.toString(),
          backgroundColor: MyColors.red500,
          colorText: MyColors.white,
        );
      }
    }, onError: (e) {
      Get.snackbar(
        "Error",
        "Something Went Wrong",
        backgroundColor: MyColors.red500,
        colorText: MyColors.white,
      );
    });
  }

  onCardPaymentButton({
    required String bID,
    required String cID,
    required String pmID,
  }) async {
    var flagConnected = false;
    final result = await InternetAddress.lookup('google.com').timeout(Duration(
      seconds: 5,
    ));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      // when connected
      flagConnected = true;

      if (flagConnected) {
        Get.dialog(ProgressBar(), barrierDismissible: false);
        paymentBySavedCard(bID: bID, pmID: pmID, cID: cID);
      }
    } else {
      //when no internet
      Get.snackbar("Error", "Please check your internet connection!",
          backgroundColor: MyColors.red500, colorText: MyColors.white);
    }
  }

  @override
  void onInit() {
    getCards();
    // TODO: implement onInit
    super.onInit();
  }
}
