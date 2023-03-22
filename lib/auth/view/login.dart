import 'package:field_force_app/auth/view_model/auth_view_model.dart';
import 'package:field_force_app/utils/app_utils.dart';
import 'package:field_force_app/widgets/button/button.dart';
import 'package:field_force_app/widgets/input_text/app_text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends GetView<AuthViewModel> {
  Login({Key? key}) : super(key: key);

  TextEditingController? employeeIdController = TextEditingController();
  TextEditingController? passController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/logo.png'),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to Biocare Pharmaceutica',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Arial',
                  ),
                ),
                Text(
                  'Enter login credentials to proceed',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    color:
                        AppUtils.createMaterialColor(const Color(0xFFABABAB)),
                  ),
                ),
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: AppTextInput(
                    iconPath: 'assets/icons/employeeid.png',
                    labelText: 'Employee Id',
                    editingController: employeeIdController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "* Required";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: AppPasswordInput(
                    iconPath: 'assets/icons/lock.png',
                    labelText: 'Password',
                    editingController: passController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "* Required";
                      } else if (value.length < 6) {
                        return "Password should be atleast 6 characters";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => AppTextButton(
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                return controller.onLoginPressed(
                                    emyployeeId: employeeIdController!.text,
                                    pass: passController!.text);
                              }
                            },
                            showLoader: controller.showProgress.value,
                            disable: controller.showProgress.value,
                            text: 'Login',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFF2F2E41),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
