import 'package:flutter/material.dart';

import 'shared_preference_utils.dart';

class AppUtils {
  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  static bool isNavigateToFeed() {
    if (SharedPrefUtil.instance.getIsRemember() && SharedPrefUtil.instance.getBearerToken() != "") {
      return true;
    } else {
      return false;
    }
  }
}
