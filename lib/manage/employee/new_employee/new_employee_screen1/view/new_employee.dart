import 'package:field_force_app/manage/employee/employee_list/view/employee_list.dart';
import 'package:field_force_app/widgets/others/completion_bar.dart';
import 'package:field_force_app/widgets/text/header_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../widgets/button/button.dart';
import '../view_model/new_employee_controller.dart';

class NewEmployeeScreen1 extends GetView<NewEmployeeScreen1Controller> {
  const NewEmployeeScreen1({Key? key}) : super(key: key);

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
          onPressed: () => Get.off(EmployeeList()),
        ),
        title: const HeaderText(label: 'New Employee'),
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
              onPress: () {},
              text: 'Next',
            ),
            const SizedBox(height: 5.0),
            AppTextButton.white(
              onPress: () {},
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
            ],
          ),
        ),
      ),
    );
  }
}
