// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:bb_sports/routes/app_routes.dart';
import 'package:bb_sports/utils/color_constants.dart';
import 'package:bb_sports/utils/logger_mixin.dart';
import 'package:bb_sports/utils/shared_prefs_helper.dart';
import 'package:bb_sports/views/instructor/main/instructor_main_screen.dart';
import 'package:bb_sports/views/students/home/student_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AuthController extends GetxController with LoggerMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var loginType = 'instructor'.obs;

  void toggleLoginType(String type) {
    loginType.value = type;
  }

  void loginAction() async {
    if (formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final type = loginType.value;

      final String jsonString = await rootBundle.loadString(
        'assets/data/user_data.json',
      );
      final List<dynamic> users = json.decode(jsonString);

      final matchedUser = users.firstWhereOrNull(
        (user) =>
            user['email'] == email &&
            user['password'] == password &&
            user['type'] == type,
      );

      if (matchedUser != null) {
        await SharedPrefsHelper.saveUser(
          id: matchedUser['id'],
          name: matchedUser['name'],
          type: matchedUser['type'],
        );

        Get.snackbar(
          "Login Success",
          "Welcome ${matchedUser['name']}!",
          snackPosition: SnackPosition.BOTTOM,
        );
        emailController.clear();
        passwordController.clear();
        Get.to(
          () =>
              type == 'instructor'
                  ? InstructorMainScreen()
                  : StudentHomeScreen(),
        );
      } else {
        Get.snackbar(
          "Login Failed",
          "Invalid credentials or user type",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorConstants.red.withOpacity(0.6),
          colorText: ColorConstants.black,
        );
      }
    }
  }

  void logoutAction() async {
    await SharedPrefsHelper.clearUser();

    Get.offAllNamed(AppRoutes.login);
  }
}
