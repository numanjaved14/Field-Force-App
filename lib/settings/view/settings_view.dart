import 'package:field_force_app/auth/view/login.dart';
import 'package:field_force_app/settings/view_model/settings_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/list_item/settings_list_item.dart';

class Settings extends GetView<SettingsViewModel> {
  Settings({super.key});

  SettingsViewModel settingsViewModel = Get.put(SettingsViewModel());

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Obx(
            () => SettingsListItem(
              title: 'Location',
              iconPath: 'assets/icons/location.png',
              iconContainerColor: const Color(0x1000852C),
              onPress: () => {},
              iconColor: const Color(0xFF00852C),
              trailing: CupertinoSwitch(
                // overrides the default green color of the track
                activeColor: Colors.green.shade100,
                // color of the round icon, which moves from right to left
                thumbColor: const Color(0xFF00852C),
                // when the switch is off
                trackColor: Colors.black12,
                // boolean variable value
                value: settingsViewModel.locationServices.value,
                // changes the state of the switch
                onChanged: (value) =>
                    settingsViewModel.locationServices.value = value,
              ),
            ),
          );
        }
        return SettingsListItem(
          title: 'Logout',
          iconPath: 'assets/icons/logout.png',
          iconContainerColor: const Color(0x10DE0C15),
          onPress: () => {
            Get.bottomSheet(
              // ignoreSafeArea: false,
              Container(
                // height: 150,
                padding: const EdgeInsets.only(top: 50, bottom: 100),
                color: const Color(0xFFF5F5F5),
                child: Wrap(
                  children: [
                    const Center(
                      child: Text('Are you sure you want to logout?',
                          textScaleFactor: 1.5),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.offAll(() => Login());
                        },
                        child: const Text("Yes"),
                      ),
                    ),
                  ],
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100),
                ),
              ),
              // enableDrag: true,
            )
          },
          iconColor: const Color(0xFFDE0C15),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
    );
  }
}
