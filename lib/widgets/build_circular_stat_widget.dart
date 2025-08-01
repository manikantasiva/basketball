import 'package:bb_sports/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularStatWidget extends StatelessWidget {
  final String title;
  final double percent;
  final Color color;

  const CircularStatWidget({
    super.key,
    required this.title,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 45,
          lineWidth: 10,
          percent: percent.clamp(0.0, 1.0),
          center: Text(
            "${(percent * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              color: ColorConstants.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          progressColor: color,
          backgroundColor: Colors.grey.shade800,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
