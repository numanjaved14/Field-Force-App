import 'package:field_force_app/tasks/new_task/new_task_screen2/repository/task_doctor_repository.dart';
import 'package:field_force_app/tasks/new_task/new_task_screen2/view/new_task_view2.dart';
import 'package:field_force_app/tasks/new_task/new_task_screen3/repository/hospital_loc_repository.dart';
import 'package:field_force_app/tasks/new_task/new_task_screen4/repository/product_repository.dart';
import 'package:field_force_app/tasks/new_task/new_task_screen5/repository/asignee_repository.dart';
import 'package:field_force_app/tasks/new_task/new_task_screen6/repository/subtasks_repository.dart';
import 'package:field_force_app/tasks/new_task/new_task_screen7/repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/shared_pref_strings.dart';
import '../../../manage/city/city_list/repository/city_list_repository.dart';

import 'package:field_force_app/base/models/task_city_model.dart' as city_model;
import 'package:field_force_app/base/models/task_asignee_model.dart'
    as asignee_model;
import 'package:field_force_app/base/models/task_doctor_model.dart'
    as doctor_model;
import 'package:field_force_app/base/models/task_pracitce_loc_model.dart'
    as practice_loc_model;
import 'package:field_force_app/base/models/task_priority_model.dart'
    as priority_model;
import 'package:field_force_app/base/models/task_product_model.dart'
    as product_model;
import 'package:field_force_app/base/models/task_subtasks_model.dart'
    as subtasks_model;
import 'package:field_force_app/base/models/new_task_model.dart'
    as new_task_model;

import '../new_task_screen1/repository/task_city_repository.dart';

class NewTaskController extends GetxController {
  //Global Keys
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  //Data variables
  RxInt cityId = 0.obs;
  RxString cityName = ''.obs;

  //Data Checks
  RxBool hasCityData = false.obs;
  RxBool hasDoctorData = false.obs;
  RxBool hasPracticeLocData = false.obs;
  RxBool hasProductData = false.obs;
  RxBool hasAsigneeData = false.obs;
  RxBool hasSubtasksData = false.obs;
  RxBool hasCategoryData = false.obs;
  RxBool hasData = false.obs;
  RxBool hasError = false.obs;

  //Repositories for API calling
  final taskCityListRepository = TaskCityRepository();
  final taskDoctorRepository = TaskDoctorRepository();
  final taskPracticeLocRepository = TaskHospitalLocationRepository();
  final taskProductRepository = TaskProductRepository();
  final taskAsigneeRepository = TaskAsigneeRepository();
  final taskSubtasksRepository = TaskSubTasksRepository();
  final taskCategoryRepository = TaskCategoryRepository();

  //Text field Controllers
  Rx<TextEditingController> taskNameController = TextEditingController().obs;
  Rx<TextEditingController> taskDescriptionController =
      TextEditingController().obs;

  //Original Lists coming from API
  Rx<List<city_model.Result>?> orgCityList = Rx<List<city_model.Result>?>([]);
  Rx<List<doctor_model.Result>?> orgDoctorList =
      Rx<List<doctor_model.Result>?>([]);
  Rx<List<practice_loc_model.Result>?> orgPracticeLocList =
      Rx<List<practice_loc_model.Result>?>([]);
  Rx<List<product_model.Result>?> orgProductList =
      Rx<List<product_model.Result>?>([]);
  Rx<List<asignee_model.Result>?> orgAsigneeList =
      Rx<List<asignee_model.Result>?>([]);
  Rx<List<subtasks_model.Result>?> orgSubtasksList =
      Rx<List<subtasks_model.Result>?>([]);
  Rx<List<priority_model.Result>?> orgCategoryList =
      Rx<List<priority_model.Result>?>([]);

  //Lists for searching and displaying
  Rx<List<city_model.Result>?> cityList = Rx<List<city_model.Result>?>([]);
  Rx<List<doctor_model.Result>?> doctorList =
      Rx<List<doctor_model.Result>?>([]);
  Rx<List<practice_loc_model.Result>?> hospitalLocList =
      Rx<List<practice_loc_model.Result>?>([]);
  Rx<List<asignee_model.Result>?> asigneeList =
      Rx<List<asignee_model.Result>?>([]);

  @override
  void onInit() {
    super.onInit();
    getCityList();
  }

  @override
  void onClose() {
    super.onClose();
  }

  view1Next() {
    Get.to(() => NewTaskView2());
  }

  view2Next() {
    print(cityName.value);
  }

  getCityList() async {
    hasData.value = false;
    hasCityData.value = false;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result = await taskCityListRepository.getTaskCity(countryId: 1);
      city_model.TaskCityModel res =
          city_model.TaskCityModel.fromJson(result.data);
      if (res.status == true) {
        cityList.value = res.result;
        cityList.value!.sort(
          (a, b) => a.name!.compareTo(b.name!),
        );
        orgCityList.value = cityList.value;
        hasCityData.value = true;
        if (cityId.value == 0 && cityName.value == '') {
          cityId.value = orgCityList.value![0].id!;
          cityName.value = orgCityList.value![0].name!;
        }
        getDoctorList(cityId: cityId.value);
        getPracticeLocList(cityId: cityId.value);
        getProductList();
        getAsigneeList();
        getSubtasksList();
        getCategoryList();
        print('This is res: ${cityList.value!.length}');
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }

  getDoctorList({required int cityId}) async {
    hasData.value = false;
    hasDoctorData.value = false;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result = await taskDoctorRepository.getTaskDoctor(cityID: cityId);
      doctor_model.TaskDoctorModel res =
          doctor_model.TaskDoctorModel.fromJson(result.data);
      if (res.status == true) {
        doctorList.value = res.result;
        doctorList.value!.sort(
          (a, b) => a.name!.compareTo(b.name!),
        );
        orgDoctorList.value = doctorList.value;
        hasDoctorData.value = true;
        print('This is res: ${doctorList.value!.length}');
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }

  getPracticeLocList({required int cityId}) async {
    hasData.value = false;
    hasPracticeLocData.value = false;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result =
          await taskPracticeLocRepository.getTaskPracticeLoc(cityID: cityId);
      practice_loc_model.TaskPacticeLocModel res =
          practice_loc_model.TaskPacticeLocModel.fromJson(result.data);
      if (res.status == true) {
        hospitalLocList.value = res.result;
        hospitalLocList.value!.sort(
          (a, b) => a.name!.compareTo(b.name!),
        );
        orgPracticeLocList.value = hospitalLocList.value;
        hasPracticeLocData.value = true;
        print('This is res: ${hospitalLocList.value!.length}');
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }

  getProductList() async {
    hasData.value = false;
    hasProductData.value = false;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result = await taskProductRepository.getTaskProduct();
      product_model.TaskProductModel res =
          product_model.TaskProductModel.fromJson(result.data);
      if (res.status == true) {
        orgProductList.value = res.result;
        orgProductList.value!.sort(
          (a, b) => a.name!.compareTo(b.name!),
        );
        hasProductData.value = true;
        print('This is res: ${orgProductList.value!.length}');
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }

  getAsigneeList() async {
    hasData.value = false;
    hasAsigneeData.value = false;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    int? empId = int.parse(_sharedPref.getString(SharedPrefStrings().empID)!);
    if (accessToken!.isNotEmpty) {
      var result = await taskAsigneeRepository.getTaskAsignee(empId: empId);
      asignee_model.TaskAsigneeModel res =
          asignee_model.TaskAsigneeModel.fromJson(result.data);
      if (res.status == true) {
        asigneeList.value = res.result;
        asigneeList.value!.sort(
          (a, b) => a.firstName!.compareTo(b.firstName!),
        );
        orgAsigneeList.value = asigneeList.value;
        hasAsigneeData.value = true;
        print('This is res: ${orgAsigneeList.value!.length}');
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }

  getSubtasksList() async {
    hasData.value = false;
    hasSubtasksData.value = false;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result = await taskSubtasksRepository.getTaskSubTasks();
      subtasks_model.TaskSubtasksModel res =
          subtasks_model.TaskSubtasksModel.fromJson(result.data);
      if (res.status == true) {
        orgSubtasksList.value = res.result;
        orgSubtasksList.value!.sort(
          (a, b) => a.name!.compareTo(b.name!),
        );
        hasSubtasksData.value = true;
        print('This is res: ${orgSubtasksList.value!.length}');
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }

  getCategoryList() async {
    hasData.value = false;
    hasCategoryData.value = false;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result = await taskCategoryRepository.getTaskCategory();
      priority_model.TaskPriorityModel res =
          priority_model.TaskPriorityModel.fromJson(result.data);
      if (res.status == true) {
        orgCategoryList.value = res.result;
        orgCategoryList.value!.sort(
          (a, b) => a.name!.compareTo(b.name!),
        );
        hasCategoryData.value = true;
        print('This is res: ${orgCategoryList.value!.length}');
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }
}
