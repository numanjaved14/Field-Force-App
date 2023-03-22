import 'package:field_force_app/base/models/team_list_model.dart';
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../base/models/permission_list_model.dart'
    as permission_list_model;
import '../../../../base/models/role_model.dart' as role_model;
import '../../../../constants/shared_pref_strings.dart';
import '../../../permission/permission_list/repository/permission_list_repository.dart';
import '../repository/new_role_repository.dart';
import '../repository/update_role_repository.dart';

class NewRoleController extends GetxController {
  RxBool hasData = false.obs;
  RxBool hasError = false.obs;

  Rx<List<String>?> permissionSearchList = Rx<List<String>?>([]);

  Rx<List<permission_list_model.Result>?> permissionList =
      Rx<List<permission_list_model.Result>?>([]);
  Rx<List<role_model.RolePermissions>?> roleListSent =
      Rx<List<role_model.RolePermissions>?>([]);
  final permissionListRepository = PermissionListRepository();

  @override
  void onReady() {
    initMethod();
    super.onReady();
  }

  var showProgress = false.obs;
  var data = Get.arguments;

  var newRoleRepo = NewRoleRepository();
  var updateRoleRepo = UpdateRoleRepository();

  Rx<TextEditingController> roleName = TextEditingController().obs;
  Rx<TextEditingController> roleDescription = TextEditingController().obs;
  Rx<TextEditingController> searchPermission = TextEditingController().obs;

  @override
  void onInit() {
    getPermissionList();
    super.onInit();
    // initMethod();
  }

  initMethod() {
    print(data.toString());
    if (data[0] == 'Update Role') {
      roleName.value.text = data[1].name;
      roleDescription.value.text = data[1].description;
      roleListSent.value = data[1].rolePermissions;
    }
  }

  setPermissionList() {
    print(permissionSearchList);
    for (int i = 0; i < permissionList.value!.length; i++) {
      permissionSearchList.value!.add(permissionList.value![i].name!);
    }
    print(permissionSearchList);
  }

  setPermissionInSentList() {
    for (int i = 0; i < permissionList.value!.length; i++) {
      if (searchPermission.value.text == permissionList.value![i].name! &&
          !roleListSent.value!.any(
              (element) => element.roleName == searchPermission.value.text)) {
        roleListSent.value!.insert(
          0,
          role_model.RolePermissions(
            // roleId: 0,
            // roleName: 'role Name',
            // permissionId: 0,
            // permissionName: 'permission',
            // permissionDescription: 'permissionList.value![i].description',
            roleId: data[0] == 'Update Role' ? data[1].id : 0,
            roleName: roleName.value.text,
            permissionId: permissionList.value![i].id,
            permissionName: permissionList.value![i].name,
            permissionDescription: permissionList.value![i].description,
          ),
        );
      }
    }
  }

  deletaItemPermissionInSentList({required int index}) {
    roleListSent.value!.removeAt(index);
  }

  getPermissionList() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    if (accessToken!.isNotEmpty) {
      var result = await permissionListRepository.getPermissionList();
      permission_list_model.PermissionListModel res =
          permission_list_model.PermissionListModel.fromJson(result.data);
      if (res.status == true) {
        // print('This is res: ${res.result![0].name}');
        permissionList.value = res.result;
        setPermissionList();
        hasData.value = true;
        print('This is res: ${permissionList.value!.length}');
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }

  onNewRolePressed() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    if (roleName.value.text.isNotEmpty &&
        roleDescription.value.text.isNotEmpty) {
      showProgress.value = true;
      String? accessToken =
          _sharedPref.getString(SharedPrefStrings().accessToken);
      try {
        var result = await newRoleRepo.addNewRole(
          roleName: roleName.value.text,
          roleDescription: roleDescription.value.text,
          rolePermissionList: roleListSent.value!,
        );
        showProgress.value = false;
        role_model.RoleModel res = role_model.RoleModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(title: 'Role Added', subtitle: 'Role Added Successfully')
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

  onUpdateRolePressed() async {
    if (roleName.value.text.isNotEmpty &&
        roleDescription.value.text.isNotEmpty) {
      showProgress.value = true;
      try {
        var result = await updateRoleRepo.updateRole(
          roleID: data[1].id,
          roleName: roleName.value.text,
          roleDescription: roleDescription.value.text,
          // rolePermissionList: ,
        );
        showProgress.value = false;
        TeamListModel res = TeamListModel.fromJson(result.data);
        if (res.status == true) {
          print('This is res: ${res.result![0].id}');
          Get.back(result: 'success');
          MySnackBar(
                  title: 'Role Updated', subtitle: 'Role Updated Successfully')
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
    roleName.value.dispose();
    roleDescription.value.dispose();
    super.onClose();
  }
}
