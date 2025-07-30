import 'package:get/get.dart';

class InstructorDashboadController extends GetxController {
  final selectedRange = 'last7Days'.obs;
  final allMatchData = {
    "last7Days": {
      "total": 17,
      "upcoming": 5,
      "completed": 12,
    },
    "last30Days": {
      "total": 28,
      "upcoming": 10,
      "completed": 18,
    }
  };

  final allStudentData = {
    "last7Days": {
      "total": 84,
      "active": 74,
      "inactive": 10,
    },
    "last30Days": {
      "total": 120,
      "active": 95,
      "inactive": 25,
    }
  };

  Map<String, dynamic> get matchData => allMatchData[selectedRange.value]!;
  Map<String, dynamic> get studentData => allStudentData[selectedRange.value]!;
  
}
