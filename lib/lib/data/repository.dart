import 'package:antrakuserinc/data/api/add_package_api.dart';
import 'package:antrakuserinc/data/api/address_api.dart';
import 'package:antrakuserinc/data/api/auth_api.dart';
import 'package:antrakuserinc/data/api/order_history_api.dart';
import 'package:antrakuserinc/data/api/payment_api.dart';
import 'package:antrakuserinc/data/api/profile_api.dart';
import 'package:antrakuserinc/data/model/RestricktedItemModel/RestrictedItemModel.dart';
import 'package:antrakuserinc/data/model/add_booking_model/add_booking_model.dart';
import 'package:antrakuserinc/data/model/add_card_for_payment_modal/add_card_for_payment_modal.dart';

import 'package:antrakuserinc/data/model/add_user_card_modal/add_user_card_modal.dart';
import 'package:antrakuserinc/data/model/address_api_modals/delete_address.dart';
import 'package:antrakuserinc/data/model/address_api_modals/get_address.dart';
import 'package:antrakuserinc/data/model/api_models/forgot_password_model/forgot_password_model.dart';
import 'package:antrakuserinc/data/model/apply_coupon_model/apply_coupon_model.dart';
import 'package:antrakuserinc/data/model/cancel_booking_model/cancel_booking_model.dart';
import 'package:antrakuserinc/data/model/cancel_reasons_model/cancel_reasons_model.dart';
import 'package:antrakuserinc/data/model/category_model/category_model.dart';
import 'package:antrakuserinc/data/model/change_modal/change_modal.dart';
import 'package:antrakuserinc/data/model/delete_pkg_model/delete_pkg_model.dart';
import 'package:antrakuserinc/data/model/driver_details_modal/driver_details_modal.dart';
import 'package:antrakuserinc/data/model/get_all_order_model/get_all_order_model.dart';
import 'package:antrakuserinc/data/model/get_user_cards/get_user_card_modal.dart';
import 'package:antrakuserinc/data/model/get_user_model/get_user_modal.dart';
import 'package:antrakuserinc/data/model/get_vehicle_model/get_vehicle_model.dart';
import 'package:antrakuserinc/data/model/homepage_model/homepage_model.dart';
import 'package:antrakuserinc/data/model/logout_modal/logout_modal.dart';
import 'package:antrakuserinc/data/model/order_detail_model/order_detail_model.dart';
import 'package:antrakuserinc/data/model/session_modal/session_modal.dart';
import 'package:antrakuserinc/data/model/signup_modal/signup_modal.dart';
import 'package:antrakuserinc/data/model/signup_modal/verify_email_modal.dart';
import 'package:antrakuserinc/data/closable.dart';
import 'package:antrakuserinc/data/model/track_order_model/track_order_model.dart';
import 'package:antrakuserinc/data/model/update_user_modal/update_user_modal.dart';
import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_db_client.dart';
import 'maps_clients.dart';
import 'model/add_rating_modal/add_rating_modal.dart';
import 'model/address_api_modals/add_address.dart';
import 'model/map_search_models/id_to_latlng/id_to_latlng.dart';
import 'model/map_search_models/map_autocomplete_model/map_auto_complete_model.dart';
import 'model/useragreementModal/useragreement_modal.dart';

class Repository implements Closable {
  final _authClient = AuthProvider();
  final _profileClient = ProfileProvider();
  final _paymentClient = PaymentProvider();
  final _orderHistory = OrderHistoryProvider();

  final _addressApi = AddressProvider();
  final _mapClient = MapClient();
  final _authApi = AuthProvider();
  final _addPackageApi = AddPackageProvider();

  final _firebaseDbClient = FirebaseDbClient();

  ///signup user

  Future<SignUpModal> signupUserRepo({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String dvToken,
    required String countryCode,
    required String gKey,
  }) async {
    return await _authClient.signupUser(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phone: phone,
        dvToken: dvToken,
        countryCode: countryCode,
        gKey: gKey);
  }

  /// verify user email

  Future<VerifyEmailModal> verifyUserEmail({
    required String userID,
    required String otp,
  }) async {
    return await _authClient.verifySignupEmailApi(userID: userID, otp: otp);
  }

  /// get places of lat lng get places

  Future<IdtoLatLong> getPlacesLatLong(String str) async {
    final response = await _mapClient.getPlacesLatLong(
      str,
    );
    return response;
  }

  ///search map api on google map used is Google places api used

  Future<AutoComplete> getPlaces(
    String str, {
    String? key,
    String? language,
    bool refresh = false,
  }) async =>
      await _mapClient.getPlaces(str, key: key, language: language);

  /// login api call
  Future<SignUpModal> login({
    required String email,
    required String password,
  }) async {
    return await _authApi.loginApi(
      email: email,
      password: password,
    );
  }

  Future<UserAgreementModal> userAgreementRepo() async {
    return _authApi.userAgreement();
  }

  /// google sign in api call
  Future<SignUpModal> socialAuth(String email) async {
    return await _authApi.socialAuthApi(email: email);
  }

  /// forgot password api call
  Future<ForgotPasswordModel> forgotPassword(String email) async {
    return await _authApi.forgotPassApi(email: email);
  }

  /// reset password
  Future<SignUpModal> resetApiCall({
    required String uId,
    required String requestId,
    required String password,
    required String otp,
  }) async {
    return await _authApi.changeForgotPassApi(
        userId: uId, forgetRequestId: requestId, password: password, OTP: otp);
  }

  ///change password repo
  Future<ChangePasswordModal> changePaswordRepo({
    required String old_password,
    required String new_password,
  }) async {
    return await _authClient.changePassword(
        old_password: old_password, new_password: new_password);
  }

  ///otp resend api
  Future<SignUpModal> otpResendRepo({
    required String email,
  }) async {
    return await _authClient.otpResendAPi(email: email);
  }

  ///session check
  Future<SessionModal> sessionCheck({
    required String id,
  }) async {
    return await _authClient.sessionCheck(id: id);
  }

  ///logout repo
  Future<LogoutModal> logoutRepo() async {
    return await _authClient.logoutApi();
  }

  ///add address repo
  Future<AddAddressModal> addAddressRepo({
    required String title,
    required String building,
    required String aptNum,
    required String state,
    required String city,
    required String zip,
    required String phone,
    required String phoneCode,
    required String user_id,
    required String lat,
    required String lng,
    required String address,
  }) async {
    return await _addressApi.addAddressApi(
      title: title,
      aptNum: aptNum,
      building: building,
      state: state,
      city: city,
      phoneCode: phoneCode,
      zip: zip,
      phone: phone,
      user_id: user_id,
      lat: lat,
      lng: lng,
      address: address,
    );
  }

  ///get addresses repo

  Future<GetAddressModal> getAddressRepo() async {
    return await _addressApi.getAddressApi();
  }

  ///delete address repo

  Future<DeleteAddressModal> deleteAddressRepo({
    required int ID,
  }) async {
    return await _addressApi.deleteAddressApi(ID: ID);
  }

  /// category APi call
  Future<CategoryModel> getCategory() {
    return _addPackageApi.categoryApi();
  }

  /// get vehicle APi call
  Future<GetVehicleModel> getVehicle(
    List<Map<String, dynamic>> package,
  ) {
    return _addPackageApi.getVehicleApi(
      package: package,
    );
  }

  ///get user repo
  Future<GetUserModal> getUserRepo() async {
    return await _profileClient.getUserApi();
  }

  ///update user repo
  Future<UpdateUserModal> updateUserRepo({
    required String fName,
    required String lName,
    required String cCode,
    required String phone,
  }) async {
    return await _profileClient.updateUserApi(
        fName: fName, lName: lName, cCode: cCode, phone: phone);
  }

  ///get user card list

  Future<GetUserCardsModal> getUserCardRepo() async {
    return await _paymentClient.getUserCardsApi();
  }

  /// add card user

  Future<AddUserCardsModal> addCardRepo({
    required String cardNum,
    required String month,
    required String year,
    required String cvv,
  }) async {
    return await _paymentClient.addCardApi(
        cardNum: cardNum, month: month, year: year, cvv: cvv);
  }

  /// add card for payment

  Future<AddCardForPaymentModal> addCardForPaymentRepo({
    required String cardNum,
    required String month,
    required String year,
    required String cvv,
    required String bID,
    required String cID,
    required bool status,
  }) async {
    return await _paymentClient.addCardForPaymentApi(
        cardNum: cardNum,
        month: month,
        year: year,
        cvv: cvv,
        cID: cID,
        bID: bID,
        status: status);
  }

  /// add booking api call
  Future<AddBookingModel> addBookingApiCall(
    List<Map<String, dynamic>> package,
    String rName,
    String rEmail,
    String rAlPhoneNum,
    String pickupDate,
    String note,
    String UserId,
    String VehiclesTypeId,
    bool load_unload,
    String pickupId,
    String deliveryId,
  ) async {
    return await _addPackageApi.addBookingApi(
        package: package,
        rName: rName,
        rEmail: rEmail,
        rAlPhoneNum: rAlPhoneNum,
        pickupDate: pickupDate,
        note: note,
        UserId: UserId,
        VehiclesTypeId: VehiclesTypeId,
        load_unload: load_unload,
        pickupId: pickupId,
        deliveryId: deliveryId);
  }

  /// update booking api call
  Future<AddBookingModel> updateBookingApiCall(
    List<Map<String, dynamic>> package,
    String rName,
    String rEmail,
    String rAlPhoneNum,
    String pickupDate,
    String note,
    String UserId,
    String VehiclesTypeId,
    bool load_unload,
    String pickupId,
    String deliveryId,
    String bookId,
  ) async {
    return await _addPackageApi.updateBookingApi(
      package: package,
      rName: rName,
      rEmail: rEmail,
      rAlPhoneNum: rAlPhoneNum,
      pickupDate: pickupDate,
      note: note,
      UserId: UserId,
      VehiclesTypeId: VehiclesTypeId,
      load_unload: load_unload,
      pickupId: pickupId,
      deliveryId: deliveryId,
      bookId: bookId,
    );
  }

  ///add rating

  Future<AddRatingModal> addRatingRepo({
    required String rating,
    required String tip,
    required String bookingId,
  }) async {
    return await _addPackageApi.addRatingApi(
        rating: rating, tip: tip, bookingId: bookingId);
  }

  /// delete pkg api call
  Future<DeletePackageModal> deletePkgApiCall(
    String bookingId,
    String packageId,
    String loadAmount,
  ) async {
    return await _addPackageApi.deletePkgApi(
        bookingId: bookingId, loadAmount: loadAmount, packageId: packageId);
  }

  ///get order History
  Future<GetAllOrderModel> getOrderHistoryRepo(
      {required String from, required String to}) async {
    return await _orderHistory.orderHistoryApi(from: from, to: to);
  }

  ///get order History
  Future<OrderDetailModel> orderDetailRepo({
    required String bookId,
  }) async {
    return await _orderHistory.orderDetailApi(bookId: bookId);
  }

  ///delete card

  Future<AddCardForPaymentModal> deleteCardRepo({
    required String pmID,
  }) async {
    return await _paymentClient.deleteCardApi(pmID: pmID);
  }

  ///payment by saved card
  Future<AddCardForPaymentModal> paymentBySavedCardsRepo({
    required String bID,
    required String pmID,
    required String cID,
  }) async {
    return await _paymentClient.paymentBySavedCardApi(
        bID: bID, pmID: pmID, cID: cID);
  }

  /// get home data
  Future<HomePageModel> getHomeSpi() async {
    return await _profileClient.getHomeApi();
  }

  /// order tracking
  Future<OrderTrackingModel> orderTrackingRepo({
    required String bookingId,
  }) async {
    return await _orderHistory.orderTrackingApi(bookingId: bookingId);
  }

  /// driver details
  Future<DriverDetailsModal> driverDetailsRepo({
    required String bID,
  }) async {
    return await _profileClient.driverDetailsApi(bID: bID);
  }

  /// apply coupon api call
  Future<ApplyCouponModel> applyCouponRepo({
    required String name,
    required String BookingId,
  }) async {
    return await _addPackageApi.applyCouponAPi(
        name: name, BookingId: BookingId);
  }

  /// cancel booking api call
  Future<CancelBookingModel> cancelBookingApi({
    required String bookingId,
    required String UserId,
    required String note,
    required String reason,
  }) async {
    return await _addPackageApi.cancelBookingApi(
        bookingId: bookingId, UserId: UserId, note: note, reason: reason);
  }

  /// get cancel reason
  Future<CancelReasonsModel> getCancelReasons() async {
    return await _addPackageApi.getReasonApi();
  }

  /// get Restricted items
  Future<RestricktedItemModel> getRestricted() async {
    return await _addPackageApi.getRestrictedApi();
  }

  sendMessage(String msg) async {
    var user = GetStorage().read('name');
    await _addPackageApi.sendMessage(
        message: msg,
        name: user,
        receiverToken: SingleToneValue.instance.driverDv!,
        orderID: SingleToneValue.instance.orderId.toString(),
        myName: user,
        myDvToken: SingleToneValue.instance.dvToken.toString(),
        myID: GetStorage().read("user_id"));

    print("$user, ${SingleToneValue.instance.driverDv!}");
  }

  @override
  void close() {}
}
