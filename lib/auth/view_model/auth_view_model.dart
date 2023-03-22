import 'package:field_force_app/base/app_model.dart';
import 'package:field_force_app/constants/shared_pref_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../base/app_controller.dart';
import '../../base/models/auth_model.dart';
import '../../home/view/home.dart';
import '../repository/auth_repository.dart';

class AuthViewModel extends AppController {
  final authRepo = AuthRepository();

  var showProgress = false.obs;

  onLoginPressed({required String emyployeeId, required String pass}) async {
    if (emyployeeId.isNotEmpty && pass.isNotEmpty) {
      showProgress.value = true;
      var result = await authRepo.loginWithEmployeeIdAndPassword(
        employeeId: emyployeeId,
        password: pass,
      );
      var response = AppModel.fromJson(result.data);
      AuthModel res = AuthModel.fromJson(result.data);
      if (response.status == true) {
        showProgress.value = false;
        print('This is res: ${res.result![0].user!.firstName}');
        SharedPreferences _sharedPref = await SharedPreferences.getInstance();
        _sharedPref.setString(
            SharedPrefStrings().firstName, res.result![0].user!.firstName!);
        _sharedPref.setString(
            SharedPrefStrings().designation, res.result![0].user!.designation!);
        _sharedPref.setString(
            SharedPrefStrings().accessToken, res.result![0].accessToken!);
        _sharedPref.setString(
            SharedPrefStrings().empID, res.result![0].user!.id.toString());
        _sharedPref.setString(SharedPrefStrings().refreshToken,
            res.result![0].refreshToken!.tokenString.toString());
        Get.off(Home());
      } else if (response.status == false) {
        showProgress.value = false;
        Get.defaultDialog(
            title: "Oops!", middleText: response.message, radius: 30);
      } else {
        showProgress.value = false;
        Get.defaultDialog(
            title: "Oops!",
            middleText: 'Something went wrong please try again later.',
            radius: 30);
      }
    } else {
      Get.snackbar(
        "Input All Fields!",
        "Please input all fields correctly!",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
      );
    }
  }
}
