import 'package:field_force_app/http_client/dio_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthRepository extends DioClient {
  final loginEndPoint = "Auth/Login";

  Future loginWithEmployeeIdAndPassword({
    @required String? employeeId,
    @required String? password,
  }) {
    var data = {
      "employeeId": employeeId ?? '',
      "currentPassword": password ?? '',
      "oldPassword": "",
      "newPassword": "",
      "token": "",
      "isLoginFromMobile": false,
      "mobileNumber": "",
      "isMobileNumFound": false
    };
    return post(loginEndPoint, data: data);
  }

  @override
  void onError(error) {
    Get.snackbar('Error Occured!', '$error');
  }

  @override
  void onRequestTimeout() {
    Get.snackbar('Error Occured!', 'Request Time Out');
  }

  @override
  void onResponseTimeout() {
    Get.snackbar('Error Occured!', 'Response Time Out');
  }
}
