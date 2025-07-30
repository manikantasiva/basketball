import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMatchController extends GetxController {
  final isLoading = false.obs;

  final matchNameController = TextEditingController();
  final dateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final locationController = TextEditingController();

  late File localJsonFile;
  List<dynamic> matches = [];

  @override
  void onInit() {
    super.onInit();
    loadMatchJson();
  }

  Future<void> loadMatchJson() async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath =
        '${dir.path}/match_data.json'; 
    localJsonFile = File(filePath);

    if (!(await localJsonFile.exists())) {
      final assetData = await rootBundle.loadString(
        'assets/data/match_data.json',
      );
      await localJsonFile.writeAsString(assetData);
    }

    final jsonString = await localJsonFile.readAsString();
    matches = json.decode(jsonString);
  }

  Future<void> addNewMatch() async {
    if (matches.isEmpty) {
      await loadMatchJson(); 
    }
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userID');
    isLoading.value = true;
    final newMatch = {
      "id": matches.length + 1,
      "matchName": matchNameController.text.trim(),
      "matchDate": dateController.text.trim(),
      "matchTime": startTimeController.text.trim(),
      "startTime": startTimeController.text.trim(),
      "endTime": endTimeController.text.trim(),
      "location": locationController.text.trim(),
      "status": "available",
      "instructorId": userId,
      "registeredUsers": [],
    };
    print("payload>>>> $newMatch");
    matches.add(newMatch);
    print('✅ Match saved at: ${localJsonFile.path}');

    await localJsonFile.writeAsString(json.encode(matches));

    clearFields();
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
  }

  void clearFields() {
    matchNameController.clear();
    dateController.clear();
    startTimeController.clear();
    endTimeController.clear();
    locationController.clear();
  }

  @override
  void onClose() {
    matchNameController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    locationController.dispose();
    super.onClose();
  }
}
