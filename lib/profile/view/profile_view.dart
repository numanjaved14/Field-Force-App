import 'package:field_force_app/profile/view_controller/profile_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends GetView<ProfileViewController> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('Profile'),
      ),
    );
  }
}
