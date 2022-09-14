import 'package:antrakuserinc/data/model/change_modal/change_modal.dart';
import 'package:antrakuserinc/data/model/logout_modal/logout_modal.dart';
import 'package:antrakuserinc/data/model/session_modal/session_modal.dart';
import 'package:antrakuserinc/data/model/api_models/forgot_password_model/forgot_password_model.dart';
import 'package:antrakuserinc/data/model/signup_modal/signup_modal.dart';
import 'package:antrakuserinc/data/model/signup_modal/verify_email_modal.dart';
import 'package:antrakuserinc/data/singleton/singleton.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';
import '../model/api_models/forgot_password_model/forgot_password_model.dart';
import '../model/useragreementModal/useragreement_modal.dart';

class AuthProvider extends GetConnect {
  static const String _name = "name";
  static const String _bearer_token = "bearer_token";

  /// login
  Future<dynamic> loginApi({
    required String email,
    required String password,
  }) async {
    httpClient.timeout = Duration(seconds: 100);
    final response = await post(
      "${Constants.baseUrl}users/login",
      {
        "email": email,
        "password": password,
        "deviceToken": SingleToneValue.instance.dvToken!
      },
    ).whenComplete(() => Get.back());
    if (response.statusCode == 200) {
      SignUpModal loginModal = SignUpModal.fromJson(response.body);
      if (loginModal.responseCode == '1') {
        GetStorage().write("name", loginModal.response![0].firstName!);
        GetStorage().write("last_name", loginModal.response![0].lastName!);
        GetStorage().write("user_id", loginModal.response![0].userId!);
        GetStorage().write("bearer_token", loginModal.response![0].accessToken);
        print("access token:  ${GetStorage().read("bearer_token")}    end");
        print("value $loginModal");
        return loginModal;
      } else {
        return loginModal;
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  Future<UserAgreementModal> userAgreement() async {
    final response =
        await httpClient.get("${Constants.baseUrl}users/agreement");

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      UserAgreementModal model = UserAgreementModal.fromJson(response.body);
      return model;
    }
  }

  /// google sign in api
  Future<dynamic> socialAuthApi({
    required String email,
  }) async {
    httpClient.timeout = Duration(seconds: 100);

    final response = await post(
      "${Constants.baseUrl}users/googlesignin",
      {"email": email, 'deviceToken': SingleToneValue.instance.dvToken},
    ).whenComplete(() => Get.back());
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      SignUpModal loginModal = SignUpModal.fromJson(response.body);
      print("value $loginModal");
      if (loginModal.responseCode == '1') {
        GetStorage().write(_name, loginModal.response![0].firstName!);
        GetStorage().write("last_name", loginModal.response![0].lastName!);
        GetStorage().write("user_id", loginModal.response![0].userId!);
        GetStorage().write("bearer_token", loginModal.response![0].accessToken);
        print("access token:  ${GetStorage().read(_bearer_token)}    end");
      }

      return loginModal;
    }
  }

  ///user sign up
  Future<SignUpModal> signupUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String dvToken,
    required String countryCode,
    required String gKey,
  }) async {
    SignUpModal? model;
    httpClient.timeout = Duration(seconds: 100);
    try {
      var response = await post("${Constants.baseUrl}users/register", {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "phoneNum": phone,
        "deviceToken": dvToken,
        "gkey": gKey,
        "countryCode": countryCode,
      }, headers: {
        'Accept': 'application/json',
      }).whenComplete(() => Get.back());
      if (response.hasError) {
        return Future.error(response.statusText!);
      } else {
        model = SignUpModal.fromJson(response.body);
        return model;
      }
    } catch (e) {
      throw Exception(model!.errors!);
    }
  }

  ///verify email api
  Future<VerifyEmailModal> verifySignupEmailApi({
    required String userID,
    required String otp,
  }) async {
    httpClient.timeout = Duration(seconds: 100);
    var response = await post("${Constants.baseUrl}users/vemail", {
      "userId": userID,
      "OTP": otp,
    }, headers: {
      'Accept': 'application/json',
    }).whenComplete(() => Get.back());

    if (response.statusCode == 200) {
      VerifyEmailModal model = VerifyEmailModal.fromJson(response.body);
      if (model.responseCode == "1") {
        GetStorage().write(_name, model.response![0].firstName!);
        GetStorage().write("last_name", model.response![0].lastName!);
        GetStorage().write("user_id", model.response![0].userId!);
        GetStorage().write("bearer_token", model.response![0].accessToken);
        return model;
      }
      return model;
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// forgot password
  Future<dynamic> forgotPassApi({
    required String email,
  }) async {
    httpClient.timeout = Duration(seconds: 100);
    final response = await post(
      "${Constants.baseUrl}users/femail",
      {
        "email": email,
      },
    ).whenComplete(() => Get.back());
    if (response.statusCode == 200) {
      ForgotPasswordModel forgotPasswordModel =
          ForgotPasswordModel.fromJson(response.body);
      print("value $forgotPasswordModel");
      return forgotPasswordModel;
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// change forgot api
  Future<dynamic> changeForgotPassApi({
    required String userId,
    required String forgetRequestId,
    required String password,
    required String OTP,
  }) async {
    httpClient.timeout = Duration(seconds: 100);
    final response = await post(
      "${Constants.baseUrl}users/femail/verify",
      {
        "userId": userId,
        "forgetRequestId": forgetRequestId,
        "password": password,
        "OTP": OTP
      },
    ).whenComplete(() => Get.back());
    if (response.statusCode == 200) {
      SignUpModal resetPasswordModel = SignUpModal.fromJson(response.body);
      return resetPasswordModel;
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// change password api
  Future<ChangePasswordModal> changePassword({
    required String old_password,
    required String new_password,
  }) async {
    ChangePasswordModal? model;
    httpClient.timeout = Duration(seconds: 100);
    var response = await put("${Constants.baseUrl}users/updatepassword", {
      "oldPassword": old_password,
      "newPassword": new_password,
    }, headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    }).whenComplete(() => Get.back());
    if (response.statusCode == 200) {
      model = ChangePasswordModal.fromJson(response.body);
      if (model.responseCode == "1") {
        return model;
      } else {
        return onApiError(model.errors!);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  /// otp resend api
  Future<dynamic> otpResendAPi({
    required String email,
  }) async {
    httpClient.timeout = Duration(seconds: 100);
    final response = await post(
      "${Constants.baseUrl}users/resendotp",
      {
        "email": email,
      },
    ).whenComplete(() => Get.back());
    if (response.statusCode == 200) {
      SignUpModal resetPasswordModel = SignUpModal.fromJson(response.body);
      return resetPasswordModel;
    } else {
      return Future.error(response.statusText!);
    }
  }

  ///session check
  Future<SessionModal> sessionCheck({
    required String id,
  }) async {
    SessionModal? model;
    httpClient.timeout = Duration(seconds: 100);

    var response = await post("${Constants.baseUrl}users/session", {
      "id": id,
    }, headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    });
    if (response.statusCode == 200) {
      model = SessionModal.fromJson(response.body);
      GetStorage().write("name", model.response![0].firstName!);
      GetStorage().write("last_name", model.response![0].lastName!);
      // GetStorage().write("user_id", model.response![0].userId!);
      // GetStorage().write("bearer_token", model.response![0].accessToken);
      return model;
    } else {
      return Future.error(response.statusText!);
    }
  }

  ///logout api
  Future<LogoutModal> logoutApi() async {
    LogoutModal? model;
    httpClient.timeout = Duration(seconds: 100);
    var response = await get("${Constants.baseUrl}users/logout", headers: {
      'Accept': 'application/json',
      'accessToken': '${GetStorage().read("bearer_token")}',
    }).whenComplete(() => Get.back());
    if (response.statusCode == 200) {
      model = LogoutModal.fromJson(response.body);
      if (model.responseCode == "1") {
        return model;
      } else {
        return onApiError(model.errors!);
      }
    } else {
      return Future.error(response.statusText!);
    }
  }

  onApiError(String errors) {
    Get.snackbar(
      "Error",
      errors,
      backgroundColor: MyColors.red500,
      colorText: MyColors.white,
    );
  }
}
