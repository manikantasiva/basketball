import 'package:bb_sports/controllers/student_home_controller.dart';
import 'package:bb_sports/utils/color_constants.dart';
import 'package:bb_sports/widgets/confirmation_bottomsheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchCard extends StatelessWidget {
  final Map<String, dynamic> match;
  final String userType;

  const MatchCard({super.key, required this.match, required this.userType});

  @override
  Widget build(BuildContext context) {
    final bool isCompleted =
        (match['status'] ?? '').toLowerCase() == 'completed';
    final controller = Get.find<StudentHomeController>();

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ColorConstants.grey111,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 24,
                    child: Icon(Icons.sports_basketball, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          match['matchName'] ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        if (userType == "STUDENT")
                          Text(
                            match['instructorName'] ?? '',
                            style: const TextStyle(
                              fontSize: 13,
                              color: ColorConstants.navyBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_rounded,
                              size: 14,
                              color: Colors.black54,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${match['matchDate']} • ${match['matchTime'] ?? 'TBD'}",
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.black54,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              match['location'] ?? '',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),

                        /// Completed Chip
                        if (isCompleted)
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Completed",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Icon(Icons.groups, color: Colors.orange),
                      Text(
                        "${match['registeredUsersCount']} Joined",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              if (userType == "STUDENT" && !isCompleted) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder:
                                (_) => ConfirmationCommonBottomSheet(
                                  message:
                                      "Are you sure you want to attend this match?",
                                  onConfirm: () {
                                    controller.showSuccessOrFailureDialog(
                                      context,
                                      success: true,
                                      action: "attended",
                                    );
                                    controller.refreshActon();
                                  },
                                ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.green),
                          foregroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Attend'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder:
                                (_) => ConfirmationCommonBottomSheet(
                                  message:
                                      "Are you sure you want to decline this match?",
                                  onConfirm: () {
                                    controller.showSuccessOrFailureDialog(
                                      context,
                                      success: true,
                                      action: "declined",
                                    );
                                    controller.refreshActon();
                                  },
                                ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.red),
                          foregroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Decline'),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        if (isCompleted)
          Positioned(
            right: 12,
            top: 12,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}
