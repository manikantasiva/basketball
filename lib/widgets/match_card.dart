import 'package:bb_sports/controllers/student_home_controller.dart';
import 'package:bb_sports/utils/color_constants.dart';
import 'package:bb_sports/widgets/confirmation_bottomsheet_widget.dart';
import 'package:bb_sports/widgets/match_details_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MatchCard extends StatelessWidget {
  final Map<String, dynamic> match;
  final String userType;
  const MatchCard({super.key, required this.match, required this.userType});
  @override
  Widget build(BuildContext context) {
    final bool isCompleted =
        (match['status'] ?? '').toLowerCase() == 'completed';
    final StudentHomeController? controller =
        userType == "STUDENT" ? Get.find<StudentHomeController>() : null;
    final String rawDate = match['matchDate'];
    final String startTime = match['startTime'] ?? 'TBD';
    final String endTime = match['endTime'] ?? 'TBD';

    DateTime? parsedDate;
    try {
      parsedDate = DateTime.parse(rawDate);
    } catch (_) {
      parsedDate = null;
    }

    String formattedDate =
        parsedDate != null
            ? DateFormat("d MMMM y").format(parsedDate)
            : rawDate;

    String formattedTime =
        (startTime != 'TBD' && endTime != 'TBD')
            ? "$startTime - $endTime"
            : match['matchTime'] ?? 'TBD';

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => MatchDetailsBottomsheet(match: match),
            );
          },
          child: Container(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                match['matchName'] ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (isCompleted)
                                Container(
                                  margin: const EdgeInsets.only(top: 6),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        size: 16,
                                        color: Colors.green,
                                      ),
                                      const Text(
                                        "Completed",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          if (userType == "STUDENT")
                            Row(
                              children: [
                                Icon(
                                  Icons.person_outline_outlined,
                                  color: ColorConstants.navyBlue,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  match['instructorName'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: ColorConstants.navyBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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
                                "$formattedDate • $formattedTime",
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

                          if (userType == "INSTRUCTOR") ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.group_add_sharp,
                                  size: 20,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "Attending: ${match['attendingStudentCount']}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(width: 12),
                                const Icon(
                                  Icons.group_remove_outlined,
                                  size: 20,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "Declined: ${match['declinedStudentCount']}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
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
                                      controller?.showSuccessOrFailureDialog(
                                        context,
                                        success: true,
                                        action: "attended",
                                      );
                                      controller?.refreshActon();
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
                                      controller?.showSuccessOrFailureDialog(
                                        context,
                                        success: true,
                                        action: "declined",
                                      );
                                      controller?.refreshActon();
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
        ),
      ],
    );
  }
}
