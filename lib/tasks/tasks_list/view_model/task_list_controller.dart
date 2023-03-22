import 'package:field_force_app/base/models/task_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/shared_pref_strings.dart';
import '../repository/task_list_repository.dart';

class TaskListController extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  RxBool isInit = false.obs;
  RxBool hasData = false.obs;
  RxBool hasError = false.obs;
  RxBool isSearch = false.obs;

  RxInt? newTaskSlectedValue = 0.obs;

  Rx<TextEditingController> searchController = TextEditingController().obs;

  FocusNode searchFocus = FocusNode();

  final taskListRepository = TaskListRepository();

  Rx<List<Tasks>?> taskList = Rx<List<Tasks>?>([]);

  Rx<List<String>> permissionsList = Rx<List<String>>([]);

  Rx<List<Tasks>?> orgList = Rx<List<Tasks>?>([]);

  @override
  void onInit() {
    super.onInit();
    getTaskList();
    initMethod();
  }

  void openDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.closeEndDrawer();
  }

  initMethod() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    permissionsList.value.addAll(sharedPref
        .getStringList(SharedPrefStrings().permissionList) as List<String>);

    print('This is init: ..${permissionsList.value.length}');
    isInit.value = true;
  }

  getTaskList() async {
    hasData.value = false;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    int? empID = int.parse(_sharedPref.getString(SharedPrefStrings().empID)!);
    if (accessToken!.isNotEmpty) {
      var result = await taskListRepository.getTaskList(empId: empID);
      TaskListModel res = TaskListModel.fromJson(result.data);
      if (res.status == true) {
        taskList.value = res.result![0].tasks!;
        print('This is res: ${taskList.value!.length}');
        taskList.value!.sort(
          (a, b) => b.lastUpdateStatusTime!.compareTo(a.lastUpdateStatusTime!),
        );
        orgList.value = taskList.value;
        hasData.value = true;
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }

  changeTaskValue({required int value}) {
    newTaskSlectedValue!.value = value;
  }
}
