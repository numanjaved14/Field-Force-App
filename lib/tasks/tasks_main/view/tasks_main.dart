import 'package:field_force_app/home/view/home.dart';
import 'package:field_force_app/widgets/list_item/list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/others/date_container.dart';
import '../../tasks_list/view/task_list.dart';
import '../view_model/task_main_controller.dart';

class TasksMain extends GetView<TasksMainController> {
  const TasksMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/appbar_back.png',
            width: 25,
            height: 18,
            // color: const Color(0xFFD4D4D4),
          ),
          onPressed: () => Get.off(Home()),
        ),
        title: const Text(
          'Tasks',
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
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListItem(
                    title: 'My Tasks',
                    subTitle: 'View my tasks only',
                    iconPath: 'assets/icons/list.png',
                    iconContainerColor: const Color(0x10002E74),
                    onPress: () => Get.to(() => TaskList()),
                    iconColor: const Color(0xFF002E74),
                  ),
                  const SizedBox(height: 16),
                  ListItem(
                    title: 'Team',
                    subTitle: 'View my team tasks',
                    iconPath: 'assets/icons/group.png',
                    iconContainerColor: const Color(0x10002E74),
                    onPress: () => Get.to(() => TaskList()),
                    iconColor: const Color(0xFF002E74),
                  ),
                  const SizedBox(height: 16),
                  ListItem(
                    title: 'Locate',
                    subTitle: 'Locate my team on map',
                    iconPath: 'assets/icons/locate.png',
                    iconContainerColor: const Color(0x10002E74),
                    onPress: () => {},
                    iconColor: const Color(0xFF002E74),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
