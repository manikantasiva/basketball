import 'package:bb_sports/routes/app_routes.dart';
import 'package:bb_sports/widgets/compond_shimmer.dart';
import 'package:bb_sports/widgets/custom_rich_text.dart';
import 'package:bb_sports/widgets/instructor_profile_card.dart';
import 'package:bb_sports/widgets/match_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bb_sports/controllers/instructors_home_controller.dart';
import 'package:bb_sports/utils/color_constants.dart';

class InstructorHomeScreen extends StatelessWidget {
  const InstructorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InstructorsHomeController());
    return Scaffold(
      backgroundColor: ColorConstants.navyBlue,
      body: Obx(() {
        if (controller.isLoading.value) {
          return CompondShimmerWidget();
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
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomRichText(
                      firstText: "Unlock the ",
                      secondText: "Pro",
                      thirdText: "Train. Improve. Win.",
                      firstColor: Colors.white,
                      secondColor: Colors.orange,
                      thirdColor: Colors.white70,
                      firstFontSize: 30,
                      secondFontSize: 32,
                      thirdFontSize: 20,
                      textAlign: TextAlign.center,
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
                  ],
                ),
                const SizedBox(height: 20),

                InstructorProfileCard(instructor: instructor),

                const SizedBox(height: 24),

                CustomRichText(
                  firstText: "Upcoming ",
                  secondText: "Matches",
                  firstColor: Colors.white,
                  secondColor: Colors.orange,
                  firstFontSize: 20,
                  secondFontSize: 20,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                ...controller.matches.map(
                  (match) => MatchCard(match: match, userType: "INSTRUCTOR"),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
