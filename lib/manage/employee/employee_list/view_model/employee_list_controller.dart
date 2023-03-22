import 'package:field_force_app/manage/employee/employee_list/repository/employees_list_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../base/models/employees_model.dart';
import '../../../../constants/shared_pref_strings.dart';

class EmployeeListController extends GetxController {
  RxBool isInit = false.obs;
  RxBool hasData = false.obs;
  RxBool hasError = false.obs;
  RxBool isSearch = false.obs;

  Rx<TextEditingController> searchController = TextEditingController().obs;

  FocusNode searchFocus = FocusNode();

  final employeeListRepo = EmployeeListRepository();

  Rx<List<Result>?> employeeList = Rx<List<Result>?>([]);

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
      var result = await employeeListRepo.getEmployeeList();
      EmployeesModel res = EmployeesModel.fromJson(result.data);
      if (res.status == true) {
        print('This is res: ${res.result![0].firstName}');
        employeeList.value = res.result;
        employeeList.value!.sort(
          (a, b) => a.firstName!.compareTo(b.firstName!),
        );
        orgList.value = employeeList.value;
        hasData.value = true;
        print('This is res: ${employeeList.value!.length}');
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
      employeeList.value = orgList.value;
    } else {
      result.value = employeeList.value!
          .where(
            (u) => u.firstName!.toLowerCase().contains(
                  searchController.value.text.toLowerCase(),
                ),
          )
          .toList();
      print(result.value);
      employeeList.value = result.value;
    }
  }

  resetSearch() {
    searchController.value.clear();
    searchFocus.unfocus();
    isSearch.value = false;
    employeeList.value = orgList.value;
  }
}
