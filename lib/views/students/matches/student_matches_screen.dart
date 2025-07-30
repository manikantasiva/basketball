import 'package:bb_sports/controllers/student_home_controller.dart';
import 'package:bb_sports/utils/color_constants.dart';
import 'package:bb_sports/widgets/compond_shimmer.dart';
import 'package:bb_sports/widgets/custom_rich_text.dart';
import 'package:bb_sports/widgets/match_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentMatchesScreen extends StatelessWidget {
  const StudentMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudentHomeController>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorConstants.grey111,
        appBar: AppBar(
          backgroundColor: ColorConstants.grey111,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back(); // GetX back navigation
            },
          ),
          title: CustomRichText(
            firstText: "Your ",
            secondText: "Matches",
            firstColor: ColorConstants.navyBlue,
            secondColor: Colors.orange,
            firstFontSize: 20,
            secondFontSize: 20,
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                controller.refreshActon();
              },
              icon: const Icon(Icons.refresh, color: Colors.black, size: 22),
            ),
            const SizedBox(width: 8),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            unselectedLabelColor: ColorConstants.navyBlue,
            tabs: [Tab(text: 'Upcoming'), Tab(text: 'Completed')],
          ),
        ),

        body: Obx(() {
          if (controller.isLoading.value) {
            return CompondShimmerWidget();
          }

          final instructor = controller.userData.value;
          if (instructor == null) {
            return const Center(
              child: Text(
                "No User data found",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final upcomingMatches =
              controller.matches
                  .where((match) => match['status'] == "available")
                  .toList();

          final completedMatches =
              controller.matches
                  .where((match) => match['status'] == "completed")
                  .toList();

          return TabBarView(
            children: [
              _buildMatchList(upcomingMatches, "STUDENT"),
              _buildMatchList(completedMatches, "STUDENT"),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildMatchList(List matches, String userType) {
    if (matches.isEmpty) {
      return const Center(
        child: Text("No matches found", style: TextStyle(color: Colors.white)),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children:
            matches
                .map((match) => MatchCard(match: match, userType: userType))
                .toList(),
      ),
    );
  }
}
