import 'package:field_force_app/base/models/city_model.dart' as city_model;
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../base/models/office_location_model.dart';
import '../../../../constants/shared_pref_strings.dart';
import '../repository/new_office_location_repository.dart';
import '../repository/update_office_location_repository.dart';

class NewOfficeLocationController extends GetxController {
  @override
  void onReady() {
    initMethod();
    super.onReady();
  }

  var showProgress = false.obs;
  var headOffice = false.obs;
  Rx<List<String>?> cityList = Rx<List<String>?>([]);

  var data = Get.arguments;
  var cityId = 0;

  var newOfficeLocationRepo = NewOfficeLocationRepository();
  var updateOfficeLocationRepo = UpdateOfficeLocationRepository();

  Rx<TextEditingController> address = TextEditingController().obs;
  Rx<TextEditingController> mobileNumber = TextEditingController().obs;
  Rx<TextEditingController> city = TextEditingController().obs;

  initMethod() {
    print(data.toString());
    if (data[0] == 'Update Office Location') {
      address.value.text = data[3].address;
      mobileNumber.value.text = data[3].contact1;
      city.value.text = data[1];
      setCityList(2);
      getCityId(2);
      print(cityList.value);
    } else {
      setCityList(1);
    }
  }

  setCityList(int index) {
    for (int i = 0; i < data[index].length; i++) {
      cityList.value!.add(data[index][i].name);
    }
    print(cityList);
  }

  getCityId(int index) {
    for (int i = 0; i < data[index].length; i++) {
      if (city.value.text == data[index][i].name) {
        cityId = data[index][i].id;
      }
    }
    print(cityId.toString());
  }

  onNewOfficeLocationPressed() async {
    getCityId(1);
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    if (address.value.text.isNotEmpty && mobileNumber.value.text.isNotEmpty) {
      showProgress.value = true;
      String? accessToken =
          _sharedPref.getString(SharedPrefStrings().accessToken);
      try {
        var result = await newOfficeLocationRepo.addNewOfficeLocation(
          address: address.value.text,
          contact: mobileNumber.value.text,
          cityId: cityId,
          headOffice: false,
        );
        showProgress.value = false;
        OfficeLocationModel res = OfficeLocationModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(
                  title: 'Office Location Added',
                  subtitle: 'Office Location Added Successfully')
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

  onUpdateOfficeLocationPressed() async {
    getCityId(2);
    if (address.value.text.isNotEmpty && mobileNumber.value.text.isNotEmpty) {
      showProgress.value = true;
      try {
        var result = await updateOfficeLocationRepo.updateOfficeLocation(
          id: data[3].id,
          address: address.value.text,
          contact: mobileNumber.value.text,
          cityId: cityId,
          headOffice: false,
        );
        showProgress.value = false;
        OfficeLocationModel res = OfficeLocationModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(
                  title: 'Office Location Updated',
                  subtitle: 'Office Location Updated Successfully')
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

  void setUserId() {
    for (int i = 0; i < data[1].length; i++) {
      if (data[1].name == city.value) {
        cityId = data[1].name;
      }
    }
  }

  @override
  void onClose() {
    address.value.dispose();
    mobileNumber.value.dispose();
    city.value.dispose();
    super.onClose();
  }
}
