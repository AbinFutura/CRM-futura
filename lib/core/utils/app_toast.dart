import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToast {

  static void show(String message) {

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFF562B80),
      textColor: Colors.white,
      fontSize: 14,
    );

  }

}