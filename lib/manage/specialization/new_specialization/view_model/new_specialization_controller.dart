import 'package:field_force_app/base/models/team_list_model.dart';
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../base/models/specialization_model.dart';
import '../../../../constants/shared_pref_strings.dart';
import '../repository/new_specialization_repository.dart';
import '../repository/update_specialization_repository.dart';

class NewSpecializationController extends GetxController {
  @override
  void onReady() {
    initMethod();
    super.onReady();
  }

  var showProgress = false.obs;
  var data = Get.arguments;

  var newSpecializationRepo = NewSpecializationRepository();
  var updateSpecializationRepo = UpdateSpecializationRepository();

  Rx<TextEditingController> specializationName = TextEditingController().obs;
  Rx<TextEditingController> specializationDescription =
      TextEditingController().obs;

  @override
  void onInit() {
    print('object');
    super.onInit();
    // initMethod();
  }

  initMethod() {
    print(data.toString());
    if (data[0] == 'Update specialization') {
      specializationName.value.text = data[1].name;
      specializationDescription.value.text = data[1].description;
    }
  }

  onNewSpecializationPressed() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    if (specializationName.value.text.isNotEmpty &&
        specializationDescription.value.text.isNotEmpty) {
      showProgress.value = true;
      String? accessToken =
          _sharedPref.getString(SharedPrefStrings().accessToken);
      try {
        var result = await newSpecializationRepo.addNewSpecialization(
          specializationName: specializationName.value.text,
          specializationDescription: specializationDescription.value.text,
        );
        showProgress.value = false;
        SpecializationModel res = SpecializationModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(
                  title: 'Specialization Added',
                  subtitle: 'Specialization Added Successfully')
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

  onUpdateSpecializationPressed() async {
    if (specializationName.value.text.isNotEmpty &&
        specializationDescription.value.text.isNotEmpty) {
      showProgress.value = true;
      try {
        var result = await updateSpecializationRepo.updateSpecialization(
          specializationID: data[1].id,
          specializationName: specializationName.value.text,
          specializationDescription: specializationDescription.value.text,
        );
        showProgress.value = false;
        TeamListModel res = TeamListModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(
                  title: 'Specialization Updated',
                  subtitle: 'Specialization Updated Successfully')
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
    specializationName.value.dispose();
    specializationDescription.value.dispose();
    super.onClose();
  }
}
