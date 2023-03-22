import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../base/models/rank_model.dart';
import '../../../../constants/shared_pref_strings.dart';
import '../repository/new_rank_repository.dart';
import '../repository/update_rank_repository.dart';

class NewRankController extends GetxController {
  @override
  void onReady() {
    initMethod();
    super.onReady();
  }

  var showProgress = false.obs;
  var data = Get.arguments;

  var newRankRepo = NewRankRepository();
  var updateRankRepo = UpdateRankRepository();

  Rx<TextEditingController> rankName = TextEditingController().obs;
  Rx<TextEditingController> rankDescription = TextEditingController().obs;

  initMethod() {
    print(data.toString());
    if (data[0] == 'Update Rank') {
      rankName.value.text = data[1].name;
      rankDescription.value.text = data[1].description;
    }
  }

  onNewRankPressed() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    if (rankName.value.text.isNotEmpty &&
        rankDescription.value.text.isNotEmpty) {
      showProgress.value = true;
      String? accessToken =
          _sharedPref.getString(SharedPrefStrings().accessToken);
      try {
        var result = await newRankRepo.addNewRank(
          rankName: rankName.value.text,
          rankDescription: rankDescription.value.text,
          token: accessToken,
        );
        showProgress.value = false;
        RankModel res = RankModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          Get.snackbar(
            'Rank Added',
            'Rank Added Successfully',
            snackPosition: SnackPosition.BOTTOM,
            barBlur: 0,
            backgroundColor: Colors.white,
          );
        }
      } catch (error) {
        print(error.toString());
      }
    } else {
      Get.snackbar(
        "Input All Fields!",
        "Please input all fields correctly!",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
        barBlur: 0,
        backgroundColor: Colors.white,
      );
    }
  }

  onUpdateRankPressed() async {
    if (rankName.value.text.isNotEmpty &&
        rankDescription.value.text.isNotEmpty) {
      showProgress.value = true;
      try {
        var result = await updateRankRepo.updateRank(
          rankID: data[1].id,
          rankName: rankName.value.text,
          rankDescription: rankDescription.value.text,
        );
        showProgress.value = false;
        RankModel res = RankModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          Get.snackbar(
            'Rank Updated',
            'Rank Updated Successfully',
            snackPosition: SnackPosition.BOTTOM,
            barBlur: 0,
            backgroundColor: Colors.white,
          );
        }
      } catch (error) {
        print(error.toString());
      }
    } else {
      Get.snackbar(
        "Input All Fields!",
        "Please input all fields correctly!",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
        barBlur: 0,
        backgroundColor: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    rankName.value.dispose();
    rankDescription.value.dispose();
    super.onClose();
  }
}
