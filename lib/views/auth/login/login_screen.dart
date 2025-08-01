import 'package:bb_sports/controllers/auth_controller.dart';
import 'package:bb_sports/utils/color_constants.dart';
import 'package:bb_sports/widgets/custom_rich_text.dart';
import 'package:bb_sports/widgets/custom_text_field.dart';
import 'package:bb_sports/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Image.asset(
                            "assets/images/basketball.png",
                            width: 220,
                            height: 220,
                          ),
                          const SizedBox(height: 20),
                          CustomRichText(
                            firstText: "🏀 Basketball ",
                            secondText: "Academy",
                            firstColor: ColorConstants.navyBlue,
                            secondColor: ColorConstants.primaryOrange,
                            firstFontSize: 26,
                            secondFontSize: 30,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          ToggleButtons(
                            borderRadius: BorderRadius.circular(10),
                            isSelected: [
                              controller.loginType.value == 'instructor',
                              controller.loginType.value == 'student',
                            ],
                            onPressed: (index) {
                              controller.toggleLoginType(
                                index == 0 ? 'instructor' : 'student',
                              );
                            },
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text("Login as Instructor"),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text("Login as Student"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            controller: controller.emailController,
                            label: 'Email',
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              if (!GetUtils.isEmail(value)) {
                                return 'Enter valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: controller.passwordController,
                            label: 'Password',
                            icon: Icons.lock,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          GradientButton(
                            onPressed: () => controller.loginAction(),
                            text: 'Login',
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
