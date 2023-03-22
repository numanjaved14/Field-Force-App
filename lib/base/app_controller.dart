import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:field_force_app/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppController extends BaseController {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  onApiError() {}

  @override
  onInternetUnavailable() {
    Get.snackbar(
      "Network Error",
      "Oh! Something went wrong..",
      icon: const Icon(Icons.wifi_off, color: Colors.black38),
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: false,
      backgroundColor: Colors.black12,
      duration: const Duration(days: 365),
      animationDuration: const Duration(milliseconds: 500)
    );
  }

  @override
  onNetworkUnavailable() {}

  @override
  onInternetAvailable() {
    if(Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
  }

  @override
  onRequestTimeout() {}

  Future<void> initNetworkConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
    if (_connectionStatus == ConnectivityResult.mobile ||
        _connectionStatus == ConnectivityResult.wifi) {
      onInternetAvailable();
    }
    if (_connectionStatus == ConnectivityResult.none) {
      onInternetUnavailable();
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
