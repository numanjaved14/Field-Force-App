import 'package:field_force_app/base/models/employment_status_model.dart';
import 'package:field_force_app/base/models/team_list_model.dart';
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/shared_pref_strings.dart';
import '../../../../home/view/home.dart';
import '../repository/new_employment_status_repository.dart';
import '../repository/update_employment_status_repository.dart';

class NewEmploymentStatusController extends GetxController {
  @override
  void onReady() {
    initMethod();
    super.onReady();
  }

  var showProgress = false.obs;
  var data = Get.arguments;

  var newEmploymentStatusRepo = NewEmploymentStatusRepository();
  var updateEmploymentStatusRepo = UpdateEmploymentStatusRepository();

  Rx<TextEditingController> employmentStatusName = TextEditingController().obs;
  Rx<TextEditingController> employmentStatusDescription =
      TextEditingController().obs;

  initMethod() {
    print(data.toString());
    if (data[0] == 'Update Employment Status') {
      employmentStatusName.value.text = data[1].name;
      employmentStatusDescription.value.text = data[1].description;
    }
  }

  onNewEmploymentStatusPressed() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    if (employmentStatusName.value.text.isNotEmpty &&
        employmentStatusDescription.value.text.isNotEmpty) {
      showProgress.value = true;
      String? accessToken =
          _sharedPref.getString(SharedPrefStrings().accessToken);
      try {
        var result = await newEmploymentStatusRepo.addNewEmploymentStatus(
          employmentStatusName: employmentStatusName.value.text,
          employmentStatusDescription: employmentStatusDescription.value.text,
        );
        showProgress.value = false;
        EmploymentStatusModel res = EmploymentStatusModel.fromJson(result.data);
        if (res.message == 'Employment status added successfully.') {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(
                  title: 'Employment Status Added',
                  subtitle: 'Employment Status Added Successfully')
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

  onUpdateEmploymentStatusPressed() async {
    if (employmentStatusName.value.text.isNotEmpty &&
        employmentStatusDescription.value.text.isNotEmpty) {
      showProgress.value = true;
      try {
        var result = await updateEmploymentStatusRepo.updateEmploymentStatus(
          employmentStatusID: data[1].id,
          employmentStatusName: employmentStatusName.value.text,
          employmentStatusDescription: employmentStatusDescription.value.text,
          activeStatus: data[1].active,
        );
        showProgress.value = false;
        TeamListModel res = TeamListModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(
                  title: 'Employment Status Updated',
                  subtitle: 'Employment Status Updated Successfully')
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
    employmentStatusName.value.dispose();
    employmentStatusDescription.value.dispose();
    super.onClose();
  }
}
