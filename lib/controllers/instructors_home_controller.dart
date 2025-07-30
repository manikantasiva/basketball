import 'dart:convert';
import 'package:bb_sports/utils/logger_mixin.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstructorsHomeController extends GetxController with LoggerMixin {
  var isLoading = true.obs;
  var instructorData = Rxn<Map<String, dynamic>>();
  var matches = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadInstructorHomeData();
  }

  void refreshActon() {
    logger("refresh action clicked>>>");
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

    instructorData.value = user;

    final matchJson = await rootBundle.loadString(
      'assets/data/match_data.json',
    );
    final matchList = json.decode(matchJson) as List<dynamic>;
    final userMatches =
        matchList
            .where((m) => m['instructorId'] == userId)
            .map((e) => e as Map<String, dynamic>)
            .toList();

    matches.assignAll(userMatches);
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
  }
}
