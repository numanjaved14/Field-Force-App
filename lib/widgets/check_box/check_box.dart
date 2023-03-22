import 'package:field_force_app/widgets/check_box/check_box_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCheckBox extends GetView<CheckBoxController> {
  var checkBoxContolelr = Get.put(CheckBoxController());

  final Function onChange;
  final bool isChecked;
  final double size;
  final double iconSize;
  final Color selectedColor;
  final Color selectedIconColor;
  final Icon checkIcon;
  final String text;

  CustomCheckBox({
    required this.isChecked,
    required this.onChange,
    required this.size,
    required this.iconSize,
    required this.selectedColor,
    required this.selectedIconColor,
    required this.text,
    required this.checkIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          checkBoxContolelr.isSelected.value =
              !checkBoxContolelr.isSelected.value;
          onChange(checkBoxContolelr.isSelected.value);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              margin: const EdgeInsets.all(4),
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastLinearToSlowEaseIn,
              decoration: BoxDecoration(
                color: checkBoxContolelr.isSelected.value
                    ? selectedColor
                    : const Color(0xffF2F4F7),
                borderRadius: BorderRadius.circular(3.0),
                // border: Border.all(
                //   color: widget.borderColor,
                //   width: 1.5,
                // )
              ),
              width: size,
              height: size,
              child: checkBoxContolelr.isSelected.value
                  ? Icon(
                      Icons.check,
                      color: selectedIconColor,
                      size: iconSize,
                    )
                  : null,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: checkBoxContolelr.isSelected.value
                    ? const Color(0xff000000)
                    : const Color(0xffABABAB),
              ),
            )
          ],
        ),
      ),
    );
  }
}
