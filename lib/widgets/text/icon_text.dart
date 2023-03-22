import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText({
    Key? key,
    this.iconPath,
    this.iconColor,
    this.text,
  }) : super(key: key);

  final String? iconPath;
  final Color? iconColor;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          // 'assets/icons/location.png',
          iconPath ?? 'assets/icons/location.png',
          height: 13.0,
          width: 11.0,
          color: iconColor ?? const Color(0xFF002E74),
        ),
        const SizedBox(width: 5.0),
        SizedBox(
          width: 70,
          child: Text(
            text ?? '(title)',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              color: Color(0x483A3A3A),
              fontSize: 9.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
