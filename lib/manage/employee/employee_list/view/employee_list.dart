import 'package:field_force_app/manage/employee/employee_list/view_model/employee_list_controller.dart';
import 'package:field_force_app/manage/employee/new_employee/new_employee_screen1/view/new_employee.dart';
import 'package:field_force_app/widgets/button/button.dart';
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/input_text/app_text_input.dart';
import '../../../../widgets/list_item/list_item.dart';
import '../../../../widgets/no_data/no_data_view.dart';
import '../../../../widgets/others/date_container.dart';
import '../../../../widgets/text/header_text.dart';
import '../../../manage_main/view/manage_main.dart';

class EmployeeList extends GetView<EmployeeListController> {
  EmployeeList({Key? key}) : super(key: key);

  var employeeListController = Get.put(EmployeeListController());

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
            employeeListController.isSearch.value
                ? IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFFD4D4D4),
                    ),
                    onPressed: () {
                      employeeListController.resetSearch();
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
                      employeeListController.isSearch.value =
                          !employeeListController.isSearch.value;
                      employeeListController.searchFocus.requestFocus();
                    },
                  ),
          ],
          title: employeeListController.isSearch.value
              ? MainSearchTextInput(
                  editingController:
                      employeeListController.searchController.value,
                  hint: 'Search by Employee Name',
                  onChange: () => employeeListController.onSearchChange(),
                  onFieldSubmit: () => employeeListController.resetSearch(),
                  focusNode: employeeListController.searchFocus,
                )
              : const Text(
                  'Employee',
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
                child: employeeListController.hasData.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: employeeListController
                                .employeeList.value!.isEmpty
                            ? const NoData(text: 'Sorry! No Employee found')
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: employeeListController
                                    .employeeList.value!.length,
                                itemBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: ListItem(
                                    title: employeeListController
                                        .employeeList.value![index].firstName,
                                    subTitle: employeeListController
                                        .employeeList
                                        .value![index]
                                        .employmentStatusName,
                                    iconPath: 'assets/icons/person.png',
                                    iconContainerColor: const Color(0x10DE0C15),
                                    onPress: () {
                                      employeeListController
                                              .permissionsList.value
                                              .contains('CanUpdateEmployee')
                                          ? () async {
                                              // final res = await Get.to(
                                              //     () => NewEmployee(),
                                              //     arguments: [
                                              //       'Update Employee',
                                              //       employeeListController
                                              //           .depList.value![index]
                                              //     ]);
                                              // if (res == 'success') {
                                              //   employeeListController.getDepList();
                                              // }
                                            }
                                              .call()
                                          : MySnackBar(
                                                  title: 'Action Denied!',
                                                  subtitle:
                                                      'You don\'t have permission to Update Employee.')
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
                child: employeeListController.permissionsList.value
                        .contains('CanAddEmployee')
                    ? AppTextButton(
                        onPress: () async {
                          final res = await Get.to(() => NewEmployeeScreen1(),
                              arguments: ['Add Employee']);
                          if (res == 'success') {
                            employeeListController.getDepList();
                          }
                        },
                        text: 'Create New Employee',
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
