import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../data/model/add_pack_map_model/add_pack_map_model.dart';
import '../../data/model/category_model/category_model.dart';
import '../../data/repository.dart';
import '../../data/singleton/singleton.dart';
import '../../ui/home/home_page.dart';
import '../../ui/send_parcel_and_payment/order_summary/order_summary.dart';
import '../../ui/send_parcel_and_payment/pickup/pickup_details.dart';
import '../../ui/values/values.dart';
import '../../ui/widgets/progress_bar.dart';

class ParcelController extends GetxController with StateMixin<CategoryModel> {
  var selected_index = 0.obs;
  var loadOffload = false.obs;
  var insurance = false.obs;
  var unitDimens = false.obs;
  String unitName = 'cm';
  String inches = 'inc';
  String intialCatId = "-1";
  String intialCatName = '';
  String? catId;
  String? catName;
  GlobalKey<FormState> sendParcelFormkey = GlobalKey<FormState>();
  final _repository = Repository();

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController worthController = TextEditingController();

  TextEditingController couponController = TextEditingController();
  TextEditingController tipController = TextEditingController();
  GlobalKey<FormState> coupenFormkey = GlobalKey<FormState>();

  Future<CategoryModel> getCategories() async {
    CategoryModel model = await _repository.getCategory();
    intialCatId = model.response![0].categories![0].id.toString();
    catId = model.response![0].categories![0].id.toString();
    intialCatName = model.response![0].categories![0].name.toString();
    catName = model.response![0].categories![0].name.toString();

    SingleToneValue.instance.insuranceText = model.response![0].insuranceText;
    SingleToneValue.instance.loadText =
        model.response![0].loadUnloadChargesText;
    SingleToneValue.instance.insuranceFee =
        model.response![0].insuranceChargesText;
    update();
    change(model, status: RxStatus.success());
    return model;
  }
  //
  // getCategories() async {
  //   try {
  //     await _repository.getCategory().then((value) {
  //       change(value, status: RxStatus.success());
  //
  //     }, onError: (err) {
  //       change(
  //         null,
  //         status: RxStatus.error(err.toString()),
  //       );
  //     });
  //   } catch (e) {
  //     Get.snackbar(
  //         "Error", e.toString().replaceAll('Error:', "Something Went Wrong"));
  //   }
  // }

  /// add pkg button
  addPackageBtn() {
    if (intialCatId == '-1') {
      Fluttertoast.showToast(
        msg: "Category Api not working", // message
        toastLength: Toast.LENGTH_LONG, // length
        gravity: ToastGravity.CENTER,
        backgroundColor: MyColors.red500,
        textColor: MyColors.white,
        // location// duration
      );
    } else {
      if (sendParcelFormkey.currentState!.validate()) {
        if (double.parse(weightController.text) > 0.4 &&
            int.parse(heightController.text) >= 5 &&
            int.parse(widthController.text) >= 5 &&
            int.parse(lengthController.text) >= 5 &&
            double.parse(worthController.text) >= 1) {
          SingleToneValue.instance.addPackage.add(Package(
                  categoryId: catId,
                  categoryName: catName,
                  weight: weightController.text,
                  height: heightController.text,
                  width: widthController.text,
                  length: lengthController.text,
                  estWorth: worthController.text,
                  insurance: insurance.value,
                  unit: unitName)
              .toJson());
          clearData();

          Fluttertoast.showToast(
            msg: "Package Added", // message
            toastLength: Toast.LENGTH_LONG, // length
            gravity: ToastGravity.CENTER,
            backgroundColor: MyColors.green600,
            textColor: MyColors.white,
            // location// duration
          );
        } else {
          showError();
        }
      }
    }
  }

  /// on submit button
  onSubmitBtn() {
    if (intialCatId == '-1') {
      Fluttertoast.showToast(
        msg: "Categories are loading, please wait ", // message
        toastLength: Toast.LENGTH_LONG, // length
        gravity: ToastGravity.CENTER,
        backgroundColor: MyColors.red500,
        textColor: MyColors.white,
        // location// duration
      );
    } else {
      if (sendParcelFormkey.currentState!.validate()) {
        if (double.parse(weightController.text) > 0.4 &&
            int.parse(heightController.text) >= 5 &&
            int.parse(widthController.text) >= 5 &&
            int.parse(lengthController.text) >= 5 &&
            double.parse(worthController.text) >= 1) {
          SingleToneValue.instance.addPackage.add(Package(
                  categoryId: catId,
                  categoryName: catName,
                  weight: weightController.text,
                  height: heightController.text,
                  width: widthController.text,
                  length: lengthController.text,
                  estWorth: worthController.text,
                  insurance: insurance.value,
                  unit: unitName)
              .toJson());
          clearData();
          Get.off(PickupDetails());
          Fluttertoast.showToast(
            msg: 'Package added',
            // message
            toastLength: Toast.LENGTH_LONG,
            // length
            gravity: ToastGravity.CENTER,
            backgroundColor: MyColors.green600,
            textColor: MyColors.white,
            // location// duration
          );
        } else {
          showError();
        }
      } else if (SingleToneValue.instance.addPackage.isNotEmpty) {
        if (weightController.text.isNotEmpty ||
            heightController.text.isNotEmpty ||
            worthController.text.isNotEmpty ||
            widthController.text.isNotEmpty ||
            lengthController.text.isNotEmpty) {
          Get.defaultDialog(
              title: "Caution",
              middleText:
                  "Please fill all field, if not then your package will not be added",
              titleStyle: Get.textTheme.subtitle2!.copyWith(
                  color: MyColors.red500, fontWeight: FontWeight.w500),
              onCancel: () {},
              onConfirm: () {
                Get.off(PickupDetails());
              });
        } else {
          Get.off(PickupDetails());
        }
      } else {
        Get.snackbar("Error", 'Please add one package to continue',
            backgroundColor: MyColors.red500, colorText: MyColors.white);
      }
    }
  }

  clearData() {
    sendParcelFormkey.currentState!.reset();
    SingleToneValue.instance.sId = 0;
    catId = intialCatId;
    catName = intialCatName;
    weightController.clear();
    heightController.clear();
    widthController.clear();
    lengthController.clear();
    worthController.clear();
    insurance.value = false;
    unitDimens.value = false;
    unitName = 'cm';
    update();
  }

  onParcelPopScope() {
    clearData();
    SingleToneValue.instance.addPackage.clear();
    Get.off(HomePage());
  }

  /// check internet connection
  checkInternet() async {
    try {
      final result =
          await InternetAddress.lookup('google.com').timeout(Duration(
        seconds: 5,
      ));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        getCategories();
      } else {
        //when no internet
        Get.snackbar("Error", "Please check your internet connection!",
            backgroundColor: MyColors.red500, colorText: MyColors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Please check your internet connection!",
          backgroundColor: MyColors.red500, colorText: MyColors.white);
    }
  }

  /// add booking

  addBooking({
    required List<Map<String, dynamic>> package,
    required String rName,
    required String rEmail,
    required String rAlPhoneNum,
    required String pickupDate,
    required String note,
    required String UserId,
    required String VehiclesTypeId,
    required bool load_unload,
    required String pickupId,
    required String deliveryId,
  }) async {
    await _repository
        .addBookingApiCall(package, rName, rEmail, rAlPhoneNum, pickupDate,
            note, UserId, VehiclesTypeId, load_unload, pickupId, deliveryId)
        .then((value) {
      if (value.responseCode == '1') {
        SingleToneValue.instance.orderId = value.response![0].bookingId;
        SingleToneValue.instance.amount = value.response![0].total;
        SingleToneValue.instance.packageIds.clear();
        SingleToneValue.instance.packagePrice.clear();
        SingleToneValue.instance.distance = value.response![0].distance;
        SingleToneValue.instance.loadUnloadAmount =
            value.response![0].loadAmount!;
        for (int i = 0; i < value.response![0].packageIds![0].id!.length; i++) {
          SingleToneValue.instance.packageIds
              .add(value.response![0].packageIds![0].id![i]);
          print("Package Id : ${SingleToneValue.instance.packageIds}");
        }
        for (int i = 0;
            i < value.response![0].packageIds![0].total!.length;
            i++) {
          SingleToneValue.instance.packagePrice
              .add(value.response![0].packageIds![0].total![i]);
          print("Package Price : ${SingleToneValue.instance.packagePrice}");
        }

        Get.off(OrderSummary());
      } else {
        Fluttertoast.showToast(
          msg: value.errors.toString(), // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.CENTER,
          backgroundColor: MyColors.red500,
          textColor: MyColors.white,
          // location// duration
        );
      }
    });
  }

  /// update booking
  updateBooking({
    required List<Map<String, dynamic>> package,
    required String rName,
    required String rEmail,
    required String rAlPhoneNum,
    required String pickupDate,
    required String note,
    required String UserId,
    required String VehiclesTypeId,
    required bool load_unload,
    required String pickupId,
    required String deliveryId,
    required String bookId,
  }) async {
    await _repository
        .updateBookingApiCall(
            package,
            rName,
            rEmail,
            rAlPhoneNum,
            pickupDate,
            note,
            UserId,
            VehiclesTypeId,
            load_unload,
            pickupId,
            deliveryId,
            bookId)
        .then((value) {
      if (value.responseCode == '1') {
        SingleToneValue.instance.orderId = value.response![0].bookingId;
        SingleToneValue.instance.amount = value.response![0].total;
        SingleToneValue.instance.loadUnloadAmount =
            value.response![0].loadAmount!;
        SingleToneValue.instance.packageIds.clear();
        SingleToneValue.instance.packagePrice.clear();
        SingleToneValue.instance.distance = value.response![0].distance;
        for (int i = 0; i < value.response![0].packageIds![0].id!.length; i++) {
          SingleToneValue.instance.packageIds
              .add(value.response![0].packageIds![0].id![i]);
          print("Package Id : ${SingleToneValue.instance.packageIds}");
        }
        for (int i = 0;
            i < value.response![0].packageIds![0].total!.length;
            i++) {
          SingleToneValue.instance.packagePrice
              .add(value.response![0].packageIds![0].total![i]);
          print("Package Price : ${SingleToneValue.instance.packagePrice}");
        }

        Fluttertoast.showToast(
          msg: value.responseMessage.toString(), // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.CENTER,
          backgroundColor: MyColors.green600,
          textColor: MyColors.white,
        );
        Get.off(OrderSummary());
      } else {
        Fluttertoast.showToast(
          msg: value.errors.toString(), // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.CENTER,
          backgroundColor: MyColors.red500,
          textColor: MyColors.white,
        );
      }
    });
  }

  /// add booking button
  addBookinBtn(String note) async {
    try {
      final result =
          await InternetAddress.lookup('google.com').timeout(Duration(
        seconds: 5,
      ));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        String uId = GetStorage().read("user_id");
        if (note != null) {
          SingleToneValue.instance.note = note;
        }
        Get.dialog(ProgressBar(), barrierDismissible: false);
        print(SingleToneValue.instance.addPackage);
        addBooking(
            package: SingleToneValue.instance.addPackage,
            rName: "${SingleToneValue.instance.rName}",
            rEmail: "${SingleToneValue.instance.rEmail}",
            rAlPhoneNum: "${SingleToneValue.instance.rPhone}",
            pickupDate:
                "${SingleToneValue.instance.date} ${SingleToneValue.instance.time}",
            note: SingleToneValue.instance.note,
            UserId: uId,
            VehiclesTypeId: "${SingleToneValue.instance.vehicleId}",
            load_unload: SingleToneValue.instance.loadUnload,
            pickupId: "${SingleToneValue.instance.pickupAddressId}",
            deliveryId: "${SingleToneValue.instance.dropAddressId}");
      } else {
        //when no internet
        Get.snackbar("Error", "Please check your internet connection!",
            backgroundColor: MyColors.red500, colorText: MyColors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Please check your internet connection!",
          backgroundColor: MyColors.red500, colorText: MyColors.white);
    }
  }

  /// update booking button
  upDateBookinBtn(String note) async {
    try {
      final result =
          await InternetAddress.lookup('google.com').timeout(Duration(
        seconds: 5,
      ));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        String uId = GetStorage().read("user_id");
        if (note != null) {
          SingleToneValue.instance.note = note;
        }
        Get.dialog(ProgressBar(), barrierDismissible: false);
        print(SingleToneValue.instance.addPackage);
        updateBooking(
          package: SingleToneValue.instance.addPackage,
          rName: "${SingleToneValue.instance.rName}",
          rEmail: "${SingleToneValue.instance.rEmail}",
          rAlPhoneNum: "${SingleToneValue.instance.rPhone}",
          pickupDate:
              "${SingleToneValue.instance.date} ${SingleToneValue.instance.time}",
          note: SingleToneValue.instance.note,
          UserId: uId,
          VehiclesTypeId: "${SingleToneValue.instance.vehicleId}",
          load_unload: SingleToneValue.instance.loadUnload,
          pickupId: "${SingleToneValue.instance.pickupAddressId}",
          deliveryId: "${SingleToneValue.instance.dropAddressId}",
          bookId: SingleToneValue.instance.orderId.toString(),
        );
      } else {
        //when no internet
        Get.snackbar("Error", "Please check your internet connection!",
            backgroundColor: MyColors.red500, colorText: MyColors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Please check your internet connection!",
          backgroundColor: MyColors.red500, colorText: MyColors.white);
    }
  }

  /// delete pkg
  deletePkg({
    required int index,
    required String bookingId,
    required String packageId,
    required String loadAmount,
  }) async {
    try {
      await _repository
          .deletePkgApiCall(bookingId, packageId, loadAmount)
          .then((value) {
        if (value.responseCode == '1') {
          SingleToneValue.instance.addPackage.removeAt(index);
          SingleToneValue.instance.packageIds.removeAt(index);
          SingleToneValue.instance.packagePrice.removeAt(index);
          if (value.response![0].packageIds!.length > 0) {
            SingleToneValue.instance.orderId = value.response![0].bookingId;
            SingleToneValue.instance.amount = value.response![0].total;
            SingleToneValue.instance.loadUnloadAmount = value.loadAmount!;
            SingleToneValue.instance.packageIds.clear();
            SingleToneValue.instance.packagePrice.clear();
            print("id length :${value.response![0].packageIds![0].id!.length}");
            print(
                "total length : ${value.response![0].packageIds![0].total!.length}");
            for (int i = 0;
                i < value.response![0].packageIds![0].id!.length;
                i++) {
              SingleToneValue.instance.packageIds
                  .add(value.response![0].packageIds![0].id![i]);
              print(
                  "Package ids after delete : ${SingleToneValue.instance.packageIds}");
            }
            for (int i = 0;
                i < value.response![0].packageIds![0].total!.length;
                i++) {
              SingleToneValue.instance.packagePrice
                  .add(value.response![0].packageIds![0].total![i]);
              print("Package Price : ${SingleToneValue.instance.packagePrice}");
            }
          } else {
            Get.offAll(HomePage);
          }
          Fluttertoast.showToast(
            msg: value.responseMessage.toString(), // message
            toastLength: Toast.LENGTH_LONG, // length
            gravity: ToastGravity.CENTER,
            backgroundColor: MyColors.green600,
            textColor: MyColors.white,
            // location// duration
          );
          update();
        } else {
          Fluttertoast.showToast(
            msg: value.errors.toString(), // message
            toastLength: Toast.LENGTH_LONG, // length
            gravity: ToastGravity.CENTER,
            backgroundColor: MyColors.red500,
            textColor: MyColors.white,
            // location// duration
          );
        }
      });
    } catch (e) {
      Get.snackbar(
        "Exception",
        e.toString().replaceAll('Exception:', ''),
        backgroundColor: MyColors.red500,
        colorText: MyColors.white,
      );
    }
  }

  /// delete pkg button
  deletePkgBtn(
      int index, String bookingId, String packageId, String loadAmount) async {
    try {
      Get.dialog(ProgressBar(), barrierDismissible: false);
      final result =
          await InternetAddress.lookup('google.com').timeout(Duration(
        seconds: 5,
      ));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print(SingleToneValue.instance.addPackage);
        if (SingleToneValue.instance.addPackage.length > 1) {
          deletePkg(
              bookingId: bookingId,
              packageId: packageId,
              index: index,
              loadAmount: loadAmount);
        } else {
          Get.defaultDialog(
              title: "Caution",
              middleText:
                  "Your data will be cleared in case you delete last package",
              titleStyle: Get.textTheme.subtitle2!.copyWith(
                  color: MyColors.red500, fontWeight: FontWeight.w500),
              onCancel: () {
                Get.back();
              },
              onConfirm: () {
                Get.offAll(HomePage());
              });
        }
      } else {
        Get.back();
        //when no internet
        Get.snackbar("Error", "Please check your internet connection!",
            backgroundColor: MyColors.red500, colorText: MyColors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Please check your internet connection!",
          backgroundColor: MyColors.red500, colorText: MyColors.white);
    }
  }

  /// apply coupon
  applyCoupon({
    required String name,
    required String BookingId,
  }) async {
    try {
      await _repository
          .applyCouponRepo(name: name, BookingId: BookingId)
          .then((value) {
        if (value.responseCode == '1') {
          SingleToneValue.instance.coupon =
              value.response![0].couponId.toString();
          SingleToneValue.instance.amount = value.response![0].total;
          SingleToneValue.instance.discount = value.response![0].discount!;
          couponController.clear();
          Fluttertoast.showToast(
            msg: value.responseMessage.toString(), // message
            toastLength: Toast.LENGTH_LONG, // length
            gravity: ToastGravity.CENTER,
            backgroundColor: MyColors.green600,
            textColor: MyColors.white,
            // location// duration
          );
          update();
        } else {
          Fluttertoast.showToast(
            backgroundColor: MyColors.red500,
            textColor: MyColors.white,
            msg: value.errors.toString(), // message
            gravity: ToastGravity.CENTER, // length
          );
        }
      });
    } catch (e) {
      Get.snackbar(
        "Exception",
        e.toString().replaceAll('Exception:', ''),
        backgroundColor: MyColors.red500,
        colorText: MyColors.white,
      );
    }
  }

  /// delete pkg button
  couponBtn() async {
    if (coupenFormkey.currentState!.validate()) {
      try {
        final result =
            await InternetAddress.lookup('google.com').timeout(Duration(
          seconds: 5,
        ));
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          Get.dialog(ProgressBar(), barrierDismissible: false);
          applyCoupon(
              name: couponController.text,
              BookingId: SingleToneValue.instance.orderId.toString());
        } else {
          //when no internet
          Get.snackbar("Error", "Please check your internet connection!",
              backgroundColor: MyColors.red500, colorText: MyColors.white);
        }
      } catch (e) {
        Get.snackbar("Error", "Please check your internet connection!",
            backgroundColor: MyColors.red500, colorText: MyColors.white);
      }
    }
  }

  /// show msg
  showError() {
    Fluttertoast.showToast(
      msg:
          "Weight must be greater than 0.4 and dimensions must be greater than 4 and worth can't be zero", // message
      toastLength: Toast.LENGTH_LONG, // length
      gravity: ToastGravity.CENTER,
      backgroundColor: MyColors.red500,
      textColor: MyColors.white,
      // location// duration
    );
  }

  List tipList = [
    Strings.rateOther,
    Strings.threeDollar,
    Strings.fiveDollar,
    Strings.tenDollar,
    Strings.other,
  ];
  List tipPrice = [
    "0",
    "3",
    "5",
    "10",
  ];

  addRating({
    required String rating,
    required String tip,
    required String bookingId,
  }) async {
    await _repository
        .addRatingRepo(rating: rating, tip: tip, bookingId: bookingId)
        .then((value) {
      if (value.responseCode == "1") {
        Fluttertoast.showToast(
          msg: value.responseMessage.toString(), // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.BOTTOM,
          backgroundColor: MyColors.green600,
          textColor: MyColors.white,
          // location// duration
        );
        SingleToneValue.instance.rating = "1";
        SingleToneValue.instance.tip = "";
        check = -1;
        tipController.clear();
        Get.offAll(() => HomePage());
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
        "Something Went Wrong",
        backgroundColor: MyColors.red500,
        colorText: MyColors.white,
      );
    });
  }

  int check = -1;
  RxBool textFeild = false.obs;

  onAddRatingButton() {
    Get.dialog(ProgressBar(), barrierDismissible: false);

    addRating(
        rating: SingleToneValue.instance.rating,
        tip: SingleToneValue.instance.tip.toString(),
        bookingId: SingleToneValue.instance.orderId.toString());
  }

  @override
  void onInit() {
    checkInternet();
    // TODO: implement onInit
    super.onInit();
  }
}
