import 'package:bb_sports/controllers/auth_controller.dart';
import 'package:bb_sports/controllers/student_home_controller.dart';
import 'package:bb_sports/utils/color_constants.dart';
import 'package:bb_sports/widgets/compond_shimmer.dart';
import 'package:bb_sports/widgets/confirmation_bottomsheet_widget.dart';
import 'package:bb_sports/widgets/custom_rich_text.dart';
import 'package:bb_sports/widgets/gradient_button.dart';
import 'package:bb_sports/widgets/instructor_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudnetProfileScreen extends StatelessWidget {
  const StudnetProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudentHomeController>();

    return Scaffold(
      backgroundColor: ColorConstants.grey111,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return CompondShimmerWidget();
          }

          final instructor = controller.userData.value;
          if (instructor == null) {
            return const Center(
              child: Text(
                "No User Data found",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: ColorConstants.navyBlue,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 22),
                          Expanded(
                            child: CustomRichText(
                              firstText: "Welcome ,\n",
                              secondText: "${instructor['name']}",
                              firstColor: ColorConstants.navyBlue,
                              secondColor: Colors.orange,
                              firstFontSize: 20,
                              secondFontSize: 28,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      InstructorProfileCard(instructor: instructor),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: GradientButton(
                  text: "Logout",
                  onPressed: () async {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder:
                          (_) => ConfirmationCommonBottomSheet(
                            message:
                                "Hey learner !, \nAre you sure you want to logout?",
                            onConfirm: () {
                              Get.find<AuthController>().logoutAction();
                            },
                          ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30),
            ],
          );
        }),
      ),
    );
  }
}
