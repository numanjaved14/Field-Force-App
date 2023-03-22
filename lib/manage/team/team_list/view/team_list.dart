import 'package:field_force_app/manage/team/new_team/view/new_team.dart';
import 'package:field_force_app/manage/team/team_list/view_model/team_list_controller.dart';
import 'package:field_force_app/widgets/no_data/no_data_view.dart';
import 'package:field_force_app/widgets/others/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/input_text/app_text_input.dart';
import '../../../../widgets/list_item/list_item.dart';
import '../../../../widgets/others/date_container.dart';
import '../../../manage_main/view/manage_main.dart';

class TeamList extends GetView<TeamListController> {
  TeamList({Key? key}) : super(key: key);

  var teamListController = Get.put(TeamListController());

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
            teamListController.isSearch.value
                ? IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFFD4D4D4),
                    ),
                    onPressed: () {
                      teamListController.resetSearch();
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
                      teamListController.isSearch.value =
                          !teamListController.isSearch.value;
                      teamListController.searchFocus.requestFocus();
                    },
                  ),
          ],
          title: teamListController.isSearch.value
              ? MainSearchTextInput(
                  editingController: teamListController.searchController.value,
                  hint: 'Search by Team Name',
                  onChange: () => teamListController.onSearchChange(),
                  onFieldSubmit: () => teamListController.resetSearch(),
                  focusNode: teamListController.searchFocus,
                )
              : const Text(
                  'Teams',
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
                child: teamListController.hasData.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: teamListController.teamList.value!.isEmpty
                            ? const NoData(text: 'Sorry! No Team found')
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount:
                                    teamListController.teamList.value!.length,
                                itemBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: ListItem(
                                    title: teamListController
                                        .teamList.value![index].name,
                                    subTitle: teamListController
                                        .teamList.value![index].description,
                                    iconPath: 'assets/icons/group.png',
                                    iconContainerColor: const Color(0x10DE0C15),
                                    onPress: () {
                                      teamListController.permissionsList.value
                                              .contains('CanUpdateTeam')
                                          ? () async {
                                              final res = await Get.to(
                                                  () => NewTeam(),
                                                  arguments: [
                                                    'Update Team',
                                                    teamListController
                                                        .teamList.value![index]
                                                  ]);
                                              if (res == 'success') {
                                                teamListController
                                                    .getTeamList();
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
                child: teamListController.permissionsList.value
                        .contains('CanAddTeam')
                    ? AppTextButton(
                        onPress: () async {
                          String? res = await Get.to(() => NewTeam(),
                              arguments: ['Add Team']);
                          if (res == 'success') {
                            teamListController.getTeamList();
                          }
                        },
                        text: 'Create New Team',
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
