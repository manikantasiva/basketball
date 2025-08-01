import 'package:get/get.dart';

class MatchDetailsController extends GetxController {
  final Map<String, dynamic> match;

  MatchDetailsController(this.match);

  List get registeredUsers => match['registeredUsers'] ?? [];

  int get attendingCount =>
      registeredUsers
          .where((u) => (u['status'] ?? '').toLowerCase() == 'attending')
          .length;

  int get declinedCount =>
      registeredUsers
          .where((u) => (u['status'] ?? '').toLowerCase() == 'declined')
          .length;

  String get matchName => match['matchName'] ?? '';
  String get matchDate => _formatDate(match['matchDate']);
  String get startTime => match['startTime'] ?? '';
  String get endTime => match['endTime'] ?? '';
  String get location => match['location'] ?? '';
  String get imageUrl => match['matchImg'] ?? '';
  bool get isCompleted => (match['status'] ?? '').toLowerCase() == 'completed';

  String _formatDate(String? dateString) {
    if (dateString == null) return '';
    try {
      final date = DateTime.parse(dateString);
      return "${date.day} ${_monthName(date.month)} ${date.year}";
    } catch (_) {
      return dateString;
    }
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
