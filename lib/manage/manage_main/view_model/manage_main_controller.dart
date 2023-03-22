import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/shared_pref_strings.dart';

class ManageMainController extends GetxController {
  Rx<List<String>> permissionsList = Rx<List<String>>([]);
  RxBool isInit = false.obs;

  @override
  void onInit() {
    super.onInit();
    initMethod();
  }

  initMethod() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    permissionsList.value.addAll(sharedPref
        .getStringList(SharedPrefStrings().permissionList) as List<String>);

    print('This is init: ..${permissionsList.value.length}');
    isInit.value = true;
  }
}
