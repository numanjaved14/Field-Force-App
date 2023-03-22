import 'package:field_force_app/manage/department/department_list/view/department_list.dart';
import 'package:field_force_app/manage/designation/designation_list/view/designation_list.dart';
import 'package:field_force_app/manage/doctor/doctor_list/view/doctor_list.dart';
import 'package:field_force_app/manage/employee/employee_list/view/employee_list.dart';
import 'package:field_force_app/manage/employment_status/employment_status_list/view/employment_status_list.dart';
import 'package:field_force_app/manage/manage_main/view_model/manage_main_controller.dart';
import 'package:field_force_app/manage/office_location/office_location_list/view/office_location_list.dart';
import 'package:field_force_app/manage/permission/permission_list/view/permission_list.dart';
import 'package:field_force_app/manage/product/product_list/view/product_list.dart';
import 'package:field_force_app/manage/rank/rank_list/view/rank_list.dart';
import 'package:field_force_app/manage/role/role_list/view/role_list.dart';
import 'package:field_force_app/manage/team/team_list/view/team_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../home/view/home.dart';
import '../../../widgets/list_item/list_item.dart';
import '../../../widgets/others/date_container.dart';
import '../../city/city_list/view/city_list.dart';
import '../../specialization/specialization_list/view/specialization_list.dart';

class ManageMain extends GetView<ManageMainController> {
  ManageMain({Key? key}) : super(key: key);

  var manageMainController = Get.put(ManageMainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/appbar_back.png',
            width: 25,
            height: 18,
            // color: const Color(0xFFD4D4D4),
          ),
          onPressed: () => Get.off(Home()),
        ),
        title: const Text(
          'Manage',
          style: TextStyle(
            color: Color(0xFF272727),
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color(0x10F5F5F5),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                top: 25.0,
                bottom: 10.0,
              ),
              child: Obx(
                () => controller.isInit.value
                    ? ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          manageMainController.permissionsList.value
                                  .contains('CanViewEmployee')
                              ? ListItem(
                                  title: 'Employees',
                                  subTitle: 'Manage employees',
                                  iconPath: 'assets/icons/employee.png',
                                  iconContainerColor: const Color(0x10DE0C15),
                                  onPress: () => Get.to(() => EmployeeList()),
                                  iconColor: const Color(0xFFDE0C15),
                                )
                              : const SizedBox(height: 0, width: 0),
                          const SizedBox(height: 16),
                          manageMainController.permissionsList.value
                                  .contains('CanViewRole')
                              ? ListItem(
                                  title: 'Roles',
                                  subTitle: 'Manage roles',
                                  iconPath: 'assets/icons/role.png',
                                  iconContainerColor: const Color(0x10DE0C15),
                                  onPress: () => Get.to(() => RoleList()),
                                  iconColor: const Color(0xFFDE0C15),
                                )
                              : const SizedBox(height: 0, width: 0),
                          const SizedBox(height: 16),
                          manageMainController.permissionsList.value
                                  .contains('CanViewPermission')
                              ? ListItem(
                                  title: 'Permissions',
                                  subTitle: 'Manage permissions',
                                  iconPath: 'assets/icons/permission.png',
                                  iconContainerColor: const Color(0x10DE0C15),
                                  onPress: () => Get.to(() => PermissionList()),
                                  iconColor: const Color(0xFFDE0C15),
                                )
                              : const SizedBox(height: 0, width: 0),
                          const SizedBox(height: 16),
                          manageMainController.permissionsList.value
                                  .contains('CanViewOfficeLocation')
                              ? ListItem(
                                  title: 'Office Locations',
                                  subTitle: 'Manage office locations',
                                  iconPath: 'assets/icons/office_location.png',
                                  iconContainerColor: const Color(0x10DE0C15),
                                  onPress: () =>
                                      Get.to(() => OfficeLocationList()),
                                  iconColor: const Color(0xFFDE0C15),
                                )
                              : const SizedBox(height: 0, width: 0),
                          const SizedBox(height: 16),
                          manageMainController.permissionsList.value
                                  .contains('CanViewTeam')
                              ? ListItem(
                                  title: 'Teams',
                                  subTitle: 'Manage teams',
                                  iconPath: 'assets/icons/group.png',
                                  iconContainerColor: const Color(0x10DE0C15),
                                  onPress: () => Get.to(() => TeamList()),
                                  iconColor: const Color(0xFFDE0C15),
                                )
                              : const SizedBox(height: 0, width: 0),
                          const SizedBox(height: 16),
                          manageMainController.permissionsList.value
                                  .contains('CanViewProduct')
                              ? ListItem(
                                  title: 'Products',
                                  subTitle: 'Manage products',
                                  iconPath: 'assets/icons/product.png',
                                  iconContainerColor: const Color(0x10DE0C15),
                                  onPress: () => Get.to(() => ProductList()),
                                  iconColor: const Color(0xFFDE0C15),
                                )
                              : const SizedBox(height: 0, width: 0),
                          const SizedBox(height: 16),
                          manageMainController.permissionsList.value
                                  .contains('CanViewDesignation')
                              ? ListItem(
                                  title: 'Designations',
                                  subTitle: 'Manage designations',
                                  iconPath: 'assets/icons/designation.png',
                                  iconContainerColor: const Color(0x10DE0C15),
                                  onPress: () =>
                                      Get.to(() => DesignationList()),
                                  iconColor: const Color(0xFFDE0C15),
                                )
                              : const SizedBox(height: 0, width: 0),
                          const SizedBox(height: 16),
                          manageMainController.permissionsList.value
                                  .contains('CanViewDepartment')
                              ? ListItem(
                                  title: 'Departments',
                                  subTitle: 'Manage departments',
                                  iconPath: 'assets/icons/department.png',
                                  iconContainerColor: const Color(0x10DE0C15),
                                  onPress: () => Get.to(() => DepartmentList()),
                                  iconColor: const Color(0xFFDE0C15),
                                )
                              : const SizedBox(height: 0, width: 0),
                          const SizedBox(height: 16),
                          manageMainController.permissionsList.value
                                  .contains('CanViewEmploymentStatus')
                              ? ListItem(
                                  title: 'Employment Status',
                                  subTitle: 'Manage employment statuses',
                                  iconPath:
                                      'assets/icons/employment_status.png',
                                  iconContainerColor: const Color(0x10DE0C15),
                                  onPress: () =>
                                      Get.to(() => EmploymentStatusList()),
                                  iconColor: const Color(0xFFDE0C15),
                                )
                              : const SizedBox(height: 0, width: 0),
                          const SizedBox(height: 16),
                          manageMainController.permissionsList.value
                                  .contains('CanViewDoctor')
                              ? ListItem(
                                  title: 'Doctors',
                                  subTitle: 'Manage doctors',
                                  iconPath: 'assets/icons/doctor.png',
                                  iconContainerColor: const Color(0x10DE0C15),
                                  onPress: () => Get.to(() => DoctorList()),
                                  iconColor: const Color(0xFFDE0C15),
                                )
                              : const SizedBox(height: 0, width: 0),
                          const SizedBox(height: 16),
                          manageMainController.permissionsList.value
                                  .contains('CanViewDoctorRank')
                              ? ListItem(
                                  title: 'Ranks',
                                  subTitle: 'Manage ranks',
                                  iconPath: 'assets/icons/group.png',
                                  iconContainerColor: const Color(0x10DE0C15),
                                  onPress: () => Get.to(() => RankList()),
                                  iconColor: const Color(0xFFDE0C15),
                                )
                              : const SizedBox(height: 0, width: 0),
                          const SizedBox(height: 16),
                          manageMainController.permissionsList.value
                                  .contains('CanViewDoctorSpecialization')
                              ? ListItem(
                                  title: 'Specialization',
                                  subTitle: 'Manage doctors specialization',
                                  iconPath: 'assets/icons/stethoscope.png',
                                  iconContainerColor: const Color(0x10DE0C15),
                                  onPress: () =>
                                      Get.to(() => SpecializationList()),
                                  iconColor: const Color(0xFFDE0C15),
                                )
                              : const SizedBox(height: 0, width: 0),
                          const SizedBox(height: 16),
                          manageMainController.permissionsList.value
                                  .contains('CanViewCity')
                              ? ListItem(
                                  title: 'City',
                                  subTitle: 'Manage cities',
                                  iconPath: 'assets/icons/city.png',
                                  iconContainerColor: const Color(0x10DE0C15),
                                  onPress: () => Get.to(() => CityList()),
                                  iconColor: const Color(0xFFDE0C15),
                                )
                              : const SizedBox(height: 0, width: 0),
                          // Text(
                          //     'Data: ${manageMainController.permissionsList.value[0]}'),
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
