import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  LocalData._();

  static final LocalData _instance = LocalData._();

  static LocalData get instance => _instance;

  static String email = '';
  static String role = '';
  static String name = '';
  static String token = '';
  static List<String> interests = [];

  static updateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email') ?? '';
    role = prefs.getString('role') ?? '';
    name = prefs.getString('name') ?? '';
    token = prefs.getString('token') ?? '';
  }
}
