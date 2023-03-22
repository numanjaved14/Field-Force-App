import 'package:field_force_app/base/models/team_list_model.dart';
import 'package:field_force_app/manage/team/new_team/repository/new_team_repository.dart';
import 'package:field_force_app/manage/team/new_team/repository/update_team_repository.dart';
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/shared_pref_strings.dart';

class NewTeamController extends GetxController {
  @override
  void onReady() {
    initMethod();
    super.onReady();
  }

  var showProgress = false.obs;
  var data = Get.arguments;

  var newTeamRepo = NewTeamRepository();
  var updateTeamRepo = UpdateTeamRepository();

  Rx<TextEditingController> teamName = TextEditingController().obs;
  Rx<TextEditingController> teamDescription = TextEditingController().obs;

  initMethod() {
    print(data.toString());
    if (data[0] == 'Update Team') {
      teamName.value.text = data[1].name;
      teamDescription.value.text = data[1].description;
    }
  }

  onNewTeamPressed() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    if (teamName.value.text.isNotEmpty &&
        teamDescription.value.text.isNotEmpty) {
      showProgress.value = true;
      String? accessToken =
          _sharedPref.getString(SharedPrefStrings().accessToken);
      try {
        var result = await newTeamRepo.addNewTeam(
          teamName: teamName.value.text,
          teamDescription: teamDescription.value.text,
          token: accessToken,
        );
        showProgress.value = false;
        TeamListModel res = TeamListModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(title: 'Team Added', subtitle: 'Team Added Successfully')
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

  onUpdateTeamPressed() async {
    if (teamName.value.text.isNotEmpty &&
        teamDescription.value.text.isNotEmpty) {
      showProgress.value = true;
      try {
        var result = await updateTeamRepo.updateTeam(
          teamID: data[1].id,
          teamName: teamName.value.text,
          teamDescription: teamDescription.value.text,
          activeStatus: data[1].active,
        );
        showProgress.value = false;
        TeamListModel res = TeamListModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(
                  title: 'Team Updated', subtitle: 'Team Updated Successfully')
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
    teamName.value.dispose();
    teamDescription.value.dispose();
    super.onClose();
  }
}
