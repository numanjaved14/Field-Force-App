import 'package:field_force_app/tasks/tasks_list/view/create_task_dialogue.dart';
import 'package:field_force_app/tasks/tasks_list/view/task_list_item.dart';
import 'package:field_force_app/tasks/tasks_main/view/tasks_main.dart';
import 'package:field_force_app/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/others/date_container.dart';
import '../view_model/task_list_controller.dart';

class TaskList extends GetView<TaskListController> {
  TaskList({Key? key}) : super(key: key);

  final taskListController = Get.put(TaskListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/appbar_back.png',
            width: 25,
            height: 18,
          ),
          onPressed: () => Get.off(const TasksMain()),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icons/filter.png',
              width: 25,
              height: 18,
              // color: const Color(0xFFD4D4D4),
            ),
            // onPressed: () => Scaffold.of(context).openEndDrawer(),
            onPressed: taskListController.openDrawer,
          )
        ],
        title: const Text(
          'My Tasks',
          style: TextStyle(
            color: Color(0xFF272727),
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color(0x10F5F5F5),
        elevation: 0.0,
      ),
      key: taskListController.scaffoldKey,
      endDrawer: Drawer(
        // width: 200,
        elevation: 10.0,
        backgroundColor: Colors.amber,
        child: ListView(
          // padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: taskListController.closeDrawer,
            )
          ],
        ),
      ),
      body: Obx(
        () => Column(
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
            taskListController.hasData.value
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 25.0,
                        top: 25.0,
                        bottom: 10.0,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: taskListController.taskList.value!.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TaskListItem(
                            doctor: taskListController
                                .taskList.value![index].doctorName,
                            status: taskListController
                                .taskList.value![index].taskStatusName,
                            specialization: taskListController
                                .taskList.value![index].taskPriorityName,
                            location: taskListController
                                .taskList.value![index].practiceLocationName,
                            assignedTo: taskListController
                                .taskList.value![index].assigneeName,
                            time: taskListController
                                .taskList.value![index].lastUpdateStatusTime,
                            onPress: () {},
                          ),
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Loading Tasks',
                      strokeWidth: 2.0,
                      color: Color(0x483A3A3A),
                    ),
                  ),
            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: AppTextButton(
                  onPress: () {
                    CreateNewTask().getTaskDialogue();
                  },
                  text: 'Create New Task'),
            ),
            SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }
}
