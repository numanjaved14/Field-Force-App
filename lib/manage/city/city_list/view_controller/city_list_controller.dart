import 'package:field_force_app/base/models/city_model.dart' as city_model;
import 'package:field_force_app/base/models/country_model.dart'
    as country_model;
import 'package:field_force_app/manage/city/city_list/repository/city_list_repository.dart';
import 'package:field_force_app/manage/city/city_list/repository/country_list_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/shared_pref_strings.dart';

class CityListController extends GetxController {
  RxBool isInit = false.obs;
  RxBool hasCountryData = false.obs;
  RxBool hasCityData = false.obs;
  RxBool hasError = false.obs;
  RxBool isSearch = false.obs;

  Rx<TextEditingController> searchController = TextEditingController().obs;

  FocusNode searchFocus = FocusNode();

  var formKey = GlobalKey<FormState>();

  final cityListRepository = CityListRepository();
  final countryListRepository = CountryListRepository();

  Rx<List<city_model.Result>?> cityList = Rx<List<city_model.Result>?>([]);

  Rx<List<city_model.Result>?> orgList = Rx<List<city_model.Result>?>([]);

  Rx<List<country_model.Result>?> countryList =
      Rx<List<country_model.Result>?>([]);

  Rx<List<String>> permissionsList = Rx<List<String>>([]);

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
    hasCityData.value = false;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result = await cityListRepository.getCityList(countryID: 1);
      getCountryList();
      city_model.CityModel res = city_model.CityModel.fromJson(result.data);
      if (res.status == true) {
        print('This is res: ${res.result![0].name}');
        cityList.value = res.result;
        cityList.value!.sort(
          (a, b) => a.name!.compareTo(b.name!),
        );
        orgList.value = cityList.value;
        hasCityData.value = true;
        print('This is res: ${cityList.value!.length}');
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }

  getCountryList() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result = await countryListRepository.getCountryList();
      country_model.CountryModel res =
          country_model.CountryModel.fromJson(result.data);
      if (res.status == true) {
        print('This is res: ${res.result![0].name}');
        countryList.value = res.result;
        hasCountryData.value = true;
        print('This is res: ${cityList.value!.length}');
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }

  onSearchChange() {
    Rx<List<city_model.Result>?> result = Rx<List<city_model.Result>?>([]);
    if (searchController.value.text.isEmpty) {
      cityList.value = orgList.value;
    } else {
      result.value = cityList.value!
          .where(
            (u) => u.name!.toLowerCase().contains(
                  searchController.value.text.toLowerCase(),
                ),
          )
          .toList();
      print(result.value);
      cityList.value = result.value;
    }
  }

  resetSearch() {
    searchController.value.clear();
    searchFocus.unfocus();
    isSearch.value = false;
    cityList.value = orgList.value;
  }
}
