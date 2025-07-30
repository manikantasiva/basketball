import 'package:bb_sports/controllers/auth_controller.dart';
import 'package:bb_sports/utils/color_constants.dart';
import 'package:bb_sports/widgets/confirmation_bottomsheet_widget.dart';
import 'package:bb_sports/widgets/custom_rich_text.dart';
import 'package:bb_sports/widgets/gradient_button.dart';
import 'package:bb_sports/widgets/instructor_profile_card.dart';
import 'package:bb_sports/widgets/common_shimmer_card.dart';
import 'package:bb_sports/controllers/instructors_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstructorProfileScreen extends StatelessWidget {
  const InstructorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InstructorsHomeController>();

    return Scaffold(
      backgroundColor: ColorConstants.navyBlue,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100),
                  CommonShimmerCard(height: 60, margin: 16),
                  SizedBox(height: 16),
                  CommonShimmerCard(height: 110, margin: 16),
                  SizedBox(height: 32),
                  CommonShimmerCard(height: 24, margin: 16),
                  CommonShimmerCard(height: 100, margin: 16),
                  SizedBox(height: 16),
                  CommonShimmerCard(height: 100, margin: 16),
                ],
              ),
            );
          }

          final instructor = controller.instructorData.value;
          if (instructor == null) {
            return const Center(
              child: Text(
                "No instructor found",
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
                          Expanded(
                            child: CustomRichText(
                              firstText: "Welcome ,\n",
                              secondText: "${instructor['name']}",
                              firstColor: Colors.white,
                              secondColor: Colors.orange,
                              firstFontSize: 20,
                              secondFontSize: 28,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.refreshActon();
                            },
                            child: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 22),
                        ],
                      ),
                      const SizedBox(height: 20),
                      InstructorProfileCard(instructor: instructor),
                      const SizedBox(height: 24),
                      // Add more widgets above logout if needed
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
                            message: "Are you sure you want to logout?",
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
