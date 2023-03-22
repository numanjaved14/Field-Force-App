import 'package:field_force_app/base/models/department_model.dart';
import 'package:field_force_app/manage/department/department_list/repository/department_list_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/shared_pref_strings.dart';

class DepartmentListController extends GetxController {
  RxBool isInit = false.obs;
  RxBool hasData = false.obs;
  RxBool hasError = false.obs;

  RxBool isSearch = false.obs;

  Rx<TextEditingController> searchController = TextEditingController().obs;

  FocusNode searchFocus = FocusNode();

  final depListRepository = DepartmentListRepository();

  Rx<List<Result>?> depList = Rx<List<Result>?>([]);

  Rx<List<String>> permissionsList = Rx<List<String>>([]);

  Rx<List<Result>?> orgList = Rx<List<Result>?>([]);

  @override
  void onInit() {
    super.onInit();
    getDepList();
    initMethod();
  }

  initMethod() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    permissionsList.value.addAll(sharedPref
        .getStringList(SharedPrefStrings().permissionList) as List<String>);

    print('This is init: ..${permissionsList.value.length}');
    isInit.value = true;
  }

  getDepList() async {
    hasData.value = false;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result = await depListRepository.getDepartmentList();
      DepartmentModel res = DepartmentModel.fromJson(result.data);
      if (res.status == true) {
        print('This is res: ${res.result![0].name}');
        depList.value = res.result;
        depList.value!.sort(
          (a, b) => b.id!.compareTo(a.id!),
        );
        orgList.value = depList.value;
        hasData.value = true;
        print('This is res: ${depList.value!.length}');
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
      depList.value = orgList.value;
    } else {
      result.value = depList.value!
          .where(
            (u) => u.name!.toLowerCase().contains(
                  searchController.value.text.toLowerCase(),
                ),
          )
          .toList();
      print(result.value);
      depList.value = result.value;
    }
  }

  resetSearch() {
    searchController.value.clear();
    searchFocus.unfocus();
    isSearch.value = false;
    depList.value = orgList.value;
  }
}
