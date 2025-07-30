import 'package:bb_sports/controllers/student_home_controller.dart';
import 'package:bb_sports/routes/app_routes.dart';
import 'package:bb_sports/utils/color_constants.dart';
import 'package:bb_sports/widgets/compond_shimmer.dart';
import 'package:bb_sports/widgets/custom_rich_text.dart';
import 'package:bb_sports/widgets/instructor_profile_card.dart';
import 'package:bb_sports/widgets/match_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentHomeController());

    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: Obx(() {
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
                      firstText: "Hello ,\n",
                      secondText: '${instructor['name']}',
                      thirdText: "Unlock the Pro ,Train. Improve. Win.",
                      firstColor: ColorConstants.navyBlue,
                      secondColor: ColorConstants.primaryOrange,
                      thirdColor: Colors.black,
                      firstFontSize: 26,
                      secondFontSize: 28,
                      thirdFontSize: 16,
                      textAlign: TextAlign.left,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.studnetProfile);
                      },
                      child: CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.deepOrange,
                        child: Icon(
                          Icons.person,
                          color: ColorConstants.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                InstructorProfileCard(instructor: instructor),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomRichText(
                      firstText: "Upcoming ",
                      secondText: "Matches",
                      firstColor: ColorConstants.navyBlue,
                      secondColor: Colors.orange,
                      firstFontSize: 20,
                      secondFontSize: 20,
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.studentMatches);
                      },
                      child: Text("See All"),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...controller.matches.map(
                  (match) => MatchCard(match: match, userType: "STUDENT"),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
