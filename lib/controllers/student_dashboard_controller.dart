import 'package:bb_sports/routes/app_routes.dart';
import 'package:bb_sports/utils/shared_prefs_helper.dart';
import 'package:get/get.dart';

class StudentDashboardController extends GetxController {
  final selectedRange = 'last7Days'.obs;

  final matchStats = {
    "last7Days": {
      "total": 10,
      "attended": 7,
      "declined": 3,
    },
    "last30Days": {
      "total": 20,
      "attended": 14,
      "declined": 6,
    }
  };

  Map<String, dynamic> get currentStats => matchStats[selectedRange.value]!;

  double get attendancePercent =>
      (currentStats["total"] == 0)
          ? 0
          : currentStats["attended"] / currentStats["total"];

  double get declinedPercent =>
      (currentStats["total"] == 0)
          ? 0
          : currentStats["declined"] / currentStats["total"];

          void logoutAction() async {
    await SharedPrefsHelper.clearUser();
    Get.offAllNamed(AppRoutes.login);
  }
}
