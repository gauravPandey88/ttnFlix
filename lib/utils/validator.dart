class Validator {
  static String? validateName({required String name}) {
    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }

    return null;
  }

  static String? validateEmail({required String email}) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  static String? emptyValidate({required String value, required String message}){
    if(value.isEmpty){
      return message;
    }
    return null;
  }

  static String? validatePassword({required String password}) {
    if (password.isEmpty) {
      return  "Password Is Required";
    } else if ((password.trim().length) < 8) {
      return "Password Is Short";
    }

    return null;
  }

  static String? isValidConfirmPassword({required String password, required String matchPassword}) {
    if (password.isEmpty) {
      return  "Password Is Required";
    } else if ((password.trim().length ?? 0) < 8) {
      return  "Password Is Short";
    } else if (password != matchPassword) {
      return "Password Mismatch";
    }
    return null;
  }
}
