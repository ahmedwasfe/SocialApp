import 'package:flutter/material.dart';
import 'package:untitled1/ui/screens/login/login_screen.dart';
import 'package:untitled1/utils/components/components.dart';
import 'package:untitled1/utils/local/cache_helper.dart';

class Const {
  static final String KEY_DARK_MODE = 'dark_mode';
  static final String KEY_BOARDING = 'boarding';
  static final String KEY_USER_TOKEN = 'user_token';
  static final String KEY_USER_NAME = 'user_name';
  static final String USD = '\$';
  static final String KEY_USER = "user";

  // Firebase
  static final String COLLECTION_USERS = "Users";
}

class Helper {
  static String getCurrenToken() {
    return CacheHelper.getData(key: Const.KEY_USER_TOKEN);
  }

  static String getCurrentUserId(){
    return CacheHelper.getData(key: Const.KEY_USER);
  }

  static RegExp emailValidate() {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  }

  static void signOut(context) {
    CacheHelper.removeData(key: Const.KEY_USER_TOKEN).then((value) {
      if (value) navigateAndFinish(context, LoginScreen());
    });
  }

  static void printFullText(String text) {
    // 800 is the size of each chunk
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((element) => print(element.group(0)));
  }

  static ColorFilter greyScale() {
    return ColorFilter.matrix(<double>[
      /// greyscale filter
      0.2126, 0.7152, 0.0722, 0, 0,
      0.2126, 0.7152, 0.0722, 0, 0,
      0.2126, 0.7152, 0.0722, 0, 0,
      0, 0, 0, 1, 0
    ]);
  }
}
