import 'package:field_force_app/manage/permission/permission_list/view_model/permission_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/input_text/app_text_input.dart';
import '../../../../widgets/list_item/list_item.dart';
import '../../../../widgets/no_data/no_data_view.dart';
import '../../../../widgets/others/date_container.dart';
import '../../../manage_main/view/manage_main.dart';

class PermissionList extends GetView<PermissionListController> {
  PermissionList({Key? key}) : super(key: key);

  var permissionListController = Get.put(PermissionListController());

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
            permissionListController.isSearch.value
                ? IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFFD4D4D4),
                    ),
                    onPressed: () {
                      permissionListController.resetSearch();
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
                      permissionListController.isSearch.value =
                          !permissionListController.isSearch.value;
                      permissionListController.searchFocus.requestFocus();
                    },
                  ),
          ],
          title: permissionListController.isSearch.value
              ? MainSearchTextInput(
                  editingController:
                      permissionListController.searchController.value,
                  hint: 'Search by Permission',
                  onChange: () => permissionListController.onSearchChange(),
                  onFieldSubmit: () => permissionListController.resetSearch(),
                  focusNode: permissionListController.searchFocus,
                )
              : const Text(
                  'Permissions',
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
                child: permissionListController.hasData.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: permissionListController
                                .permissionList.value!.isEmpty
                            ? const NoData(text: 'Sorry! No Permissions found')
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: permissionListController
                                    .permissionList.value!.length,
                                itemBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: ListItem(
                                    title: permissionListController
                                        .permissionList.value![index].name,
                                    subTitle: permissionListController
                                        .permissionList
                                        .value![index]
                                        .description,
                                    iconPath: 'assets/icons/permission.png',
                                    iconContainerColor: const Color(0x10DE0C15),
                                    onPress: () {},
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
      ),
    );
  }
}
