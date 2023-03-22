import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../base/models/doctor_model.dart';
import '../../../../constants/shared_pref_strings.dart';
import '../../../city/city_list/repository/city_list_repository.dart';
import '../repository/doctor_list_repository.dart';
import 'package:field_force_app/base/models/city_model.dart' as city_model;

class DoctorListController extends GetxController {
  RxBool isInit = false.obs;
  RxBool hasData = false.obs;
  RxBool hasError = false.obs;
  RxBool isSearch = false.obs;

  Rx<TextEditingController> searchController = TextEditingController().obs;

  FocusNode searchFocus = FocusNode();

  final doctorListRepository = DoctorListRepository();
  final cityListRepository = CityListRepository();

  Rx<List<Result>?> doctorList = Rx<List<Result>?>([]);

  Rx<List<city_model.Result>?> cityList = Rx<List<city_model.Result>?>([]);

  Rx<List<String>> permissionsList = Rx<List<String>>([]);

  Rx<List<Result>?> orgList = Rx<List<Result>?>([]);

  @override
  void onInit() {
    super.onInit();
    getCityList();
    initMethod();
  }

  initMethod() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    permissionsList.value.addAll(sharedPref
        .getStringList(SharedPrefStrings().permissionList) as List<String>);

    print('This is init: ..${permissionsList.value.length}');
    isInit.value = true;
  }

  getCityList() async {
    hasData.value = false;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result = await cityListRepository.getCityList(countryID: 1);
      city_model.CityModel res = city_model.CityModel.fromJson(result.data);
      if (res.status == true) {
        print('This is res: ${res.result![0].name}');
        cityList.value = res.result;
        cityList.value!.sort(
          (a, b) => a.name!.compareTo(b.name!),
        );
        getDoctorList(cityId: cityList.value![0].id);
        print('This is res: ${cityList.value!.length}');
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }

  getDoctorList({int? cityId}) async {
    hasData.value = false;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result = await doctorListRepository.getDoctorList(
          token: accessToken, cityID: cityId ?? 1);
      DoctorListModel res = DoctorListModel.fromJson(result.data);
      if (res.status == true) {
        doctorList.value = res.result;
        doctorList.value!.sort(
          (a, b) => b.id!.compareTo(a.id!),
        );
        orgList.value = doctorList.value;
        hasData.value = true;
        print('This is res: ${doctorList.value!.length}');
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
      doctorList.value = orgList.value;
    } else {
      result.value = doctorList.value!
          .where(
            (u) => u.name!.toLowerCase().contains(
                  searchController.value.text.toLowerCase(),
                ),
          )
          .toList();
      print(result.value);
      doctorList.value = result.value;
    }
  }

  resetSearch() {
    searchController.value.clear();
    searchFocus.unfocus();
    isSearch.value = false;
    doctorList.value = orgList.value;
  }
}
