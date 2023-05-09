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


bool isWriteInEnglishValid(String password) {
  return RegExp(
      r'^[a-zA-Z0-9_@.\s-]+$')
      .hasMatch(password);
}

bool isWriteInArabicValid(String password) {
  return RegExp(
      r'^[\u0600-\u06FF0-9_@.\s-]+$')
      .hasMatch(password);
}


void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );
