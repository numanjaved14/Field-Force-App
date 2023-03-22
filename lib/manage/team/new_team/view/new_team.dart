import 'package:field_force_app/manage/team/new_team/view_model/new_team_controller.dart';
import 'package:field_force_app/manage/team/team_list/view/team_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/input_text/app_text_input.dart';

class NewTeam extends GetView<NewTeamController> {
  NewTeam({super.key});

  final newTeamController = Get.put(NewTeamController());

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/appbar_back.png',
            width: 25,
            height: 18,
            // color: const Color(0xFFD4D4D4),
          ),
          onPressed: () => Get.off(TeamList()),
        ),
        title: Text(
          newTeamController.data[0],
          style: const TextStyle(
            color: Color(0xFF272727),
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color(0x10F5F5F5),
        elevation: 0.0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Obx(
                () => Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        child: AppTextInput(
                          iconColor: const Color(0xFFDE0C15),
                          iconPath: 'assets/icons/group.png',
                          labelText: 'Name',
                          editingController: newTeamController.teamName.value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "* Required";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        child: AppDescriptionTextInput(
                          iconColor: const Color(0xFFDE0C15),
                          iconPath: 'assets/icons/group.png',
                          labelText: 'Description',
                          editingController:
                              newTeamController.teamDescription.value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "* Required";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Obx(
                                () => AppTextButton(
                                  onPress: () {
                                    if (formKey.currentState!.validate()) {
                                      return newTeamController.data[0] ==
                                              'Add Team'
                                          ? newTeamController.onNewTeamPressed()
                                          // : newTeamController.initMethod();
                                          : newTeamController
                                              .onUpdateTeamPressed();
                                    }
                                  },
                                  showLoader:
                                      newTeamController.showProgress.value,
                                  disable: newTeamController.showProgress.value,
                                  text: newTeamController.data[0],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
