import 'package:field_force_app/manage/office_location/new_office_location/view/new_office_location.dart';
import 'package:field_force_app/manage/office_location/office_location_list/view_model/office_location_list_controller.dart';
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/input_text/app_text_input.dart';
import '../../../../widgets/list_item/list_item.dart';
import '../../../../widgets/no_data/no_data_view.dart';
import '../../../../widgets/others/date_container.dart';
import '../../../manage_main/view/manage_main.dart';

class OfficeLocationList extends GetView<OfficeLocationListController> {
  OfficeLocationList({Key? key}) : super(key: key);

  var officeLocationListController = Get.put(OfficeLocationListController());

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
            officeLocationListController.isSearch.value
                ? IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFFD4D4D4),
                    ),
                    onPressed: () {
                      officeLocationListController.resetSearch();
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
                      officeLocationListController.isSearch.value =
                          !officeLocationListController.isSearch.value;
                      officeLocationListController.searchFocus.requestFocus();
                    },
                  ),
          ],
          title: officeLocationListController.isSearch.value
              ? MainSearchTextInput(
                  editingController:
                      officeLocationListController.searchController.value,
                  hint: 'Search by Office Location',
                  onChange: () => officeLocationListController.onSearchChange(),
                  onFieldSubmit: () =>
                      officeLocationListController.resetSearch(),
                  focusNode: officeLocationListController.searchFocus,
                )
              : const Text(
                  'Office Locations',
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
                child: officeLocationListController.hasData.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: officeLocationListController
                                .officeLocationList.value!.isEmpty
                            ? const NoData(
                                text: 'Sorry! No Office Locations found')
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: officeLocationListController
                                    .officeLocationList.value!.length,
                                itemBuilder: (context, index) {
                                  String city = '';
                                  int cityListLength =
                                      officeLocationListController
                                          .cityList.value!.length;
                                  print(cityListLength.toString());
                                  for (int i = 0; i < cityListLength; i++) {
                                    if (officeLocationListController
                                            .cityList.value![i].id ==
                                        officeLocationListController
                                            .officeLocationList
                                            .value![index]
                                            .cityId) {
                                      city = officeLocationListController
                                          .cityList.value![i].name!;
                                    }
                                  }
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: ListItem(
                                      title: city,
                                      subTitle: officeLocationListController
                                          .officeLocationList
                                          .value![index]
                                          .address,
                                      iconPath:
                                          'assets/icons/office_location.png',
                                      iconContainerColor:
                                          const Color(0x10DE0C15),
                                      onPress: () {
                                        officeLocationListController
                                                .permissionsList.value
                                                .contains(
                                                    'CanUpdateOfficeLocation')
                                            ? () async {
                                                final res = await Get.to(
                                                    () => NewOfficeLocation(),
                                                    arguments: [
                                                      'Update Office Location',
                                                      city,
                                                      officeLocationListController
                                                          .cityList.value,
                                                      officeLocationListController
                                                          .officeLocationList
                                                          .value![index]
                                                    ]);
                                                if (res == 'success') {
                                                  officeLocationListController
                                                      .getOfficeLocationList();
                                                }
                                              }.call()
                                            : MySnackBar(
                                                    title: 'Action Denied!',
                                                    subtitle:
                                                        'You don\'t have permission to Update Office Location.')
                                                .getSnackbar();
                                      },
                                      iconColor: const Color(0xFFDE0C15),
                                    ),
                                  );
                                }),
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
                child: officeLocationListController.permissionsList.value
                        .contains('CanAddOfficeLocation')
                    ? AppTextButton(
                        onPress: () async {
                          final res = await Get.to(() => NewOfficeLocation(),
                              arguments: [
                                'Add Office Location',
                                officeLocationListController.cityList.value
                              ]);
                          if (res == 'success') {
                            officeLocationListController
                                .getOfficeLocationList();
                          }
                        },
                        text: 'Create New Office Location',
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
