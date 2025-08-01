import 'package:bb_sports/controllers/add_match_controller.dart';
import 'package:bb_sports/widgets/animated_text_widget.dart';
import 'package:bb_sports/widgets/gradient_button.dart';
import 'package:bb_sports/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class AddMatchBottomSheet extends StatelessWidget {
  AddMatchBottomSheet({super.key});

  final AddMatchController controller = Get.put(AddMatchController());

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.94,
      expand: false,
      builder: (_, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20, child: AnimatedTextWidget()),
                  ],
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 100,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add Match",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: controller.matchNameController,
                          label: 'Match Name',
                          icon: Icons.sports_soccer,
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'Match name is required'
                                      : null,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: controller.dateController,
                          label: 'Date',
                          icon: Icons.date_range,
                          readOnly: true,
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              controller.dateController.text = DateFormat(
                                'yyyy-MM-dd',
                              ).format(picked);
                            }
                          },
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'Date is required'
                                      : null,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: controller.startTimeController,
                          label: 'Start Time',
                          icon: Icons.access_time,
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (time != null) {
                              final now = DateTime.now();
                              final dt = DateTime(
                                now.year,
                                now.month,
                                now.day,
                                time.hour,
                                time.minute,
                              );
                              controller.startTimeController.text = DateFormat(
                                'hh:mm a',
                              ).format(dt);
                            }
                          },
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'Start time is required'
                                      : null,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: controller.endTimeController,
                          label: 'End Time',
                          icon: Icons.access_time_filled,
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (time != null) {
                              final now = DateTime.now();
                              final dt = DateTime(
                                now.year,
                                now.month,
                                now.day,
                                time.hour,
                                time.minute,
                              );
                              controller.endTimeController.text = DateFormat(
                                'hh:mm a',
                              ).format(dt);
                            }
                          },
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'End time is required'
                                      : null,
                        ),
                        const SizedBox(height: 20),

                        CustomTextField(
                          controller: controller.locationController,
                          label: 'Location',
                          icon: Icons.location_on,
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'Location is required'
                                      : null,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                GradientButton(
                  text: "Save",
                  onPressed: () async {
                    if (controller.matchNameController.text.isEmpty ||
                        controller.dateController.text.isEmpty ||
                        controller.startTimeController.text.isEmpty ||
                        controller.endTimeController.text.isEmpty ||
                        controller.locationController.text.isEmpty) {
                      Get.snackbar(
                        "Error",
                        "All fields are required",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    controller.isLoading.value = true;

                    await controller.addNewMatch();

                    controller.isLoading.value = false;

                    Get.back(); 
                  },
                ),
                const SizedBox(height: 44),
              ],
            );
          }),
        );
      },
    );
  }
}
