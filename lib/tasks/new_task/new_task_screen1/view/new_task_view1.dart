import 'package:field_force_app/tasks/new_task/view_model/new_task_controller.dart';
import 'package:field_force_app/tasks/tasks_list/view/task_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/button/button.dart';
import '../../../../widgets/input_text/app_text_input.dart';
import '../../../../widgets/others/completion_bar.dart';

class NewTaskView1 extends GetView<NewTaskController> {
  NewTaskView1({super.key});

  final newTaskController = Get.put(NewTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: newTaskController.scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/appbar_back.png',
            width: 25,
            height: 18,
            // color: const Color(0xFFD4D4D4),
          ),
          onPressed: () => Get.off(() => TaskList()),
        ),
        title: const Text(
          'New Task',
          style: TextStyle(
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
                  key: newTaskController.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 25),
                        child: AppCompletionBar(fill: 0.1),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(left: 25, right: 25, bottom: 10),
                        child: Text(
                          'Step 1',
                          style:
                              TextStyle(color: Color(0xffABABAB), fontSize: 11),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        child: AppTextInput(
                          iconColor: const Color(0xFF002E74),
                          iconPath: 'assets/icons/list.png',
                          labelText: 'Name',
                          editingController:
                              newTaskController.taskNameController.value,
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
                          iconColor: const Color(0xFF002E74),
                          iconPath: 'assets/icons/list.png',
                          labelText: 'Description',
                          editingController:
                              newTaskController.taskDescriptionController.value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "* Required";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      // const SizedBox(height: 40),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: AppTextButton(
                                onPress: () {
                                  if (newTaskController.formKey.currentState!
                                      .validate()) {
                                    return newTaskController.view1Next();
                                  }
                                },
                                showLoader: false,
                                disable: false,
                                text: 'Next',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      )
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
