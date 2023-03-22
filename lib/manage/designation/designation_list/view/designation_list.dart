import 'package:field_force_app/manage/designation/new_designation/view/new_designation.dart';
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/input_text/app_text_input.dart';
import '../../../../widgets/list_item/list_item.dart';
import '../../../../widgets/no_data/no_data_view.dart';
import '../../../../widgets/others/date_container.dart';
import '../../../manage_main/view/manage_main.dart';
import '../view_model/designation_list_controller.dart';

class DesignationList extends GetView<DesignationListController> {
  DesignationList({Key? key}) : super(key: key);

  var designationListController = Get.put(DesignationListController());

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
            designationListController.isSearch.value
                ? IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFFD4D4D4),
                    ),
                    onPressed: () {
                      designationListController.resetSearch();
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
                      designationListController.isSearch.value =
                          !designationListController.isSearch.value;
                      designationListController.searchFocus.requestFocus();
                    },
                  ),
          ],
          title: designationListController.isSearch.value
              ? MainSearchTextInput(
                  editingController:
                      designationListController.searchController.value,
                  hint: 'Search by Designations Name',
                  onChange: () => designationListController.onSearchChange(),
                  onFieldSubmit: () => designationListController.resetSearch(),
                  focusNode: designationListController.searchFocus,
                )
              : const Text(
                  'Designations',
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
                child: designationListController.hasData.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: designationListController.desList.value!.isEmpty
                            ? const NoData(text: 'Sorry! No Designation found')
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: designationListController
                                    .desList.value!.length,
                                itemBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: ListItem(
                                    title: designationListController
                                        .desList.value![index].shortName,
                                    subTitle: designationListController
                                        .desList.value![index].name,
                                    iconPath: 'assets/icons/designation.png',
                                    iconContainerColor: const Color(0x10DE0C15),
                                    onPress: () {
                                      designationListController
                                              .permissionsList.value
                                              .contains('CanUpdateDesignation')
                                          ? () async {
                                              final res = await Get.to(
                                                  () => NewDesignation(),
                                                  arguments: [
                                                    'Update Designation',
                                                    designationListController
                                                        .desList.value![index]
                                                  ]);
                                              if (res == 'success') {
                                                designationListController
                                                    .getPermissionInit();
                                              }
                                            }.call()
                                          : MySnackBar(
                                                  title: 'Action Denied!',
                                                  subtitle:
                                                      'You don\'t have permission to Update Designation.')
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
                child: designationListController.permissionsList.value
                        .contains('CanAddDesignation')
                    ? AppTextButton(
                        onPress: () async {
                          final res = await Get.to(() => NewDesignation(),
                              arguments: ['Add Designation']);
                          if (res == 'success') {
                            designationListController.getPermissionInit();
                          }
                        },
                        text: 'Create New Designation',
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
