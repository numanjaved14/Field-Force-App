import 'package:flutter/material.dart';

class AppCompletionBar extends StatelessWidget {
  AppCompletionBar({required this.fill, super.key});

// Maximum value is 0.85
  double fill;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(9.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
        child: Row(
          children: [
            Container(
              height: 4,
              width: MediaQuery.of(context).size.width * fill,
              decoration: BoxDecoration(
                color: const Color(0xffFFB20A),
                borderRadius: BorderRadius.circular(9.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
