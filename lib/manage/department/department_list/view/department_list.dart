import 'package:field_force_app/manage/department/department_list/view_model/department_list_controller.dart';
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/input_text/app_text_input.dart';
import '../../../../widgets/list_item/list_item.dart';
import '../../../../widgets/no_data/no_data_view.dart';
import '../../../../widgets/others/date_container.dart';
import '../../../manage_main/view/manage_main.dart';
import '../../new_department/view/new_department.dart';

class DepartmentList extends GetView<DepartmentListController> {
  DepartmentList({Key? key}) : super(key: key);

  var depListController = Get.put(DepartmentListController());

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
            depListController.isSearch.value
                ? IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFFD4D4D4),
                    ),
                    onPressed: () {
                      depListController.resetSearch();
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
                      depListController.isSearch.value =
                          !depListController.isSearch.value;
                      depListController.searchFocus.requestFocus();
                    },
                  ),
          ],
          title: depListController.isSearch.value
              ? MainSearchTextInput(
                  editingController: depListController.searchController.value,
                  hint: 'Search by Departments Name',
                  onChange: () => depListController.onSearchChange(),
                  onFieldSubmit: () => depListController.resetSearch(),
                  focusNode: depListController.searchFocus,
                )
              : const Text(
                  'Departments',
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
                child: depListController.hasData.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: depListController.depList.value!.isEmpty
                            ? const NoData(text: 'Sorry! No Department found')
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount:
                                    depListController.depList.value!.length,
                                itemBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: ListItem(
                                    title: depListController
                                        .depList.value![index].name,
                                    subTitle: depListController
                                        .depList.value![index].description,
                                    iconPath: 'assets/icons/department.png',
                                    iconContainerColor: const Color(0x10DE0C15),
                                    onPress: () {
                                      depListController.permissionsList.value
                                              .contains('CanUpdateDepartment')
                                          ? () async {
                                              final res = await Get.to(
                                                  () => NewDepartment(),
                                                  arguments: [
                                                    'Update Department',
                                                    depListController
                                                        .depList.value![index]
                                                  ]);
                                              if (res == 'success') {
                                                depListController.getDepList();
                                              }
                                            }.call()
                                          : MySnackBar(
                                                  title: 'Action Denied!',
                                                  subtitle:
                                                      'You don\'t have permission to Update Department.')
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
                child: depListController.permissionsList.value
                        .contains('CanAddDepartment')
                    ? AppTextButton(
                        onPress: () async {
                          final res = await Get.to(() => NewDepartment(),
                              arguments: ['Add Department']);
                          if (res == 'success') {
                            depListController.getDepList();
                          }
                        },
                        text: 'Create New Department',
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
