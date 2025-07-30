// lib/widgets/instructor_profile_card.dart

import 'package:flutter/material.dart';
import 'package:bb_sports/utils/color_constants.dart';

class InstructorProfileCard extends StatelessWidget {
  final Map<String, dynamic> instructor;

  const InstructorProfileCard({super.key, required this.instructor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstants.primaryOrange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
           CircleAvatar(
            radius: 30,
            backgroundColor: Colors.deepOrange,
            child: Icon(
              Icons.person,
              color: ColorConstants.white,
              size: 40,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${instructor['name']}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.mail, size: 16, color: ColorConstants.white),
                  const SizedBox(width: 6),
                  Text(
                    instructor['email'],
                    style:  TextStyle(color: ColorConstants.white),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(
                    instructor['location'],
                    style:  TextStyle(color: ColorConstants.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
