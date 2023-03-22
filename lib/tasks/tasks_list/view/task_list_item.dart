import 'package:field_force_app/widgets/text/badge.dart' as badge;
import 'package:field_force_app/widgets/text/icon_text.dart';
import 'package:flutter/material.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    Key? key,
    this.onPress,
    this.doctor,
    this.specialization,
    this.location,
    this.assignedTo,
    this.time,
    this.status,
  }) : super(key: key);

  final String? doctor;
  final String? specialization;
  final String? location;
  final String? assignedTo;
  final String? time;
  final String? status;
  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPress?.call(),
      child: Container(
        // height: 80,
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 12.0,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: const Color(0xFFE2E2E2),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(width: 7.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 125,
                      child: Text(
                        doctor ?? 'Dr. ?',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF272727),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      specialization ?? 'None',
                      // softWrap: false,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0x483A3A3A), // Here 48 is opacity
                      ),
                    ),
                  ],
                ),
                // const SizedBox(width: 5.0),
                badge.Badge.greenAlpha(status ?? '!status!'),
                const SizedBox(width: 30.0),
                Expanded(
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Image.asset(
                      'assets/icons/menu_horizontal.png',
                      width: 16,
                      height: 4,
                      // color: const Color(0xFFD4D4D4),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            const SizedBox(height: 20.0),
            //Bottom Row
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconText(
                    iconPath: 'assets/icons/location.png',
                    text: location ?? 'None',
                  ),
                  const SizedBox(width: 5.0),
                  Container(
                    width: 1,
                    color: const Color(0x483A3A3A),
                  ),
                  const SizedBox(width: 5.0),
                  IconText(
                    iconPath: 'assets/icons/person_simple.png',
                    text: assignedTo ?? 'None',
                  ),
                  const SizedBox(width: 5.0),
                  Container(
                    width: 1,
                    color: const Color(0x483A3A3A),
                  ),
                  const SizedBox(width: 5.0),
                  IconText(
                    iconPath: 'assets/icons/time.png',
                    text: time ?? '00:00:00 AM',
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
