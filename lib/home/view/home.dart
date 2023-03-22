import 'package:field_force_app/home/view_model/home_view_model.dart';
import 'package:field_force_app/profile/view/profile_view.dart';
import 'package:field_force_app/settings/view/settings_view.dart';
import 'package:field_force_app/widgets/others/date_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_menu.dart';

class Home extends GetView<HomeViewModel> {
  Home({Key? key}) : super(key: key);

  final homeController = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        titleSpacing: 25,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome Faizan!',
                  style: TextStyle(
                    color: Color(0xFF272727),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Asst. Zonal Sales Manager',
                  style: TextStyle(
                    color: const Color(0xFF3A3A3A).withAlpha(80),
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const CircleAvatar(
              backgroundColor: Color(0xFF002D72),
              radius: 20,
              child: Text(
                'FM',
                style: TextStyle(
                  color: Color(0xFFF5F5F5),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF5F5F5),
      ),
      body: Obx(() => homeController.hasData.value == true &&
              homeController.hasError.value == false
          ? SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: 0.5,
                    color: const Color(0xFFE2E2E2),
                  ),
                  const DateContainer(),
                  Container(
                    height: 0.5,
                    color: const Color(0xFFE2E2E2),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25.0,
                      right: 25.0,
                      top: 25.0,
                      bottom: 10.0,
                    ),
                    child: homeController.index.value == 0
                        ? const HomeMenu()
                        : homeController.index.value == 1
                            ? Settings()
                            : Profile(),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator.adaptive(),
            )),
      backgroundColor: const Color(0xFFF5F5F5),
      bottomNavigationBar: Obx(
        () => SizedBox(
          height: 70,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFB9C5CE),
                  spreadRadius: 0,
                  blurRadius: 3,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/icons/home.png'),
                      size: 20,
                      color: Color(0xFFB9C5CE),
                    ),
                    label: 'Home',
                    activeIcon: ImageIcon(
                      AssetImage('assets/icons/home.png'),
                      size: 22,
                      color: Color(0xFF002D72),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/icons/settings.png'),
                      size: 20,
                      color: Color(0xFFB9C5CE),
                    ),
                    label: 'Settings',
                    activeIcon: ImageIcon(
                      AssetImage('assets/icons/settings.png'),
                      size: 22,
                      color: Color(0xFF002D72),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/icons/profile.png'),
                      size: 20,
                      color: Color(0xFFB9C5CE),
                    ),
                    label: 'Profile',
                    activeIcon: ImageIcon(
                      AssetImage('assets/icons/profile.png'),
                      size: 22,
                      color: Color(0xFF002D72),
                    ),
                  ),
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: homeController.index.value,
                selectedItemColor: const Color(0xFF002D72),
                unselectedItemColor: const Color(0xFFB9C5CE),
                onTap: homeController.onBottomTap,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 0.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
