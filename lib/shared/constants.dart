import 'package:flutter/material.dart';
import 'package:matgry/data/local/cache_helper.dart';
import 'package:matgry/presentation/screens/login/shop_login_screen.dart';

String? token;

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (Route<dynamic> route) => false,
    );

void signOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value)
  {
    if(value)
    {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}