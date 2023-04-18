import 'package:flutter/material.dart';

bool isEmailValid(String email) {
  return RegExp(
          r'^[\w.%+-]+@\w+\.\w{2,}(?:\s)$')
      .hasMatch(email);
}

bool isPasswordValid(String password) {
  return RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
      .hasMatch(password);
}


void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );
