import 'package:field_force_app/base/models/city_model.dart';
import 'package:field_force_app/base/models/office_location_model.dart'
    as office_loc;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/shared_pref_strings.dart';
import '../../../city/city_list/repository/city_list_repository.dart';
import '../repository/office_location_list_repository.dart';

class OfficeLocationListController extends GetxController {
  RxBool isInit = false.obs;
  RxBool hasData = false.obs;
  RxBool hasError = false.obs;
  RxBool isSearch = false.obs;

  Rx<TextEditingController> searchController = TextEditingController().obs;

  FocusNode searchFocus = FocusNode();

  final officeLocationListRepository = OfficeLocationListRepository();
  final cityListRepository = CityListRepository();

  Rx<List<office_loc.Result>?> officeLocationList =
      Rx<List<office_loc.Result>?>([]);
  Rx<List<Result>?> cityList = Rx<List<Result>?>([]);

  Rx<List<String>> permissionsList = Rx<List<String>>([]);

  Rx<List<office_loc.Result>?> orgList = Rx<List<office_loc.Result>?>([]);

  @override
  void onInit() {
    super.onInit();
    getOfficeLocationList();
    initMethod();
  }

  initMethod() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    permissionsList.value.addAll(sharedPref
        .getStringList(SharedPrefStrings().permissionList) as List<String>);

    print('This is init: ..${permissionsList.value.length}');
    isInit.value = true;
  }

  getOfficeLocationList() async {
    hasData.value = false;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result = await officeLocationListRepository.getOfficeLocationList();
      office_loc.OfficeLocationModel res =
          office_loc.OfficeLocationModel.fromJson(result.data);
      if (res.status == true) {
        officeLocationList.value = res.result;
        officeLocationList.value!.sort(
          (a, b) => b.id!.compareTo(a.id!),
        );
        orgList.value = officeLocationList.value;
        getCityLocationList();
        // hasData.value = true;
        print('This is res: ${officeLocationList.value!.length}');
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }

  getCityLocationList() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result = await cityListRepository.getCityList(countryID: 1);
      CityModel res = CityModel.fromJson(result.data);
      if (res.status == true) {
        cityList.value = res.result;
        hasData.value = true;
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }

  onSearchChange() {
    Rx<List<office_loc.Result>?> result = Rx<List<office_loc.Result>?>([]);
    if (searchController.value.text.isEmpty) {
      officeLocationList.value = orgList.value;
    } else {
      result.value = officeLocationList.value!
          .where(
            (u) => u.address!.toLowerCase().contains(
                  searchController.value.text.toLowerCase(),
                ),
          )
          .toList();
      print(result.value);
      officeLocationList.value = result.value;
    }
  }

  resetSearch() {
    searchController.value.clear();
    searchFocus.unfocus();
    isSearch.value = false;
    officeLocationList.value = orgList.value;
  }
}
