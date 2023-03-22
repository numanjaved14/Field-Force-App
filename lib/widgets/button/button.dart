import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  AppTextButton({
    Key? key,
    required this.onPress,
    required this.text,
    this.showLoader = false,
    this.disable = false,
    this.backgroundColor = const Color(0xFF002D72),
  }) : super(key: key) {
    _textColor = Colors.white;
  }

  AppTextButton.white({
    Key? key,
    required this.onPress,
    required this.text,
    this.showLoader = false,
    this.disable = false,
    this.backgroundColor = Colors.white,
  }) : super(key: key) {
    _textColor = const Color(0xFF2F2E41);
  }

  final Function onPress;
  final String text;
  final bool? showLoader;
  final bool? disable;

  final Color backgroundColor;
  late final Color _textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextButton(
        onPressed: (disable ?? false) ? null : () => onPress.call(),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              backgroundColor,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            )),
        child: (showLoader ?? false)
            ? const SizedBox(
                height: 40,
                width: 30,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.0,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: _textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}
