import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/input_text/app_text_input.dart';
import '../../../../widgets/list_item/list_item.dart';
import '../../../../widgets/no_data/no_data_view.dart';
import '../../../../widgets/others/date_container.dart';
import '../../../manage_main/view/manage_main.dart';
import '../../new_rank/view/new_rank.dart';
import '../view_model/rank_list_controller.dart';

class RankList extends GetView<RankListController> {
  RankList({Key? key}) : super(key: key);

  var rankListController = Get.put(RankListController());

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
            rankListController.isSearch.value
                ? IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFFD4D4D4),
                    ),
                    onPressed: () {
                      rankListController.resetSearch();
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
                      rankListController.isSearch.value =
                          !rankListController.isSearch.value;
                      rankListController.searchFocus.requestFocus();
                    },
                  ),
          ],
          title: rankListController.isSearch.value
              ? MainSearchTextInput(
                  editingController: rankListController.searchController.value,
                  hint: 'Search by Rank Name',
                  onChange: () => rankListController.onSearchChange(),
                  onFieldSubmit: () => rankListController.resetSearch(),
                  focusNode: rankListController.searchFocus,
                )
              : const Text(
                  'Ranks',
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
                child: rankListController.hasData.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: rankListController.rankList.value!.isEmpty
                            ? const NoData(text: 'Sorry! No Rank found')
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount:
                                    rankListController.rankList.value!.length,
                                itemBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: ListItem(
                                    title: rankListController
                                        .rankList.value![index].name,
                                    subTitle: rankListController
                                        .rankList.value![index].description,
                                    iconPath: 'assets/icons/group.png',
                                    iconContainerColor: const Color(0x10DE0C15),
                                    onPress: () {
                                      rankListController.permissionsList.value
                                              .contains('CanUpdateDoctorRank')
                                          ? () async {
                                              final res = await Get.to(
                                                  () => NewRank(),
                                                  arguments: [
                                                    'Update Rank',
                                                    rankListController
                                                        .rankList.value![index]
                                                  ]);
                                              if (res == 'success') {
                                                rankListController
                                                    .getRankList();
                                              }
                                            }.call()
                                          : MySnackBar(
                                                  title: 'Action Denied!',
                                                  subtitle:
                                                      'You don\'t have permission to Update Rank.')
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
                child: rankListController.permissionsList.value
                        .contains('CanAddDoctorRank')
                    ? AppTextButton(
                        onPress: () async {
                          String? res = await Get.to(() => NewRank(),
                              arguments: ['Add Rank']);
                          if (res == 'success') {
                            rankListController.getRankList();
                          }
                        },
                        text: 'Create New Rank',
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
