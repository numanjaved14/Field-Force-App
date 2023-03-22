import 'package:field_force_app/base/models/permission_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/shared_pref_strings.dart';
import '../repository/permission_list_repository.dart';

class PermissionListController extends GetxController {
  RxBool isInit = false.obs;
  RxBool hasData = false.obs;
  RxBool hasError = false.obs;
  RxBool isSearch = false.obs;

  Rx<TextEditingController> searchController = TextEditingController().obs;

  FocusNode searchFocus = FocusNode();

  final permissionListRepository = PermissionListRepository();

  Rx<List<Result>?> permissionList = Rx<List<Result>?>([]);

  Rx<List<String>> permissionsList = Rx<List<String>>([]);

  Rx<List<Result>?> orgList = Rx<List<Result>?>([]);

  @override
  void onInit() {
    super.onInit();
    getPermissionList();
    initMethod();
  }

  initMethod() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    permissionsList.value.addAll(sharedPref
        .getStringList(SharedPrefStrings().permissionList) as List<String>);

    print('This is init: ..${permissionsList.value.length}');
    isInit.value = true;
  }

  getPermissionList() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result = await permissionListRepository.getPermissionList();
      PermissionListModel res = PermissionListModel.fromJson(result.data);
      if (res.status == true) {
        // print('This is res: ${res.result![0].name}');
        permissionList.value = res.result;
        permissionList.value!.sort(
          (a, b) => b.id!.compareTo(a.id!),
        );
        orgList.value = permissionList.value;
        hasData.value = true;
        print('This is res: ${permissionList.value!.length}');
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }

  onSearchChange() {
    Rx<List<Result>?> result = Rx<List<Result>?>([]);
    if (searchController.value.text.isEmpty) {
      permissionList.value = orgList.value;
    } else {
      result.value = permissionList.value!
          .where(
            (u) => u.name!.toLowerCase().contains(
                  searchController.value.text.toLowerCase(),
                ),
          )
          .toList();
      print(result.value);
      permissionList.value = result.value;
    }
  }

  resetSearch() {
    searchController.value.clear();
    searchFocus.unfocus();
    isSearch.value = false;
    permissionList.value = orgList.value;
  }
}
