import 'package:field_force_app/manage/doctor/doctor_list/view/doctor_list.dart';
import 'package:field_force_app/manage/team/new_team/view_model/new_team_controller.dart';
import 'package:field_force_app/manage/team/team_list/view/team_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/input_text/app_text_input.dart';
import '../view_model/new_doctor_controller.dart';

class NewDoctor extends GetView<NewDoctorController> {
  NewDoctor({super.key});

  final newDoctorController = Get.put(NewDoctorController());

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
          onPressed: () => Get.off(DoctorList()),
        ),
        title: Text(
          newDoctorController.data[0],
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
                  child: newDoctorController.hasData.value == true
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: AppTextInput(
                                iconColor: const Color(0xFFDE0C15),
                                iconPath: 'assets/icons/doctor.png',
                                labelText: 'Doctor Name',
                                editingController: newDoctorController
                                    .doctorNameController.value,
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
                              child: AppTextInput(
                                iconColor: const Color(0xFFDE0C15),
                                iconPath: 'assets/icons/doctor.png',
                                labelText: 'Mobile Number',
                                editingController: newDoctorController
                                    .contact1Controller.value,
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
                              child: AppTextInput(
                                iconColor: const Color(0xFFDE0C15),
                                iconPath: 'assets/icons/doctor.png',
                                labelText: 'Phone Number',
                                editingController: newDoctorController
                                    .contact2Controller.value,
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
                              child: AppTextInput(
                                iconColor: const Color(0xFFDE0C15),
                                iconPath: 'assets/icons/doctor.png',
                                labelText: 'PMDC Number',
                                editingController:
                                    newDoctorController.pmdcController.value,
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
                              child: AppSearchTextInput(
                                iconColor: const Color(0xffDD0918),
                                focusNode: newDoctorController.cityFocusNode,
                                suggestionFunction: () {
                                  newDoctorController.cityFocusNode.unfocus();
                                  newDoctorController.setInitId();
                                },
                                searchList:
                                    newDoctorController.citySearchList.value!
                                        .map(
                                          (e) => SearchFieldListItem(e),
                                        )
                                        .toList(),
                                iconPath: 'assets/icons/doctor.png',
                                labelText: 'City',
                                editingController: newDoctorController
                                    .cityNameController.value,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "* Required";
                                  } else if (!newDoctorController
                                      .citySearchList.value!
                                      .contains(value)) {
                                    return "Please enter valid city";
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
                              child: AppSearchTextInput(
                                iconColor: const Color(0xffDD0918),
                                focusNode: newDoctorController.rankFocusNode,
                                suggestionFunction: () {
                                  newDoctorController.rankFocusNode.unfocus();
                                  newDoctorController.setInitId();
                                },
                                searchList:
                                    newDoctorController.rankSearchList.value!
                                        .map(
                                          (e) => SearchFieldListItem(e),
                                        )
                                        .toList(),
                                iconPath: 'assets/icons/doctor.png',
                                labelText: 'Rank',
                                editingController: newDoctorController
                                    .rankNameController.value,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "* Required";
                                  } else if (!newDoctorController
                                      .rankSearchList.value!
                                      .contains(value)) {
                                    return "Please enter valid Rank";
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
                              child: AppSearchTextInput(
                                iconColor: const Color(0xffDD0918),
                                focusNode:
                                    newDoctorController.specializationFocusNode,
                                suggestionFunction: () {
                                  newDoctorController.specializationFocusNode
                                      .unfocus();
                                  newDoctorController.setInitId();
                                },
                                searchList: newDoctorController
                                    .specializationSearchList.value!
                                    .map(
                                      (e) => SearchFieldListItem(e),
                                    )
                                    .toList(),
                                iconPath: 'assets/icons/doctor.png',
                                labelText: 'Specialization',
                                editingController: newDoctorController
                                    .specializationNameController.value,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "* Required";
                                  } else if (!newDoctorController
                                      .specializationSearchList.value!
                                      .contains(value)) {
                                    return "Please enter valid Specialization";
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
                                          if (formKey.currentState!
                                              .validate()) {
                                            return newDoctorController
                                                        .data[0] ==
                                                    'Add Doctor'
                                                ? newDoctorController
                                                    .onNewDoctorPressed()
                                                // : newDoctorController.initMethod();
                                                : newDoctorController
                                                    .onUpdateDoctorPressed();
                                          }
                                        },
                                        showLoader: newDoctorController
                                            .showProgress.value,
                                        disable: newDoctorController
                                            .showProgress.value,
                                        text: newDoctorController.data[0],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator.adaptive(),
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
