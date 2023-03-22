import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySnackBar {
  final String title;
  final String subtitle;

  MySnackBar({
    required this.title,
    required this.subtitle,
  });

  getSnackbar() {
    return Get.snackbar(
      title,
      subtitle,
      mainButton: TextButton(
        onPressed: () {
          Get.closeCurrentSnackbar();
        },
        child: const Text(
          '❌',
        ),
      ),
      duration: const Duration(seconds: 10),
      barBlur: 30,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
