import 'package:field_force_app/manage/doctor/doctor_list/view_model/doctor_list_controller.dart';
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/input_text/app_text_input.dart';
import '../../../../widgets/list_item/list_item.dart';
import '../../../../widgets/no_data/no_data_view.dart';
import '../../../../widgets/others/date_container.dart';
import '../../../manage_main/view/manage_main.dart';
import '../../new_doctor/view/new_doctor.dart';

class DoctorList extends GetView<DoctorListController> {
  DoctorList({Key? key}) : super(key: key);

  var doctorListController = Get.put(DoctorListController());

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
            doctorListController.isSearch.value
                ? IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFFD4D4D4),
                    ),
                    onPressed: () {
                      doctorListController.resetSearch();
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
                      doctorListController.isSearch.value =
                          !doctorListController.isSearch.value;
                      doctorListController.searchFocus.requestFocus();
                    },
                  ),
            IconButton(
              onPressed: () {
                Get.bottomSheet(
                  // ignoreSafeArea: false,
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    color: const Color(0xFFF5F5F5),
                    child: doctorListController.cityList.value!.isEmpty
                        ? const NoData(text: 'Sorry! No Cities found.')
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                doctorListController.cityList.value!.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: ListItem(
                                title: doctorListController
                                    .cityList.value![index].name,
                                subTitle: doctorListController
                                    .cityList.value![index].shortName,
                                iconPath: 'assets/icons/city.png',
                                iconContainerColor: const Color(0x10DE0C15),
                                onPress: () {
                                  doctorListController.getDoctorList(
                                      cityId: doctorListController
                                          .cityList.value![index].id);
                                  if (Get.isBottomSheetOpen ?? false) {
                                    Get.back();
                                  }
                                },
                                iconColor: const Color(0xFFDE0C15),
                              ),
                            ),
                          ),
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                    ),
                  ),
                  // enableDrag: true,
                );
              },
              icon: Image.asset(
                'assets/icons/city.png',
                width: 25,
                height: 18,
                // color: const Color(0xFFD4D4D4),
              ),
            ),
          ],
          title: doctorListController.isSearch.value
              ? MainSearchTextInput(
                  editingController:
                      doctorListController.searchController.value,
                  hint: 'Search by Doctor Name',
                  onChange: () => doctorListController.onSearchChange(),
                  onFieldSubmit: () => doctorListController.resetSearch(),
                  focusNode: doctorListController.searchFocus,
                )
              : const Text(
                  'Doctors',
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
                child: doctorListController.hasData.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: doctorListController.doctorList.value!.isEmpty
                            ? const NoData(text: 'Sorry! No Doctor found')
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: doctorListController
                                    .doctorList.value!.length,
                                itemBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: ListItem(
                                    title: doctorListController
                                        .doctorList.value![index].name,
                                    subTitle: doctorListController.doctorList
                                        .value![index].specializationName,
                                    iconPath: 'assets/icons/doctor.png',
                                    iconContainerColor: const Color(0x10DE0C15),
                                    onPress: () {
                                      doctorListController.permissionsList.value
                                              .contains('CanUpdateDoctor')
                                          ? () async {
                                              final res = await Get.to(
                                                  () => NewDoctor(),
                                                  arguments: [
                                                    'Update Doctor',
                                                    doctorListController
                                                        .doctorList
                                                        .value![index]
                                                  ]);
                                              if (res == 'success') {
                                                doctorListController
                                                    .getDoctorList();
                                              }
                                            }.call()
                                          : MySnackBar(
                                                  title: 'Action Denied!',
                                                  subtitle:
                                                      'You don\'t have permission to Update Doctor.')
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
                child: doctorListController.permissionsList.value
                        .contains('CanAddDoctor')
                    ? AppTextButton(
                        onPress: () async {
                          String? res = await Get.to(() => NewDoctor(),
                              arguments: ['Add Doctor']);
                          if (res == 'success') {
                            doctorListController.getDoctorList();
                          }
                        },
                        text: 'Create New Doctor',
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
