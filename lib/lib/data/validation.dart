import 'package:get/get.dart';

class ValidationOfField {
  /// password validation
  String? passwordValidation(
    String value,
  ) {
    if (value.isEmpty) {
      return 'Enter Password';
    }
    return null;
  }

  ///email validation
  String? emailValidation(
    String value,
  ) {
    if (value.isEmpty) {
      return 'Enter the Email';
    } else if (GetUtils.isEmail(value)) {
      return null;
    } else if (!GetUtils.isEmail(value)) {
      return 'Enter the Valid Email';
    }
  }

  ///phone validation

  String? phoneNumber(
    String value,
  ) {
    if (value.isEmpty) {
      return 'Enter Phone Number';
    }
    if (value.length < 10) {
      return 'Enter valid Number';
    }
    return null;
  }

  ///first name validation

  String? nameValidation(
    String value,
  ) {
    if (value.isEmpty) {
      return 'Enter the first Name';
    }
    return null;
  }

  /// last name validation
  String? lastNameValidation(
    String value,
  ) {
    if (value.isEmpty) {
      return 'Enter the Last Name';
    }
    return null;
  }

  /// salone name validation
  String? salonName(
    String value,
  ) {
    if (value.isEmpty) {
      return 'Enter the salon name';
    }
    return null;
  }

  ///bio salon validation
  ///

  String? salonBio(
    String value,
  ) {
    if (value.isEmpty) {
      return 'Enter the detail of bio';
    }
    return null;
  }

  /// bank validation  bank name
  String? bankName(
    String value,
  ) {
    if (value.isEmpty) {
      return 'Enter the Bank Name';
    }
    return null;
  }

  /// bank tittle
  String? bankTitle(
    String value,
  ) {
    if (value.isEmpty) {
      return 'Enter the Bank title';
    }
    return null;
  }

  /// iban number
  String? IbanNumber(
    String value,
  ) {
    if (value.isEmpty) {
      return 'Enter IBAN Number';
    }
    return null;
  }

  ///booking per slot

  String? bookingSlot(
    String value,
  ) {
    if (value.isEmpty) {
      return 'Enter booking per slot';
    }
    return null;
  }

  ///service price
  String? servicePrice(
    String value,
  ) {
    if (value.isEmpty) {
      return 'Enter service price';
    }
    return null;
  }

  ///otp
  String? otpValue(
    String value,
  ) {
    if (value.isEmpty) {
      return 'Enter otp';
    }
    return null;
  }

  ///otp
  String? expiry(
    String value,
  ) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  ///otp
  String? speciality(
    String value,
  ) {
    if (value.isEmpty) {
      return 'Enter speciality';
    }
    return null;
  }

  ///card number
  String? cardNo(
    String value,
  ) {
    if (value.isEmpty && value.length < 16) {
      return 'Please enter your correct card no';
    }
    return null;
  }

  ///cvv
  String? cvv(
    String value,
  ) {
    if (value.isEmpty && value.length < 3) {
      return 'Enter correct cvv';
    }
    return null;
  }

  /// send parcel volume validation
}
