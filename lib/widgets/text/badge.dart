import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  const Badge(
    this.text, {
    super.key,
    this.color,
    this.textColor,
  });

  final Color? color;
  final Color? textColor;
  final String? text;

  const Badge.greenAlpha(
    this.text, {
    super.key,
    this.textColor = const Color(0xFF00852C),
  }) : color = const Color(0x1000852C);

  const Badge.bluAlpha(
    this.text, {
    super.key,
    this.textColor = const Color(0xFF002E74),
  }) : color = const Color(0x10002E74);

  const Badge.amberAlpha(
    this.text, {
    super.key,
    this.textColor = const Color(0xFFEEA300),
  }) : color = const Color(0x10EEA300);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 35,
      decoration: BoxDecoration(
        // color: const Color(0xFFF2F5F8),
        color: color ?? const Color(0x1000852C),
        // color: Colors.amber,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 6.0,
          ),
          child: Text(
            text ?? 'Created',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: textColor ?? const Color(0xFF00852C),
            ),
          ),
        ),
      ),
    );
  }
}
