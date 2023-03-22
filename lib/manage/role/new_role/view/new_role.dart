import 'package:field_force_app/widgets/list_item/chip_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/input_text/app_text_input.dart';
import '../../role_list/view/role_list.dart';
import '../view_model/new_role_controller.dart';

class NewRole extends GetView<NewRoleController> {
  NewRole({super.key});

  final newRoleController = Get.put(NewRoleController());

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();

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
          onPressed: () => Get.off(RoleList()),
        ),
        title: Text(
          newRoleController.data[0],
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
                () => newRoleController.hasData.value
                    ? Form(
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
                                iconPath: 'assets/icons/role.png',
                                labelText: 'Name',
                                editingController:
                                    newRoleController.roleName.value,
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
                                iconPath: 'assets/icons/role.png',
                                labelText: 'Description',
                                editingController:
                                    newRoleController.roleDescription.value,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "* Required";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: AppSearchTextInput(
                                iconColor: const Color(0xffDD0918),
                                focusNode: focusNode,
                                suggestionFunction: () {
                                  newRoleController.setPermissionInSentList();
                                  newRoleController.searchPermission.value
                                      .clear();
                                  focusNode.unfocus();
                                },
                                searchList: newRoleController
                                    .permissionSearchList.value!
                                    .map(
                                      (e) => SearchFieldListItem(e),
                                    )
                                    .toList(),
                                iconPath: 'assets/icons/role.png',
                                labelText: 'Permission',
                                editingController:
                                    newRoleController.searchPermission.value,
                                validator: (value) {
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 40),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: newRoleController
                                    .roleListSent.value!.length,
                                itemBuilder: (context, index) => ChipListItem(
                                  text: newRoleController.roleListSent
                                      .value![index].permissionName!,
                                  onTap: () => newRoleController
                                      .deletaItemPermissionInSentList(
                                          index: index),
                                ),
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
                                            return newRoleController.data[0] ==
                                                    'Add Role'
                                                ? newRoleController
                                                    .onNewRolePressed()
                                                // : NewRoleController.initMethod();
                                                : newRoleController
                                                    .onUpdateRolePressed();
                                          }
                                        },
                                        showLoader: newRoleController
                                            .showProgress.value,
                                        disable: newRoleController
                                            .showProgress.value,
                                        text: newRoleController.data[0],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
