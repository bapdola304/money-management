import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToastification(String message, String type, BuildContext context) {
  toastification.show(
      context: context,
      title: Text(
        message,
        style: TextStyle(fontSize: 14),
      ),
      type: getToastificationType(type),
      autoCloseDuration: const Duration(seconds: 5),
      closeButtonShowType: CloseButtonShowType.none,
      style: ToastificationStyle.flatColored,
      borderRadius: BorderRadius.circular(50),
      closeOnClick: true,
      animationDuration: const Duration(milliseconds: 100),
      showProgressBar: false);
}

ToastificationType getToastificationType(String type) {
  switch (type) {
    case 'success':
      return ToastificationType.success;
    case 'error':
      return ToastificationType.error;
    case 'warning':
      return ToastificationType.warning;
    case 'info':
      return ToastificationType.info;
    default:
      return ToastificationType.info;
  }
}
