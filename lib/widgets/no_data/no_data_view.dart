import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({required this.text, super.key});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Image.asset(
            'assets/icons/no_data.png',
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          text!,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Color(0xFF272727),
          ),
        ),
      ],
    );
  }
}
