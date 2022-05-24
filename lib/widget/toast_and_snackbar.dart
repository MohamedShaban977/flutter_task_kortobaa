import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastAndSnackBar {
  static toastError({required String message}) {
    return Fluttertoast.showToast(
      msg: message,
      fontSize: 18,
      backgroundColor: Colors.redAccent,
      gravity: ToastGravity.SNACKBAR,
      textColor: Colors.white,
      timeInSecForIosWeb: 10,
    );
  }

  static toastSuccess({required String message}) {
    return Fluttertoast.showToast(
      msg: message,
      fontSize: 18,
      backgroundColor: Colors.green,
      gravity: ToastGravity.SNACKBAR,
      textColor: Colors.white,
      timeInSecForIosWeb: 5,
    );
  }

  static showSnackBarError(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ),
    );
  }

// static showFlushBarIsValid(context, {String? title, required String message}) {
//   return Flushbar(
//     margin: const EdgeInsets.all(20),
//     borderRadius: BorderRadius.circular(20),
//     titleText: Text(
//       title??'',
//       style: const TextStyle(fontFamily: fontFamily, color: MyColors.colorWhite),
//     ),
//     messageText: Text(
//       message,
//       style: TextStyle(fontFamily: fontFamily, color: MyColors.colorWhite),
//     ),
//     duration: Duration(seconds: 5),
//     // onTap: ,
//     isDismissible: false,
//     backgroundColor: Colors.red,
//     flushbarPosition: FlushbarPosition.TOP,
//     boxShadows: [
//       BoxShadow(
//         color: Colors.red[800]!,
//         offset: Offset(0.0, 2.0),
//         blurRadius: 3.0,
//       )
//     ],
//   )..show(context);
// }
//
// static showFlushBarIsSuccess(context, {String? title, String? message}) {
//   return Flushbar(
//     margin: EdgeInsets.all(20),
//     borderRadius: BorderRadius.circular(20),
//     title: title,
//     message: message,
//     duration: Duration(seconds: 5),
//     // onTap: ,
//     isDismissible: false,
//     backgroundColor: Colors.green,
//     flushbarPosition: FlushbarPosition.TOP,
//     boxShadows: [
//       BoxShadow(
//         color: Colors.green[800]!,
//         offset: Offset(0.0, 2.0),
//         blurRadius: 3.0,
//       )
//     ],
//   )..show(context);
// }
//
// static showFlushBarByNotification(context,
//     {String? title, String? message, Function? onTap}) {
//   return Flushbar(
//     margin: EdgeInsets.all(20),
//     borderRadius: BorderRadius.circular(20),
//     title: title,
//     message: message,
//     titleColor: Theme.of(context).focusColor,
//     messageColor: Theme.of(context).focusColor,
//     // duration: Duration(seconds: 5),
//     onTap: onTap as void Function(Flushbar<dynamic>)?,
//     isDismissible: true,
//     backgroundColor: Theme.of(context).primaryColor,
//     flushbarPosition: FlushbarPosition.TOP,
//
//     // boxShadows: [BoxShadow(color: Colors.red[800], offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
//   )..show(context);
// }
}
