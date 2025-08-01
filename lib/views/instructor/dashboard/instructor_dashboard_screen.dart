import 'package:bb_sports/widgets/custom_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:bb_sports/controllers/instructor_dashboad_controller.dart';

class InstructorDashboardScreen extends StatelessWidget {
  const InstructorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InstructorDashboadController());

    return Scaffold(
      backgroundColor: const Color(0xFF0B1D39),

      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              CustomRichText(
                firstText: "Instructor ",
                secondText: "Dashboard",
                firstColor: Colors.white,
                secondColor: Colors.orange,
                firstFontSize: 20,
                secondFontSize: 22,
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          dropdownColor: Colors.blueGrey[700],
                          value: controller.selectedRange.value,
                          style: const TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.white,
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
                              (val) => controller.selectedRange.value = val!,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildMetricCard("Matches", controller.matchData, isMatch: true),
              const SizedBox(height: 20),
              _buildMetricCard(
                "Students",
                controller.studentData,
                isMatch: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(
    String title,
    Map<String, dynamic> data, {
    required bool isMatch,
  }) {
    final percent =
        isMatch
            ? (data['completed'] / data['total'])
            : (data['inactive'] / data['total']);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF112A4C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isMatch) ...[
                      _metricRow("Upcoming", data['upcoming']),
                      _metricRow("Completed", data['completed']),
                    ] else ...[
                      _metricRow("Active", data['active']),
                      _metricRow("Inactive", data['inactive']),
                    ],
                    _metricRow("Total", data['total']),
                  ],
                ),
              ),
              Expanded(
                child: CircularPercentIndicator(
                  radius: 50,
                  lineWidth: 12,
                  percent: percent.clamp(0.0, 1.0),
                  center: Text(
                    "${(percent * 100).toStringAsFixed(0)}%",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  progressColor:
                      isMatch ? Colors.orangeAccent : Colors.deepOrange,
                  backgroundColor: Colors.blueGrey.shade700,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metricRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(
            "$value",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
