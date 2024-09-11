


import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../res/colors/app_color.dart';

class Utils {


  static void fieldFocusChange(BuildContext context , FocusNode current , FocusNode  nextFocus ){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }


  static toastMessage(String message){
    Fluttertoast.showToast(
      msg: message ,
      backgroundColor: AppColor.primaryColor ,
      textColor: AppColor.whiteColor,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,


    );
  }


  static toastMessageCenter(String message){
    Fluttertoast.showToast(
      msg: message ,
      backgroundColor: AppColor.primaryColor ,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      textColor: AppColor.whiteColor,
    );
  }

  // static snackBar(String title, String message){
  //   Get.snackbar(
  //     title,
  //     message ,
  //   );
  // }

  static snackBar(String title, String message) {
    if (message == null || message.isEmpty) {
      message = 'An unknown error occurred';
    }
    Get.snackbar(
      title ?? 'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }


  // Static method to format dates
  static String formatDate(String date) {
    try {
      // Attempt to parse the date, assuming the input might not be in YYYY-MM-DD format
      final parsedDate = DateFormat('dd-MM-yyyy').parse(date, true);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      // Return an empty string or handle the error as needed
      return '';
    }
  }

}