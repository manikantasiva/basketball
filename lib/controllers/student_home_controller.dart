// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:bb_sports/utils/logger_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentHomeController extends GetxController with LoggerMixin {
  var isLoading = true.obs;
  var userData = Rxn<Map<String, dynamic>>();
  var matches = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadInstructorHomeData();
  }

  void refreshActon() {
    logger("refresh action student clicked>>>");
    loadInstructorHomeData();
  }

  Future<void> loadInstructorHomeData() async {
    isLoading.value = true;

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userID');
    logger("userId val: $userId");

    if (userId == null) {
      return;
    }

    final userJson = await rootBundle.loadString('assets/data/user_data.json');
    final users = json.decode(userJson) as List<dynamic>;
    final user = users.firstWhereOrNull((u) => u['id'] == userId);

    userData.value = user;

    final matchJson = await rootBundle.loadString(
      'assets/data/match_data.json',
    );
    final matchList = json.decode(matchJson) as List<dynamic>;
    final allMatches = matchList.map((e) => e as Map<String, dynamic>).toList();

    matches.assignAll(allMatches);

    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
  }

  void showSuccessOrFailureDialog(
    BuildContext context, {
    required bool success,
    required String action,
  }) {
    Get.snackbar(
      success ? "Success" : "Failed",
      success
          ? "You have successfully $action the match."
          : "Failed to $action the match.",
      backgroundColor:
          success ? Colors.green.withOpacity(0.7) : Colors.red.withOpacity(0.7),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );
  }
}
