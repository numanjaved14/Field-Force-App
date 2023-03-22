import 'package:field_force_app/base/models/department_model.dart';
import 'package:field_force_app/base/models/team_list_model.dart';
import 'package:field_force_app/manage/team/new_team/repository/new_team_repository.dart';
import 'package:field_force_app/manage/team/new_team/repository/update_team_repository.dart';
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/shared_pref_strings.dart';
import '../../../../home/view/home.dart';
import '../repository/new_department_repository.dart';
import '../repository/update_department_repository.dart';

class NewDepartmentController extends GetxController {
  @override
  void onReady() {
    initMethod();
    super.onReady();
  }

  var showProgress = false.obs;
  var data = Get.arguments;

  var newDepartmentRepo = NewDepartmentRepository();
  var updateDepartmentRepo = UpdateDepartmentRepository();

  Rx<TextEditingController> depName = TextEditingController().obs;
  Rx<TextEditingController> depDescription = TextEditingController().obs;

  @override
  void onInit() {
    print('object');
    super.onInit();
    // initMethod();
  }

  initMethod() {
    print(data.toString());
    if (data[0] == 'Update Department') {
      depName.value.text = data[1].name;
      depDescription.value.text = data[1].description;
    }
  }

  onNewDepartmentPressed() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    if (depName.value.text.isNotEmpty && depDescription.value.text.isNotEmpty) {
      showProgress.value = true;
      String? accessToken =
          _sharedPref.getString(SharedPrefStrings().accessToken);
      try {
        var result = await newDepartmentRepo.addNewDepartment(
          depName: depName.value.text,
          depDescription: depDescription.value.text,
        );
        showProgress.value = false;
        DepartmentModel res = DepartmentModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(
                  title: 'Department Added',
                  subtitle: 'Department Added Successfully')
              .getSnackbar();
        }
      } catch (error) {
        print(error.toString());
      }
    } else {
      MySnackBar(
              title: 'Input All Fields!',
              subtitle: 'Please input all fields correctly!')
          .getSnackbar();
    }
  }

  onUpdateDepartmentPressed() async {
    if (depName.value.text.isNotEmpty && depDescription.value.text.isNotEmpty) {
      showProgress.value = true;
      try {
        var result = await updateDepartmentRepo.updateDepartment(
          depID: data[1].id,
          depName: depName.value.text,
          depDescription: depDescription.value.text,
          activeStatus: data[1].active,
        );
        showProgress.value = false;
        TeamListModel res = TeamListModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(
                  title: 'Department Updated',
                  subtitle: 'Department Updated Successfully')
              .getSnackbar();
        }
      } catch (error) {
        print(error.toString());
      }
    } else {
      MySnackBar(
              title: 'Input All Fields!',
              subtitle: 'Please input all fields correctly!')
          .getSnackbar();
    }
  }

  @override
  void onClose() {
    depName.value.dispose();
    depDescription.value.dispose();
    super.onClose();
  }
}
