import 'package:field_force_app/widgets/list_item/list_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListItem extends GetView<ListItemController> {
  const ListItem(
      {this.title,
      this.subTitle,
      this.iconPath,
      this.iconContainerColor,
      this.onPress,
      this.iconColor,
      Key? key})
      : super(key: key);

  final String? title;
  final String? subTitle;
  final String? iconPath;
  final Color? iconContainerColor;
  final Color? iconColor;
  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPress?.call(),
      child: Container(
        height: 55,
        padding: const EdgeInsets.only(
          left: 12.0,
          right: 18,
          bottom: 10,
          top: 10.0,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: const Color(0xFFE2E2E2),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    // color: const Color(0xFFF2F5F8),
                    color: iconContainerColor ?? const Color(0xFFF2F5F8),
                    // color: Colors.amber,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        iconPath ?? 'assets/icons/list.png',
                        color: iconColor ?? const Color(0xFF272727),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 11.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      title ?? '(No title)',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF272727),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        subTitle ?? '(No subtitle)',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        // softWrap: false,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Color(0x483A3A3A), // Here 48 is opacity
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Image.asset(
              'assets/icons/right_arrow.png',
              width: 6,
              height: 9,
            ),
          ],
        ),
      ),
    );
  }
}
