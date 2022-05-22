



import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:regexpattern/regexpattern.dart';

class Validation{

  static String? validEmail (String email){
    if(email.isEmpty){
      return  "EmailIsEmpty".tr();
    }
    else if (!email.isEmail()){
      return "InvalidEmailFormat".tr();
    }
    else {
      return null;
    }
  }


  static String? isValidPassword( String password) {
    if (password.isEmpty) {
   return "PasswordEmpty".tr();
    }
    else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,16}$')
        .hasMatch(password)) {
   return "InvalidPassword".tr();
    }
    else {
      return null;
    }
  }

  static String? isValidConfirmPassword(
      { required String password, required String confirmPassword}) {
    if (confirmPassword.isEmpty) {
      return "ConfirmPasswordEmpty".tr();
    }
    else if (password != confirmPassword) {
    return "PasswordNotMatch".tr();

    }
    else {
      return null;
    }
  }

  static String? validFirstName (String firstName){
    if(firstName.isEmpty){
      return  "FirstNameEmpty".tr();
    }
    else {
      return null;
    }
  }
  static String? validListName (String listName){
    if(listName.isEmpty){
      return  "LastNameEmpty".tr();
    }
    else {
      return null;
    }
  }

}