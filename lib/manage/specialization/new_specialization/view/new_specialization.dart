import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/input_text/app_text_input.dart';
import '../../specialization_list/view/specialization_list.dart';
import '../view_model/new_specialization_controller.dart';

class NewSpecialization extends GetView<NewSpecializationController> {
  NewSpecialization({super.key});

  final newSpecializationController = Get.put(NewSpecializationController());

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
          onPressed: () => Get.off(SpecializationList()),
        ),
        title: Text(
          newSpecializationController.data[0],
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
                          iconPath: 'assets/icons/stethoscope.png',
                          labelText: 'Name',
                          editingController: newSpecializationController
                              .specializationName.value,
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
                          iconPath: 'assets/icons/stethoscope.png',
                          labelText: 'Description',
                          editingController: newSpecializationController
                              .specializationDescription.value,
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
                                      return newSpecializationController
                                                  .data[0] ==
                                              'Add specialization'
                                          ? newSpecializationController
                                              .onNewSpecializationPressed()
                                          // : NewSpecializationController.initMethod();
                                          : newSpecializationController
                                              .onUpdateSpecializationPressed();
                                    }
                                  },
                                  showLoader: newSpecializationController
                                      .showProgress.value,
                                  disable: newSpecializationController
                                      .showProgress.value,
                                  text: newSpecializationController.data[0],
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
