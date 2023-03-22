import 'package:field_force_app/home/view_model/home_menu_controller.dart';
import 'package:field_force_app/manage/manage_main/view/manage_main.dart';
import 'package:field_force_app/widgets/list_item/list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../tasks/tasks_main/view/tasks_main.dart';

class HomeMenu extends GetView<HomeMenuController> {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ListItem(
            title: 'Tasks',
            subTitle: 'My Tasks, Team, Locate...',
            iconPath: 'assets/icons/list.png',
            iconContainerColor: const Color(0x10002E74),
            onPress: () => onPress(index),
            iconColor: const Color(0xFF002E74),
          );
        }
        if (index == 1) {
          return ListItem(
            title: 'Manage',
            subTitle: 'Employee, Roles, Permission...',
            iconPath: 'assets/icons/group.png',
            iconContainerColor: const Color(0x10DE0C15),
            onPress: () => onPress(index),
            iconColor: const Color(0xFFDE0C15),
          );
        }
        if (index == 2) {
          return ListItem(
            title: 'Invoice',
            subTitle: 'New Invoice, Update Invoice...',
            iconPath: 'assets/icons/invoice.png',
            iconContainerColor: const Color(0x10FFB20A),
            onPress: onPress,
            iconColor: const Color(0xFFFFB20A),
          );
        }
        if (index == 3) {
          return ListItem(
            title: 'Billing',
            subTitle: 'Pending, Previous...',
            iconPath: 'assets/icons/billing.png',
            iconContainerColor: const Color(0x1000852C),
            onPress: onPress,
            iconColor: const Color(0xFF00852C),
          );
        }
        if (index == 4) {
          return ListItem(
            title: 'Reports',
            subTitle: 'View reports...',
            iconPath: 'assets/icons/reports.png',
            iconContainerColor: const Color(0x10002E74),
            onPress: () => onPress(index),
            iconColor: const Color(0xFF002E74),
          );
        }
        return ListItem(
          title: 'Tasks',
          subTitle: 'My Tasks, Team, Locate...',
          iconPath: 'assets/icons/list.png',
          iconContainerColor: const Color(0x10002E74),
          onPress: () => onPress(index),
          iconColor: const Color(0xFF002E74),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
    );
  }

  void onPress(index) {
    if (index == 0) {
      Get.to(() => const TasksMain());
    } else if (index == 1) {
      Get.to(() => ManageMain());
    }
  }
}
