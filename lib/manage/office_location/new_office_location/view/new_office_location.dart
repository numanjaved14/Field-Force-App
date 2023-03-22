import 'package:field_force_app/manage/office_location/office_location_list/view/office_location_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/input_text/app_text_input.dart';
import '../view_model/new_office_location_controller.dart';

class NewOfficeLocation extends GetView<NewOfficeLocationController> {
  NewOfficeLocation({super.key});

  final newOfficeLocationController = Get.put(NewOfficeLocationController());

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
            onPressed: () => Get.off(OfficeLocationList()),
          ),
          title: Text(
            newOfficeLocationController.data[0],
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
                child: Form(
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
                          iconColor: const Color(0xffDD0918),
                          iconPath: 'assets/icons/location.png',
                          labelText: 'Address',
                          editingController:
                              newOfficeLocationController.address.value,
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
                          iconColor: const Color(0xffDD0918),
                          iconPath: 'assets/icons/phone.png',
                          labelText: 'Mobile Number',
                          editingController:
                              newOfficeLocationController.mobileNumber.value,
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
                        child: AppSearchTextInput(
                          iconColor: const Color(0xffDD0918),
                          focusNode: focusNode,
                          suggestionFunction: () {
                            // print(newOfficeLocationController
                            //     .depDescription.value.text);
                            // Get.snackbar('title', 'message');
                            // newOfficeLocationController.depDescription.value
                            //     .clear();
                            focusNode.unfocus();
                          },
                          searchList:
                              newOfficeLocationController.cityList.value!
                                  .map(
                                    (e) => SearchFieldListItem(e),
                                  )
                                  .toList(),
                          iconPath: 'assets/icons/city.png',
                          labelText: 'City',
                          editingController:
                              newOfficeLocationController.city.value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "* Required";
                            } else if (!newOfficeLocationController
                                .cityList.value!
                                .contains(value)) {
                              return "Please enter valid city";
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
                                      return newOfficeLocationController
                                                  .data[0] ==
                                              'Add Office Location'
                                          ? newOfficeLocationController
                                              .onNewOfficeLocationPressed()
                                          // : NewDepartmentController.initMethod();
                                          : newOfficeLocationController
                                              .onUpdateOfficeLocationPressed();
                                    }
                                  },
                                  showLoader: newOfficeLocationController
                                      .showProgress.value,
                                  disable: newOfficeLocationController
                                      .showProgress.value,
                                  text: newOfficeLocationController.data[0],
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
        ));
  }
}
