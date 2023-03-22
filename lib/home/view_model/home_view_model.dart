import 'package:field_force_app/constants/shared_pref_strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../base/models/permission_model.dart';
import '../repository/permissions_repository.dart';

class HomeViewModel extends GetxController {
  var index = 0.obs;
  var hasData = false.obs;
  var hasError = false.obs;
  List<String> permissions = [];

  final permissionRepo = PermissionsRepository();

  @override
  void onInit() {
    super.onInit();
    getPermissionInit();
  }

  getPermissionInit() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    String? accessToken =
        _sharedPref.getString(SharedPrefStrings().accessToken);
    String? empID = _sharedPref.getString(SharedPrefStrings().empID);
    if (accessToken!.isNotEmpty) {
      var result = await permissionRepo.getPermissions(
          employeeId: empID!, token: accessToken);
      PermissionModel res = PermissionModel.fromJson(result.data);
      if (res.status == true) {
        hasData.value = true;
        print('This is res: ${res.result}');
        for (int i = 0; i < res.result![0].employeePermissions!.length; i++) {
          permissions
              .add(res.result![0].employeePermissions![i].permissionName!);
        }
        print('List length: ${permissions}');
        await _sharedPref
            .setStringList(SharedPrefStrings().permissionList, permissions)
            .then(
              (value) => print(
                  'List pref: ${_sharedPref.getStringList(SharedPrefStrings().permissionList)!.contains('CanViewPermission')}'),
            );
      } else {
        hasError.value = true;
      }
    } else {
      print('No token Found!!!');
      hasError.value = true;
    }
  }

  onBottomTap(position) {
    index.value = position;
    print(index.value.toString());
  }
}
