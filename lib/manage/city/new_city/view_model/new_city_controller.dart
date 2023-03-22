import 'package:field_force_app/base/models/City_model.dart';
import 'package:field_force_app/base/models/team_list_model.dart';
import 'package:field_force_app/manage/city/new_city/repository/new_city_repository.dart';
import 'package:field_force_app/manage/city/new_city/repository/update_city_repository.dart';
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/shared_pref_strings.dart';

class NewCityController extends GetxController {
  @override
  void onReady() {
    initMethod();
    super.onReady();
  }

  var showProgress = false.obs;
  var data = Get.arguments;

  var newCityRepo = NewCityRepository();
  var updateCityRepo = UpdateCityRepository();

  Rx<TextEditingController> cityName = TextEditingController().obs;
  Rx<TextEditingController> cityShortName = TextEditingController().obs;

  initMethod() {
    print(data.toString());
    if (data[0] == 'Update City') {
      cityName.value.text = data[1].name;
      cityShortName.value.text = data[1].shortName;
    }
  }

  onNewCityPressed() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    if (cityName.value.text.isNotEmpty && cityShortName.value.text.isNotEmpty) {
      showProgress.value = true;
      String? accessToken =
          _sharedPref.getString(SharedPrefStrings().accessToken);
      try {
        var result = await newCityRepo.addNewCity(
          cityName: cityName.value.text,
          cityShortName: cityShortName.value.text,
          coutryID: 1,
        );
        showProgress.value = false;
        CityModel res = CityModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(title: 'City Added', subtitle: 'City Added Successfully')
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

  onUpdateCityPressed() async {
    if (cityName.value.text.isNotEmpty && cityShortName.value.text.isNotEmpty) {
      showProgress.value = true;
      try {
        var result = await updateCityRepo.updateCity(
          cityID: data[1].id,
          cityName: cityName.value.text,
          cityShortName: cityShortName.value.text,
          coutryID: data[1].countryId,
        );
        showProgress.value = false;
        TeamListModel res = TeamListModel.fromJson(result.data);
        if (res.message == 'Record fetched successfully') {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(
                  title: 'City Updated', subtitle: 'City Updated Successfully')
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
    cityName.value.dispose();
    cityShortName.value.dispose();
    super.onClose();
  }
}
