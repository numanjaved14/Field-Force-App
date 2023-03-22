import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../base/models/doctor_model.dart';
import '../../../../base/models/rank_model.dart' as rank_model;
import '../../../../base/models/specialization_model.dart'
    as specialization_model;
import '../../../../constants/shared_pref_strings.dart';
import '../../../city/city_list/repository/city_list_repository.dart';
import '../../../rank/rank_list/repository/rank_list_repository.dart';
import '../../../specialization/specialization_list/repository/specilization_list_repository.dart';
import '../repository/new_doctor_repository.dart';
import '../repository/update_doctor_repository.dart';
import 'package:field_force_app/base/models/city_model.dart' as city_model;

class NewDoctorController extends GetxController {
  RxBool showProgress = false.obs;
  RxBool hasError = false.obs;
  RxBool hasData = false.obs;
  var data = Get.arguments;

  var newDoctorRepo = NewDoctorRepository();
  var updateDoctorRepo = UpdateDoctorRepository();

  final cityListRepository = CityListRepository();
  final rankListRepository = RankListRepository();
  final specializationListRepository = SpecilizationListRepository();

//Actual data coming from API
  Rx<List<city_model.Result>?> cityList = Rx<List<city_model.Result>?>([]);
  Rx<List<rank_model.Result>?> rankList = Rx<List<rank_model.Result>?>([]);
  Rx<List<specialization_model.Result>?> specializationList =
      Rx<List<specialization_model.Result>?>([]);

//List created for selection drop down in UI
  Rx<List<String>?> citySearchList = Rx<List<String>?>([]);
  Rx<List<String>?> rankSearchList = Rx<List<String>?>([]);
  Rx<List<String>?> specializationSearchList = Rx<List<String>?>([]);

  RxInt cityId = 0.obs;
  RxInt rankId = 0.obs;
  RxInt specializationId = 0.obs;

  Rx<TextEditingController> doctorNameController = TextEditingController().obs;
  Rx<TextEditingController> contact1Controller = TextEditingController().obs;
  Rx<TextEditingController> contact2Controller = TextEditingController().obs;
  Rx<TextEditingController> pmdcController = TextEditingController().obs;
  Rx<TextEditingController> specializationNameController =
      TextEditingController().obs;
  Rx<TextEditingController> rankNameController = TextEditingController().obs;
  Rx<TextEditingController> cityNameController = TextEditingController().obs;

  FocusNode cityFocusNode = FocusNode();
  FocusNode rankFocusNode = FocusNode();
  FocusNode specializationFocusNode = FocusNode();

  @override
  void onReady() {
    initMethod();
    super.onReady();
  }

  initMethod() {
    print(data.toString());
    if (data[0] == 'Update Doctor') {
      doctorNameController.value.text = data[1].name.toString();
      contact1Controller.value.text = data[1].contact1.toString();
      contact2Controller.value.text = data[1].contact2.toString();
      pmdcController.value.text = data[1].pmdcnumber.toString();
      specializationNameController.value.text =
          data[1].specializationName.toString();
      rankNameController.value.text = data[1].rankName.toString();
      cityNameController.value.text = data[1].cityName.toString();
    }
    getCityList();
    getRankList();
    getSpecilizationList();
  }

  setInitId() {
    if (hasData.value) {
      getCityId(
        dataList: cityList.value,
        searchText: cityNameController.value.text,
      );
      getRankId(
        dataList: rankList.value,
        searchText: rankNameController.value.text,
      );
      getSpecializationId(
        dataList: specializationList.value,
        searchText: specializationNameController.value.text,
      );
    }
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
        setSearchList(
          dataList: cityList.value,
          searchList: citySearchList.value,
        );
        print('This is res: ${cityList.value!.length}');
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }

  getRankList() async {
    hasData.value = false;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result = await rankListRepository.getRankList(token: accessToken);
      rank_model.RankModel res = rank_model.RankModel.fromJson(result.data);
      if (res.status == true) {
        print('This is res: ${res.result![0].name}');
        rankList.value = res.result;
        setSearchList(
          dataList: rankList.value,
          searchList: rankSearchList.value,
        );
        print('This is res: ${rankList.value!.length}');
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }

  getSpecilizationList() async {
    hasData.value = false;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result = await specializationListRepository.getSpecilizationList();
      specialization_model.SpecializationModel res =
          specialization_model.SpecializationModel.fromJson(result.data);
      if (res.status == true) {
        print('This is res: ${res.result![0].name}');
        specializationList.value = res.result;
        setSearchList(
          dataList: specializationList.value,
          searchList: specializationSearchList.value,
        );
        hasData.value = true;
        if (data[0] == 'Update Doctor') {
          setInitId();
        }
        print('This is res: ${specializationList.value!.length}');
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }

  setSearchList({var searchList, var dataList}) {
    for (int i = 0; i < dataList.length; i++) {
      searchList.add(dataList[i].name);
    }
  }

  getSearchId({var searchText, var dataList, required int iD}) {
    for (int i = 0; i < dataList.length; i++) {
      if (dataList[i].name == searchText) {
        iD = dataList[i].id;
      }
    }
    print('This is ID: $iD');
  }

  getCityId({var searchText, var dataList}) {
    for (int i = 0; i < dataList.length; i++) {
      if (dataList[i].name == searchText) {
        cityId.value = dataList[i].id;
      }
    }
  }

  getRankId({var searchText, var dataList}) {
    for (int i = 0; i < dataList.length; i++) {
      if (dataList[i].name == searchText) {
        rankId.value = dataList[i].id;
      }
    }
  }

  getSpecializationId({var searchText, var dataList}) {
    for (int i = 0; i < dataList.length; i++) {
      if (dataList[i].name == searchText) {
        specializationId.value = dataList[i].id;
      }
    }
  }

  onNewDoctorPressed() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();

    if (doctorNameController.value.text.isNotEmpty &&
        contact1Controller.value.text.isNotEmpty) {
      showProgress.value = true;
      String? accessToken =
          _sharedPref.getString(SharedPrefStrings().accessToken);
      try {
        var result = await newDoctorRepo.addNewDoctor(
          cityID: cityId.value,
          cityName: cityNameController.value.text,
          contact2: contact2Controller.value.text,
          pmdcNumber: pmdcController.value.text,
          rankID: rankId.value,
          rankName: rankNameController.value.text,
          specializationID: specializationId.value,
          specializationName: specializationNameController.value.text,
          doctorName: doctorNameController.value.text,
          contact1: contact1Controller.value.text,
          token: accessToken,
        );
        showProgress.value = false;
        DoctorListModel res = DoctorListModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(
                  title: 'Doctor Added', subtitle: 'Doctor Added Successfully')
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

  onUpdateDoctorPressed() async {
    if (doctorNameController.value.text.isNotEmpty &&
        contact1Controller.value.text.isNotEmpty) {
      showProgress.value = true;
      try {
        var result = await updateDoctorRepo.updateDoctor(
          doctorID: data[1].id,
          cityID: cityId.value,
          cityName: cityNameController.value.text,
          contact2: contact2Controller.value.text,
          pmdcNumber: pmdcController.value.text,
          rankID: rankId.value,
          rankName: rankNameController.value.text,
          specializationID: specializationId.value,
          specializationName: specializationNameController.value.text,
          doctorName: doctorNameController.value.text,
          contact1: contact1Controller.value.text,
        );
        showProgress.value = false;
        DoctorListModel res = DoctorListModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(
                  title: 'Doctor Updated',
                  subtitle: 'Doctor Updated Successfully')
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
    doctorNameController().dispose();
    contact1Controller().dispose();
    contact2Controller().dispose();
    pmdcController().dispose();
    specializationNameController().dispose();
    rankNameController().dispose();
    cityNameController().dispose();
    super.onClose();
  }
}
