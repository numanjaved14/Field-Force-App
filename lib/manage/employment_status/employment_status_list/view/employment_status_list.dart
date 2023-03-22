import 'package:field_force_app/manage/employment_status/employment_status_list/view_model/employment_status_list_controller.dart';
import 'package:field_force_app/manage/employment_status/new_employment_status/view/new_employment_status.dart';
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/input_text/app_text_input.dart';
import '../../../../widgets/list_item/list_item.dart';
import '../../../../widgets/no_data/no_data_view.dart';
import '../../../../widgets/others/date_container.dart';
import '../../../manage_main/view/manage_main.dart';

class EmploymentStatusList extends GetView<EmploymentStatusListController> {
  EmploymentStatusList({Key? key}) : super(key: key);

  var empStatListController = Get.put(EmploymentStatusListController());

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
            empStatListController.isSearch.value
                ? IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFFD4D4D4),
                    ),
                    onPressed: () {
                      empStatListController.resetSearch();
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
                      empStatListController.isSearch.value =
                          !empStatListController.isSearch.value;
                      empStatListController.searchFocus.requestFocus();
                    },
                  ),
          ],
          title: empStatListController.isSearch.value
              ? MainSearchTextInput(
                  editingController:
                      empStatListController.searchController.value,
                  hint: 'Search by Employment Statuses',
                  onChange: () => empStatListController.onSearchChange(),
                  onFieldSubmit: () => empStatListController.resetSearch(),
                  focusNode: empStatListController.searchFocus,
                )
              : const Text(
                  'Employment Statuses',
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
                child: empStatListController.hasData.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: empStatListController.empStatList.value!.isEmpty
                            ? const NoData(
                                text: 'Sorry! No Employees Status found')
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: empStatListController
                                    .empStatList.value!.length,
                                itemBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: ListItem(
                                    title: empStatListController
                                        .empStatList.value![index].name,
                                    subTitle: empStatListController
                                        .empStatList.value![index].description,
                                    iconPath:
                                        'assets/icons/employment_status.png',
                                    iconContainerColor: const Color(0x10DE0C15),
                                    onPress: () {
                                      empStatListController
                                              .permissionsList.value
                                              .contains(
                                                  'CanUpdateEmploymentStatus')
                                          ? () async {
                                              final res = await Get.to(
                                                  () => NewEmploymentStatus(),
                                                  arguments: [
                                                    'Update Employment Status',
                                                    empStatListController
                                                        .empStatList
                                                        .value![index]
                                                  ]);
                                              if (res == 'success') {
                                                empStatListController
                                                    .getEmpStatList();
                                              }
                                            }.call()
                                          : MySnackBar(
                                                  title: 'Action Denied!',
                                                  subtitle:
                                                      'You don\'t have permission to Update employment status.')
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
                child: empStatListController.permissionsList.value
                        .contains('CanAddEmploymentStatus')
                    ? AppTextButton(
                        onPress: () async {
                          final res = await Get.to(() => NewEmploymentStatus(),
                              arguments: ['Add Employment Status']);
                          if (res == 'success') {
                            empStatListController.getEmpStatList();
                          }
                        },
                        text: 'Create New Employment Status',
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
