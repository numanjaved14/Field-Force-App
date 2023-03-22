import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/icons/calendar.png',
            width: 17,
            height: 17,
          ),
          const SizedBox(width: 8),
          Text(DateFormat.yMMMMEEEEd().format(DateTime.now()))
        ],
      ),
    );
  }
}
