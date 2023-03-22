import 'package:field_force_app/manage/role/role_list/view_model/role_list_controller.dart';
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/input_text/app_text_input.dart';
import '../../../../widgets/list_item/list_item.dart';
import '../../../../widgets/no_data/no_data_view.dart';
import '../../../../widgets/others/date_container.dart';
import '../../../manage_main/view/manage_main.dart';
import '../../new_role/view/new_role.dart';

class RoleList extends GetView<RoleListController> {
  RoleList({Key? key}) : super(key: key);

  var roleListController = Get.put(RoleListController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset(
              'assets/icons/appbar_back.png',
              width: 25,
              height: 18,
              // color: const Color(0xFFD4D4D4),
            ),
            onPressed: () => Get.off(() => ManageMain()),
          ),
          actions: [
            roleListController.isSearch.value
                ? IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFFD4D4D4),
                    ),
                    onPressed: () {
                      roleListController.resetSearch();
                    },
                  )
                : IconButton(
                    icon: Image.asset(
                      'assets/icons/search.png',
                      width: 25,
                      height: 18,
                      // color: const Color(0xFFD4D4D4),
                    ),
                    onPressed: () {
                      roleListController.isSearch.value =
                          !roleListController.isSearch.value;
                      roleListController.searchFocus.requestFocus();
                    },
                  ),
          ],
          title: roleListController.isSearch.value
              ? MainSearchTextInput(
                  editingController: roleListController.searchController.value,
                  hint: 'Search by Role Name',
                  onChange: () => roleListController.onSearchChange(),
                  onFieldSubmit: () => roleListController.resetSearch(),
                  focusNode: roleListController.searchFocus,
                )
              : const Text(
                  'Roles',
                  style: TextStyle(
                    color: Color(0xFF272727),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
          backgroundColor: const Color(0x10F5F5F5),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 0.5,
                color: const Color(0xFFE2E2E2),
              ),
              const DateContainer(),
              Container(
                height: 0.5,
                color: const Color(0xFFE2E2E2),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25.0,
                  right: 25.0,
                  top: 25.0,
                  bottom: 10.0,
                ),
                child: roleListController.hasData.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: roleListController.roleList.value!.isEmpty
                            ? const NoData(text: 'Sorry! No Role found')
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount:
                                    roleListController.roleList.value!.length,
                                itemBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: ListItem(
                                    title: roleListController
                                        .roleList.value![index].name,
                                    subTitle: roleListController
                                        .roleList.value![index].description,
                                    iconPath: 'assets/icons/role.png',
                                    iconContainerColor: const Color(0x10DE0C15),
                                    onPress: () {
                                      roleListController.permissionsList.value
                                              .contains('CanUpdateRole')
                                          ? () async {
                                              final res = await Get.to(
                                                  () => NewRole(),
                                                  arguments: [
                                                    'Update Role',
                                                    roleListController
                                                        .roleList.value![index]
                                                  ]);
                                              if (res == 'success') {
                                                roleListController.roleList();
                                              }
                                            }.call()
                                          : MySnackBar(
                                                  title: 'Action Denied!',
                                                  subtitle:
                                                      'You don\'t have permission to Update Role.')
                                              .getSnackbar();
                                    },
                                    iconColor: const Color(0xFFDE0C15),
                                  ),
                                ),
                              ),
                      )
                    : const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: controller.isInit.value
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 25.0,
                ),
                child: roleListController.permissionsList.value
                        .contains('CanAddRole')
                    ? AppTextButton(
                        onPress: () async {
                          final res = await Get.to(() => NewRole(),
                              arguments: ['Add Role']);
                          if (res == 'success') {
                            roleListController.getRoleList();
                          }
                        },
                        text: 'Create New Role',
                      )
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      ),
              )
            : const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
      ),
    );
  }
}
