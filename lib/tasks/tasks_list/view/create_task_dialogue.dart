import 'package:field_force_app/tasks/new_task/new_task_screen1/view/new_task_view1.dart';
import 'package:field_force_app/tasks/tasks_list/view_model/task_list_controller.dart';
import 'package:field_force_app/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewTask extends TaskListController {
  var taskListController = Get.put(TaskListController());

  getTaskDialogue() {
    return Get.defaultDialog(
      title: "Create New Task",
      radius: 30,
      content: Padding(
        padding: EdgeInsets.all(20),
        // height: 360,
        // width: 300,
        child: Column(
          children: [
            const Text(
              'Please select the type of task you want to create. ',
              style: TextStyle(fontSize: 12, color: Color(0xffABABAB)),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              taskListController.newTaskSlectedValue!.value == 0
                                  ? const Color(0xFF002E74)
                                  : const Color(0xffE2E2E2),
                          width: 1,
                        ),
                        color: Colors.white),
                    child: InkWell(
                      onTap: () => taskListController.changeTaskValue(value: 0),
                      child: Column(
                        children: [
                          Container(
                            height: 35,
                            decoration: BoxDecoration(
                              // color: const Color(0xFFF2F5F8),
                              color: const Color(0xFFF2F5F8),
                              // color: Colors.amber,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/icons/person.png',
                                  color: const Color(0xFF002E74),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          const Text(
                            'Doctor',
                            style: TextStyle(
                                color: Color(0xff272727), fontSize: 13),
                          ),
                          const Text(
                            'Visit a doctor',
                            style: TextStyle(
                                color: Color(0xffABABAB), fontSize: 9),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => taskListController.changeTaskValue(value: 1),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color:
                                taskListController.newTaskSlectedValue!.value ==
                                        1
                                    ? const Color(0xFF002E74)
                                    : const Color(0xffE2E2E2),
                            width: 1,
                          ),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Container(
                            height: 35,
                            decoration: BoxDecoration(
                              // color: const Color(0xFFF2F5F8),
                              color: const Color(0xFFFDF2F3),
                              // color: Colors.amber,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/icons/help.png',
                                  color: const Color(0xFFDD0918),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          const Text(
                            'Other',
                            style: TextStyle(
                                color: Color(0xff272727), fontSize: 13),
                          ),
                          const Text(
                            'Other reason',
                            style: TextStyle(
                                color: Color(0xffABABAB), fontSize: 9),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: AppTextButton(
                  onPress: () {
                    taskListController.newTaskSlectedValue!.value == 0
                        ? () {
                            Get.back();
                            Get.to(() => NewTaskView1());
                          }.call()
                        : () {};
                  },
                  text: 'Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
