import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class CommonMethods {
  static String version = '';
  static String appBadgeSupported = '';
  static int userId = 0, companyId = 0, userRoleId = 0;
  static String companyName = '', userRole = '';

  static void errorMsg(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  static void successMsg(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  void printLog(String text) {
    debugPrint('\x1B[33m$text\x1B[0m');
  }

  void printError(String text) {
    debugPrint('\x1B[31m$text\x1B[0m');
  }

  static dismissKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void moveCursorToLastPos(TextEditingController textField) {
    var cursorPos =
        TextSelection.fromPosition(TextPosition(offset: textField.text.length));
    textField.selection = cursorPos;
  }

  static bool validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  static bool validateUrl(String url) {
    String pattern = r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(url)) {
      return false;
    } else {
      return true;
    }
  }

  static bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]$)';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  static bool validatePassword(String value) {
    String pattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d#$@!%&*?]{8,20}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  static bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]{1,2})))$');

    return numericRegex.hasMatch(string);
  }

  static void inputFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static bool isAlphanumericRegularExpression(String string) {
    final pattern = RegExp(r'^[a-zA-Z0-9]+$');
    return pattern.hasMatch(string);
  }

  bool isConnect = false;

  static String dateFormatterTimes(String datetime) {
    var date = DateTime.parse(datetime == "" ? "yyyy-MM-dd HH:mm" : datetime);
    DateFormat df = DateFormat("yyyy-MM-d");
    return df.format(date).toLowerCase();
  }

  static callLoader(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  static void showToast(BuildContext context, String message, bool status) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: status ? Colors.green : Colors.red,
    ));
  }
}
