import 'package:field_force_app/base/models/team_list_model.dart';
import 'package:field_force_app/manage/team/team_list/repository/team_list_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/shared_pref_strings.dart';

class TeamListController extends GetxController {
  RxBool isInit = false.obs;
  RxBool hasData = false.obs;
  RxBool hasError = false.obs;
  RxBool isSearch = false.obs;

  Rx<TextEditingController> searchController = TextEditingController().obs;

  FocusNode searchFocus = FocusNode();

  final teamListRepository = TeamListRepository();

  Rx<List<Result>?> teamList = Rx<List<Result>?>([]);

  Rx<List<String>> permissionsList = Rx<List<String>>([]);

  Rx<List<Result>?> orgList = Rx<List<Result>?>([]);

  @override
  void onInit() {
    super.onInit();
    getTeamList();
    initMethod();
  }

  initMethod() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    permissionsList.value.addAll(sharedPref
        .getStringList(SharedPrefStrings().permissionList) as List<String>);

    print('This is init: ..${permissionsList.value.length}');
    isInit.value = true;
  }

  getTeamList() async {
    hasData.value = false;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result = await teamListRepository.getTeamList(token: accessToken);
      TeamListModel res = TeamListModel.fromJson(result.data);
      if (res.status == true) {
        print('This is res: ${res.result![0].name}');
        teamList.value = res.result;
        teamList.value!.sort(
          (a, b) => b.id!.compareTo(a.id!),
        );
        orgList.value = teamList.value;
        hasData.value = true;
        print('This is res: ${teamList.value!.length}');
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
      teamList.value = orgList.value;
    } else {
      result.value = teamList.value!
          .where(
            (u) => u.name!.toLowerCase().contains(
                  searchController.value.text.toLowerCase(),
                ),
          )
          .toList();
      teamList.value = result.value;
      print(teamList.value!.length);
    }
  }

  resetSearch() {
    searchController.value.clear();
    searchFocus.unfocus();
    isSearch.value = false;
    teamList.value = orgList.value;
  }
}
