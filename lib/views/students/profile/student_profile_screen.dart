import 'package:bb_sports/controllers/student_dashboard_controller.dart';
import 'package:bb_sports/controllers/student_home_controller.dart';
import 'package:bb_sports/utils/color_constants.dart';
import 'package:bb_sports/widgets/build_circular_stat_widget.dart';
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
    final dashController = Get.put(StudentDashboardController());

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

                      const SizedBox(height: 24),
                      Obx(() {
                        final stats = dashController.currentStats;
                        final attendPercent = dashController.attendancePercent;
                        final declinePercent = dashController.declinedPercent;

                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Match Stats",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.navyBlue,
                                    ),
                                  ),
                                  const Spacer(),
                                  DropdownButton<String>(
                                    value: dashController.selectedRange.value,
                                    underline: const SizedBox(),
                                    dropdownColor: Colors.white,
                                    style: const TextStyle(color: Colors.black),
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'last7Days',
                                        child: Text("Last 7 Days"),
                                      ),
                                      DropdownMenuItem(
                                        value: 'last30Days',
                                        child: Text("Last 30 Days"),
                                      ),
                                    ],
                                    onChanged:
                                        (val) =>
                                            dashController.selectedRange.value =
                                                val!,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircularStatWidget(
                                    title: "Attended",
                                    percent: attendPercent,
                                    color: ColorConstants.secondaryDarkColor,
                                  ),
                                  CircularStatWidget(
                                    title: "Declined",
                                    percent: declinePercent,
                                    color: ColorConstants.primaryOrange,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Total: ${stats['total']}",
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    "Attended: ${stats['attended']}",
                                    style: TextStyle(
                                      color: ColorConstants.secondaryDarkColor,
                                    ),
                                  ),
                                  Text(
                                    "Declined: ${stats['declined']}",
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
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
                              dashController.logoutAction();
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
