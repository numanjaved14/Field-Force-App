import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/input_text/app_text_input.dart';
import '../../../../widgets/list_item/list_item.dart';
import '../../../../widgets/no_data/no_data_view.dart';
import '../../../../widgets/others/date_container.dart';
import '../../../manage_main/view/manage_main.dart';
import '../../new_specialization/view/new_specialization.dart';
import '../view_model/specialization_list_controller.dart';

class SpecializationList extends GetView<SpecializationListController> {
  SpecializationList({Key? key}) : super(key: key);

  var specializationListController = Get.put(SpecializationListController());

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
            specializationListController.isSearch.value
                ? IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFFD4D4D4),
                    ),
                    onPressed: () {
                      specializationListController.resetSearch();
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
                      specializationListController.isSearch.value =
                          !specializationListController.isSearch.value;
                      specializationListController.searchFocus.requestFocus();
                    },
                  ),
          ],
          title: specializationListController.isSearch.value
              ? MainSearchTextInput(
                  editingController:
                      specializationListController.searchController.value,
                  hint: 'Search by Specialization',
                  onChange: () => specializationListController.onSearchChange(),
                  onFieldSubmit: () =>
                      specializationListController.resetSearch(),
                  focusNode: specializationListController.searchFocus,
                )
              : const Text(
                  'Specializations',
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
                child: specializationListController.hasData.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: specializationListController
                                .specializationList.value!.isEmpty
                            ? const NoData(
                                text: 'Sorry! No Specialization found')
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: specializationListController
                                    .specializationList.value!.length,
                                itemBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: ListItem(
                                    title: specializationListController
                                        .specializationList.value![index].name,
                                    subTitle: specializationListController
                                        .specializationList
                                        .value![index]
                                        .description,
                                    iconPath: 'assets/icons/stethoscope.png',
                                    iconContainerColor: const Color(0x10DE0C15),
                                    onPress: () {
                                      specializationListController
                                              .permissionsList.value
                                              .contains(
                                                  'CanUpdateDoctorSpecialization')
                                          ? () async {
                                              final res = await Get.to(
                                                  () => NewSpecialization(),
                                                  arguments: [
                                                    'Update specialization',
                                                    specializationListController
                                                        .specializationList
                                                        .value![index]
                                                  ]);
                                              if (res == 'success') {
                                                specializationListController
                                                    .getSpecilizationList();
                                              }
                                            }.call()
                                          : MySnackBar(
                                                  title: 'Action Denied!',
                                                  subtitle:
                                                      'You don\'t have permission to Update Specialization.')
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
                child: specializationListController.permissionsList.value
                        .contains('CanAddDoctorSpecialization')
                    ? AppTextButton(
                        onPress: () async {
                          final res = await Get.to(() => NewSpecialization(),
                              arguments: ['Add specialization']);
                          if (res == 'success') {
                            specializationListController.getSpecilizationList();
                          }
                        },
                        text: 'Create New specialization',
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

// stethoscope
