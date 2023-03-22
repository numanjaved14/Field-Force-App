import 'package:field_force_app/tasks/tasks_list/view/task_list.dart';
import 'package:field_force_app/widgets/others/completion_bar.dart';
import 'package:field_force_app/widgets/text/header_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../widgets/button/button.dart';
import '../../../../widgets/check_box/check_box.dart';
import '../../view_model/new_task_controller.dart';

class NewTaskView2 extends StatelessWidget {
  NewTaskView2({Key? key}) : super(key: key);

  var controller = Get.find<NewTaskController>();

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
          onPressed: () => Get.offAll(() => TaskList()),
        ),
        title: const HeaderText(label: 'New Task'),
        backgroundColor: const Color(0x10F5F5F5),
        elevation: 0.0,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 25.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextButton(
              onPress: () {
                controller.view2Next();
              },
              text: 'Next',
            ),
            const SizedBox(height: 5.0),
            AppTextButton.white(
              onPress: () {
                Get.back();
              },
              text: 'Go Back',
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              AppCompletionBar(fill: 0.3),
              CustomCheckBox(
                isChecked: false,
                onChange: () {},
                size: 30,
                iconSize: 20,
                selectedColor: Colors.blue,
                selectedIconColor: Colors.white,
                text: '',
                checkIcon: Icon(Icons.tiktok),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
