import 'package:field_force_app/base/models/designation_model.dart';
import 'package:field_force_app/manage/designation/designation_list/repository/designation_list_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/shared_pref_strings.dart';

class DesignationListController extends GetxController {
  RxBool isInit = false.obs;
  RxBool hasData = false.obs;
  RxBool hasError = false.obs;
  RxBool isSearch = false.obs;

  Rx<TextEditingController> searchController = TextEditingController().obs;

  FocusNode searchFocus = FocusNode();

  final designationListRepository = DesignationListRepository();

  Rx<List<Result>?> desList = Rx<List<Result>?>([]);

  Rx<List<String>> permissionsList = Rx<List<String>>([]);

  Rx<List<Result>?> orgList = Rx<List<Result>?>([]);

  @override
  void onInit() {
    super.onInit();
    getPermissionInit();
    initMethod();
  }

  initMethod() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    permissionsList.value.addAll(sharedPref
        .getStringList(SharedPrefStrings().permissionList) as List<String>);

    print('This is init: ..${permissionsList.value.length}');
    isInit.value = true;
  }

  getPermissionInit() async {
    hasData.value = false;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result = await designationListRepository.getDesignationList();
      DesignationModel res = DesignationModel.fromJson(result.data);
      if (res.status == true) {
        print('This is res: ${res.result![0].name}');
        desList.value = res.result;
        desList.value!.sort(
          (a, b) => b.id!.compareTo(a.id!),
        );
        orgList.value = desList.value;
        hasData.value = true;
        print('This is res: ${desList.value!.length}');
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
      desList.value = orgList.value;
    } else {
      result.value = desList.value!
          .where(
            (u) => u.name!.toLowerCase().contains(
                  searchController.value.text.toLowerCase(),
                ),
          )
          .toList();
      print(result.value);
      desList.value = result.value;
    }
  }

  resetSearch() {
    searchController.value.clear();
    searchFocus.unfocus();
    isSearch.value = false;
    desList.value = orgList.value;
  }
}
