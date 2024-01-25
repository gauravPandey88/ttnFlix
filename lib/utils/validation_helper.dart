
class ValidationHelper {
  static const ageValue = 18;

  static RegExp get nonSpecialCharStringRegExp => RegExp('[0-9a-z A-Z]');

  static bool isValidEmail(String email) => RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$',
  ).hasMatch(email);

  static bool isValidNumber(String licence) =>
      RegExp(r'^[0-9]+$').hasMatch(licence);

  static bool isPhoneNoValid(String? phoneNo) =>
      (phoneNo!.length >= 9 && phoneNo.length <= 20) ? true : false;

  static bool isPasswordValid(String? password) =>
      (password!.length >= 7 && password.length <= 20) ? true : false;

  static bool isAlphanumericWithSpace(String value) {
    return RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value);
  }

  static bool isValidAlphabetAndSpecialChars(String input) =>
      RegExp(r'^[a-zA-Z!@#\$%^&*()_+{}\[\]:;<>,.?~\\-]+$').hasMatch(input);

  static bool isValidAlphanumeric(String input) =>
      RegExp(r'^[a-zA-Z!@#\$%^&*()_+{}\[\]:;<>,.?~\\-]+$').hasMatch(input);

}