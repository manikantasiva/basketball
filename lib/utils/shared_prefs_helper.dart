import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static Future<void> saveUser({
    required int id,
    required String name,
    required String type, 
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userID', id);
    await prefs.setString('userName', name);
    await prefs.setString('userType', type);
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('userID');
    final name = prefs.getString('userName');
    final type = prefs.getString('userType');

    if (id != null && name != null && type != null) {
      return {'id': id, 'name': name, 'type': type};
    }
    return null;
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
