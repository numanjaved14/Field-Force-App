import 'package:field_force_app/manage/city/new_city/view/new_city.dart';
import 'package:field_force_app/manage/manage_main/view/manage_main.dart';
import 'package:field_force_app/widgets/input_text/app_text_input.dart';
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/list_item/list_item.dart';
import '../../../../widgets/no_data/no_data_view.dart';
import '../../../../widgets/others/date_container.dart';
import '../view_controller/city_list_controller.dart';

class CityList extends GetView<CityListController> {
  CityList({Key? key}) : super(key: key);

  var cityListController = Get.put(CityListController());

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
            cityListController.isSearch.value
                ? IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFFD4D4D4),
                    ),
                    onPressed: () {
                      cityListController.resetSearch();
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
                      cityListController.isSearch.value =
                          !cityListController.isSearch.value;
                      cityListController.searchFocus.requestFocus();
                    },
                  ),
          ],
          title: cityListController.isSearch.value
              ? MainSearchTextInput(
                  editingController: cityListController.searchController.value,
                  hint: 'Search by City Name',
                  onChange: () => cityListController.onSearchChange(),
                  onFieldSubmit: () => cityListController.resetSearch(),
                  focusNode: cityListController.searchFocus,
                )
              : const Text(
                  'Cities',
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
                child: cityListController.hasCountryData.value &&
                        cityListController.hasCityData.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: cityListController.cityList.value!.isEmpty
                            ? const NoData(text: 'Sorry! No City found')
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount:
                                    cityListController.cityList.value!.length,
                                itemBuilder: (context, index) {
                                  String country = '';
                                  int countryListLength = cityListController
                                      .countryList.value!.length;
                                  for (int i = 0; i < countryListLength; i++) {
                                    if (cityListController
                                            .cityList.value![index].countryId ==
                                        cityListController
                                            .countryList.value![i].id) {
                                      country = cityListController
                                          .countryList.value![i].name!;
                                    }
                                  }
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: ListItem(
                                      title: cityListController
                                          .cityList.value![index].name,
                                      subTitle: country,
                                      iconPath: 'assets/icons/city.png',
                                      iconContainerColor:
                                          const Color(0x10DE0C15),
                                      onPress: () {
                                        cityListController.permissionsList.value
                                                .contains('CanUpdateCity')
                                            ? () async {
                                                final res = await Get.to(
                                                    () => NewCity(),
                                                    arguments: [
                                                      'Update City',
                                                      cityListController
                                                          .cityList
                                                          .value![index]
                                                    ]);
                                                if (res == 'success') {
                                                  cityListController
                                                      .getCityList();
                                                }
                                              }.call()
                                            : MySnackBar(
                                                    title: 'Action Denied!',
                                                    subtitle:
                                                        'You don\'t have permission to Update Team.')
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
                child: cityListController.permissionsList.value
                        .contains('CanAddCity')
                    ? AppTextButton(
                        onPress: () async {
                          final res = await Get.to(() => NewCity(),
                              arguments: ['Add City']);
                          if (res == 'success') {
                            cityListController.getCityList();
                          }
                        },
                        text: 'Create New City',
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
