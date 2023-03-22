import 'package:field_force_app/widgets/input_text/text_input_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';

class AppTextInput extends GetView<TextInputController> {
  final inputController = Get.put(TextInputController());

  final bool showLabelArea;
  final String labelText;
  final String iconPath;
  final Color? iconColor;
  final TextEditingController? editingController;
  final Function? validator;

  AppTextInput({
    Key? key,
    this.iconColor,
    this.labelText = "Label",
    this.iconPath = "assets/icons/employeeid.png",
    this.showLabelArea = true,
    this.editingController,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: [
            Image.asset(
              iconPath,
              width: 15,
              height: 15,
              color: iconColor ?? const Color(0xFF002D72),
            ),
            const SizedBox(width: 6),
            Text(
              labelText,
              style: const TextStyle(
                color: Color(0xFFABABAB),
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: false,
          controller: editingController,
          validator: (val) => validator!(val),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            filled: true,
            fillColor: const Color(0xFFF2F4F7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class AppPasswordInput extends GetView<TextPasswordController> {
  final inputController = Get.put(TextPasswordController());

  final bool showLabelArea;
  final String labelText;
  final String iconPath;
  final TextEditingController? editingController;
  final Function? validator;

  AppPasswordInput({
    Key? key,
    this.labelText = "Label",
    this.iconPath = "assets/icons/employeeid.png",
    this.showLabelArea = true,
    this.editingController,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Image.asset(
              iconPath,
              width: 15,
              height: 15,
            ),
            const SizedBox(width: 6),
            Text(
              labelText,
              style: const TextStyle(
                color: Color(0xFFABABAB),
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Obx(
          () => TextFormField(
            obscureText: controller.showObscure.value,
            controller: editingController,
            validator: (val) => validator!(val),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              filled: true,
              fillColor: const Color(0xFFF2F4F7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                splashColor: Colors.transparent,
                onPressed: () => controller.showObscure.value =
                    !controller.showObscure.value,
                icon: Icon(
                  controller.showObscure.value
                      ? CupertinoIcons.eye_slash
                      : CupertinoIcons.eye,
                  color: const Color(0xFFC9C9C9),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppDescriptionTextInput extends GetView<TextInputController> {
  final inputController = Get.put(TextInputController());

  final bool showLabelArea;
  final int? maxLines;
  final String labelText;
  final String iconPath;
  final Color? iconColor;
  final TextEditingController? editingController;
  final Function? validator;

  AppDescriptionTextInput({
    Key? key,
    this.iconColor,
    this.labelText = "Label",
    this.iconPath = "assets/icons/employeeid.png",
    this.showLabelArea = true,
    this.editingController,
    this.validator,
    this.maxLines = 7,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: [
            Image.asset(
              iconPath,
              width: 15,
              height: 15,
              color: iconColor ?? const Color(0xFF002D72),
            ),
            const SizedBox(width: 6),
            Text(
              labelText,
              style: const TextStyle(
                color: Color(0xFFABABAB),
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: maxLines! * 24,
          child: TextFormField(
            maxLines: maxLines,
            obscureText: false,
            controller: editingController,
            validator: (val) => validator!(val),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              filled: true,
              fillColor: const Color(0xFFF2F4F7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppSearchTextInput extends GetView<TextInputController> {
  final inputController = Get.put(TextInputController());

  final bool showLabelArea;
  final String labelText;
  final String iconPath;
  final String hintText;
  final Color? iconColor;
  final TextEditingController? editingController;
  final Function? validator;
  final Function? suggestionFunction;
  final FocusNode focusNode;
  final List<SearchFieldListItem<dynamic>> searchList;

  AppSearchTextInput(
      {Key? key,
      this.iconColor,
      this.labelText = "Label",
      this.iconPath = "assets/icons/employeeid.png",
      this.showLabelArea = true,
      this.editingController,
      this.validator,
      this.suggestionFunction,
      required this.searchList,
      required this.focusNode,
      this.hintText = 'Select'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: [
            Image.asset(
              iconPath,
              width: 15,
              height: 15,
              color: iconColor ?? const Color(0xFF002D72),
            ),
            const SizedBox(width: 6),
            Text(
              labelText,
              style: const TextStyle(
                color: Color(0xFFABABAB),
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SearchField(
          onSuggestionTap: (_) => suggestionFunction!.call(),
          suggestions: searchList,
          controller: editingController,
          validator: (val) => validator!(val),
          focusNode: focusNode,
          hint: hintText,
          searchStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          searchInputDecoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            filled: true,
            fillColor: const Color(0xFFF2F4F7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide.none,
            ),
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.grey,
            ),
          ),
          maxSuggestionsInViewPort: 5,
        ),
      ],
    );
  }
}

class MainSearchTextInput extends GetView<TextInputController> {
  final inputController = Get.put(TextInputController());

  final TextEditingController editingController;
  final Function? validator;
  final Function onChange;
  final Function onFieldSubmit;
  final String hint;
  final FocusNode focusNode;

  MainSearchTextInput({
    Key? key,
    required this.editingController,
    this.validator,
    required this.onChange,
    required this.hint,
    required this.onFieldSubmit,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: false,
      controller: editingController,
      validator: (val) => validator!(val),
      onChanged: (value) => onChange.call(),
      onFieldSubmitted: (value) => onFieldSubmit.call(),
      focusNode: focusNode,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.all(16),
        filled: true,
        hintText: hint,
        fillColor: const Color(0xFFF2F4F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
