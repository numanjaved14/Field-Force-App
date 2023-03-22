import 'package:field_force_app/base/models/designation_model.dart';
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/shared_pref_strings.dart';
import '../../../../home/view/home.dart';
import '../repository/new_designation_repository.dart';
import '../repository/update_designation_repository.dart';

class NewDesignationController extends GetxController {
  @override
  void onReady() {
    initMethod();
    super.onReady();
  }

  var showProgress = false.obs;
  var data = Get.arguments;

  var newDesignationRepo = NewDesignationRepository();
  var updateDesignationRepo = UpdateDesignationRepository();

  Rx<TextEditingController> desName = TextEditingController().obs;
  Rx<TextEditingController> desDescription = TextEditingController().obs;
  Rx<TextEditingController> desShortName = TextEditingController().obs;

  initMethod() {
    print(data.toString());
    if (data[0] == 'Update Designation') {
      desName.value.text = data[1].name;
      desShortName.value.text = data[1].shortName;
      desDescription.value.text = data[1].description;
    }
  }

  onNewDesignationPressed() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    if (desName.value.text.isNotEmpty && desDescription.value.text.isNotEmpty) {
      showProgress.value = true;
      String? accessToken =
          _sharedPref.getString(SharedPrefStrings().accessToken);
      try {
        var result = await newDesignationRepo.addNewDesignation(
          desName: desName.value.text,
          desDescription: desDescription.value.text,
          desShortName: desShortName.value.text,
        );
        showProgress.value = false;
        DesignationModel res = DesignationModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(
                  title: 'Designation Added',
                  subtitle: 'Designation Added Successfully')
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

  onUpdateDesignationPressed() async {
    if (desName.value.text.isNotEmpty && desDescription.value.text.isNotEmpty) {
      showProgress.value = true;
      try {
        var result = await updateDesignationRepo.updateDesignation(
          desID: data[1].id,
          desName: desName.value.text,
          desDescription: desDescription.value.text,
          desShortName: desShortName.value.text,
        );
        showProgress.value = false;
        DesignationModel res = DesignationModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(
                  title: 'Designation Updated',
                  subtitle: 'Designation Updated Successfully')
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
    desName.value.dispose();
    desDescription.value.dispose();
    super.onClose();
  }
}
