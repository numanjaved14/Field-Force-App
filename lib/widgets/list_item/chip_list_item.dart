import 'package:flutter/material.dart';

class ChipListItem extends StatelessWidget {
  String text;
  Function onTap;
  ChipListItem({required this.text, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadiusDirectional.circular(36)),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
            ),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () => onTap.call(),
              child: SizedBox(
                  height: 10,
                  width: 10,
                  child: Image.asset('assets/icons/cancel.png')),
            ),
          ],
        ),
      ),
    );
  }
}
